defmodule MMS.ValueLengthTest do
  use MMS.CodecTest

  @length_quote 31

  import MMS.ValueLength

  @thirty_chars     String.duplicate("a", 30)
  @thirty_one_chars String.duplicate("a", 31)

  describe "decode" do
    test "with a short length" do
      assert decode(<<0>>)                 == ok 0,  <<>>
      assert decode(<<30, @thirty_chars>>) == ok 30, <<@thirty_chars>>
    end

    test "with a length quote and valid length" do
      assert decode(<<@length_quote, 31, @thirty_one_chars>>) == ok 31, <<@thirty_one_chars>>
    end

    test "with no bytes" do
      assert decode(<<>>) == error :invalid_value_length, <<>>, :no_bytes
    end

    test "with an unnecessary length quote" do
      assert decode(<<@length_quote, 30>>) == error :invalid_value_length, <<@length_quote, 30>>, :should_be_encoded_as_a_short_length
    end

    test "with no short length or length quote" do
      assert decode(<<"a">>) == error {:invalid_value_length, <<"a">>, :does_not_start_with_a_short_length_or_length_quote}
    end

    test "with an invalid length" do
      assert {:error, {:invalid_value_length, <<@length_quote, 128>>, {:invalid_length, _, _}}} = decode(<<@length_quote, 128>>)
    end
  end

  describe "encode" do
    test "with a short length" do
      assert encode(0)                  == ok <<0>>
      assert encode(max_short_length()) == ok <<max_short_length()>>
    end

    test "with a uint32 length" do
      assert encode(max_short_length() + 1) == ok <<@length_quote, max_short_length() + 1>>
      assert encode(max_uint32())           == ok <<@length_quote>> <> max_uint32_bytes()
    end

    test "with an invalid integer" do
      assert encode(-1) == error :invalid_value_length, -1, {:invalid_length, -1, {:invalid_uint32, -1, :out_of_range}}
    end
  end
end
