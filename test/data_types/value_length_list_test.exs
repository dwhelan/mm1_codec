defmodule MMS.ValueLengthListTest do
  use MMS.CodecTest
  alias MMS.CodecTest.{Ok, Error}

  import MMS.ValueLengthList

  @bytes <<l(2), 3, 4, 5>>

  describe "decode should" do
    test "return a list of decoded values" do
      assert decode(@bytes, [Ok, Ok]) == ok [3, 4], <<5>>
    end

    test "return an error if an error decoding value length" do
      assert decode(<<"bytes">>, [Ok]) == error :value_length, <<"bytes">>, :does_not_start_with_a_short_length_or_length_quote
    end

    test "return an error if too few bytes used" do
      assert decode(@bytes, [Ok]) == error :value_length_list, @bytes, %{length: 2, values: [3], bytes_used: 1}
    end

    test "return an error if too many bytes used" do
      assert decode(@bytes, [Ok, Ok, Ok]) == error :value_length_list, @bytes, %{length: 2, values: [3, 4, 5], bytes_used: 3}
    end

    test "return an error if first decoder returns an error" do
      decoder_error = {:data_type, <<3, 4, 5>>, :reason}
      assert decode(@bytes, [Error]) == error :value_length_list, @bytes, [:list, %{length: 2, values: [], error: decoder_error}]
    end

    test "return an error if subsequent decoder returns an error" do
      decoder_error = {:data_type, <<4, 5>>, :reason}
      assert decode(@bytes, [Ok, Error]) == error :value_length_list, @bytes, [:list, %{length: 2, values: [3], error: decoder_error}]
    end
  end

  describe "encode should" do
    test "encode an empty list of values" do
      assert encode([], []) == ok <<l(0)>>
    end

    test "encode a single value" do
      assert encode([3], [Ok]) == ok <<l(1), 3>>
    end

    test "encode multiple values" do
      assert encode([3, 4], [Ok, Ok]) == ok <<l(2), 3, 4>>
    end

    test "return an error if any encoder returns an error" do
      assert encode([3, 4, 5], [Ok, Error, Ok]) == error :list, [3, 4, 5], {:data_type, 4, :reason}
    end
  end
end
