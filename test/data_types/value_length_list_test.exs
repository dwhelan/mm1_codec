defmodule MMS.ValueLengthListTest do
  use MMS.CodecTest

  import MMS.ValueLengthList

  def decode_ok(<<value , rest::binary>>), do: ok value, rest
  def decode_error(bytes),                 do: error :data_type, bytes, :details

  @bytes <<l(2), 3, 4, 5>>

  describe "decode should" do
    test "return a list of decoded values" do
      assert decode(@bytes, [&decode_ok/1, &decode_ok/1]) == ok [3, 4], <<5>>
    end

    test "return an error if an error decoding value length" do
      assert decode(<<"bytes">>, [&decode_ok/1]) == error :value_length, <<"bytes">>, :does_not_start_with_a_short_length_or_length_quote
    end

    test "return an error if too few bytes used" do
      assert decode(@bytes, [&decode_ok/1]) == error :value_length_list, @bytes, %{length: 2, values: [3], bytes_used: 1}
    end

    test "return an error if too many bytes used" do
      assert decode(@bytes, [&decode_ok/1, &decode_ok/1, &decode_ok/1]) == error :value_length_list, @bytes, %{length: 2, values: [3, 4, 5], bytes_used: 3}
    end

    test "return an error if first decoder returns an error" do
      decoder_error = {:data_type, <<3, 4, 5>>, :details}
      assert decode(@bytes, [&decode_error/1]) == error :value_length_list, @bytes, [:list, %{length: 2, values: [], error: decoder_error}]
    end

    test "return an error if subsequent decoder returns an error" do
      decoder_error = {:data_type, <<4, 5>>, :details}
      assert decode(@bytes, [&decode_ok/1, &decode_error/1]) == error :value_length_list, @bytes, [:list, %{length: 2, values: [3], error: decoder_error}]
    end
  end


  def encode_ok(value),    do: ok <<value>>
  def encode_error(value), do: error :data_type, value, :details

  describe "encode should" do
    test "encode an empty list of values" do
      assert encode([], [&encode_ok/1]) == ok <<l(0)>>
    end

    test "encode a single value" do
      assert encode([3], [&encode_ok/1]) == ok <<l(1), 3>>
    end

    test "encode multiple values" do
      assert encode([3, 4], [&encode_ok/1, &encode_ok/1]) == ok <<l(2), 3, 4>>
    end

    test "return an error if any encoder returns an error" do
      assert encode([3, 4, 5], [&encode_ok/1, &encode_error/1, &encode_ok/1]) == error [<<3>>, error(:data_type, 4, :details)]
    end
  end
end
