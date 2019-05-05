defmodule MMS.ValueLengthTest do
  use MMS.CodecTest
  alias MMS.CodecTest.{Ok, Error}

  alias MMS.ValueLength
  import ValueLength

  def max_short_length_value, do: String.duplicate("a", max_short_length())
  def max_short_length_bytes, do: <<max_short_length()>> <> max_short_length_value()

  def min_uint32_length,       do: max_short_length() + 1
  def min_uint32_length_value, do: String.duplicate("a", min_uint32_length())
  def min_uint32_length_bytes, do: <<min_uint32_length()>> <> min_uint32_length_value()

  describe "decode/1" do
    test "with a short length" do
      assert decode(<<0>>) == ok 0, <<>>
      assert decode(max_short_length_bytes()) == ok max_short_length(), max_short_length_value()
    end
    test "with a length quote and valid length" do

      assert decode(<<length_quote()>> <> min_uint32_length_bytes()) == ok min_uint32_length(), min_uint32_length_value()
    end

    test "with no bytes" do
      assert decode(<<>>) == error :value_length, <<>>, :no_bytes
    end

    test "with an unnecessary length quote" do
      assert decode(<<length_quote(), max_short_length()>>) == error :value_length, <<length_quote(), max_short_length()>>, :should_be_encoded_as_a_short_length
    end

    test "with no short length or length quote" do
      assert decode(<<"a">>) == error {:value_length, <<"a">>, :does_not_start_with_a_short_length_or_length_quote}
    end

    test "with an invalid length" do
      assert decode(<<length_quote(), 128>>) == error :value_length, <<length_quote(), 128>>, [:uintvar_integer, :first_byte_cannot_be_128]
    end
  end

  describe "decode/2" do
    test "when function returns ok" do
      assert ValueLength.decode(<<1, 42>>, &Ok.decode/1) == ok 42, <<>>
    end

    test "function returns an error" do
      assert ValueLength.decode(<<1, 42>>, &Error.decode/1) == error :data_type, <<1, 42>>, :reason
    end

    test "when incorrect number of bytes consumed" do
      assert ValueLength.decode(<<0, 42>>, &Ok.decode/1) == error :value_length, <<0, 42>>, %{value_length: 0, bytes_used: 1, value: 42}
    end

    test "when insufficient bytes" do
      assert ValueLength.decode(<<1>>, &Ok.decode/1) == error :value_length, <<1>>, [:short_length, required_bytes: 1, available_bytes: 0]
    end
  end

  describe "encode" do
    test "with a short length" do
      assert encode(0)                  == ok <<0>>
      assert encode(max_short_length()) == ok <<max_short_length()>>
    end

    test "with a uint32 length" do
      assert encode(max_short_length() + 1) == ok <<length_quote(), max_short_length() + 1>>
      assert encode(max_uintvar_integer())           == ok <<length_quote()>> <> max_uintvar_integer_bytes()
    end

    test "with an invalid integer" do
      assert encode(-1) == error :value_length, -1, [:uintvar_integer, :out_of_range]
    end
  end

  describe "encode/2" do
    test "when function return ok" do
      assert encode(0, &Ok.encode/1) == ok <<1, 0>>
    end

    test "function returns an error" do
      assert encode(0, &Error.encode/1) == error :data_type, 0, :reason
    end
  end
end
