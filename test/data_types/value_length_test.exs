defmodule MMS.ValueLengthTest do
  use MMS.CodecTest
  alias MMS.CodecTest.{Ok, Error}

  import MMS.ValueLength

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
      assert decode(<<length_quote(), 128>>) == error :value_length, <<length_quote(), 128>>, [:length, :uint32, :first_byte_cannot_be_128]
    end
  end

  describe "decode/2 with a codec" do
    test "when codec return ok" do
      assert decode(<<1, 42>>, Ok) == ok 42,  <<>>
    end

    test "codec returns an error" do
      assert decode(<<1, 42>>, Error) == error :data_type, <<1, 42>>, :reason
    end

    test "when incorrect number of bytes consumed" do
      assert decode(<<0, 42>>, Ok) == error :value_length, <<0, 42>>, %{value_length: 0, bytes_used: 1, value: 42}
    end

    test "when insufficient bytes" do
      assert decode(<<1>>, Ok) == error :value_length, <<1>>, %{available_bytes: 0, short_length: 1}
    end
  end

  describe "encode" do
    test "with a short length" do
      assert encode(0)                  == ok <<0>>
      assert encode(max_short_length()) == ok <<max_short_length()>>
    end

    test "with a uint32 length" do
      assert encode(max_short_length() + 1) == ok <<length_quote(), max_short_length() + 1>>
      assert encode(max_uint32())           == ok <<length_quote()>> <> max_uint32_bytes()
    end

    test "with an invalid integer" do
      assert encode(-1) == error :value_length, -1, [:length, :uint32, :out_of_range]
    end
  end
end
