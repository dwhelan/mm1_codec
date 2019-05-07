defmodule MMS.ValueLengthTest do
  use MMS.CodecTest
  alias MMS.CodecTest.{Ok, Error}

  alias MMS.ValueLength
  import ValueLength

  @thirty_chars String.duplicate("a", 30)

  codec_examples [
    {"min short length", {<<0>>, <<>>}, 0},
    {"max short length", {<<30>>, @thirty_chars}, 30},
    {"min quoted length", <<length_quote(), min_quoted_length()>>, min_quoted_length()},
    {"max quoted length", <<length_quote()>> <> max_uintvar_integer_bytes(), max_uintvar_integer()},
  ]

  decode_errors [
    {"length error", <<5, "rest">>, [short_length: [required_bytes: 5, available_bytes: 4], quoted_length: :does_not_start_with_a_length_quote]},
  ]

  encode_errors [
    {"length error", "a", short_length: :out_of_range, quoted_length: :out_of_range},
  ]

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
      assert ValueLength.decode(<<1>>, &Ok.decode/1) == error :value_length, <<1>>, [{:short_length, [required_bytes: 1, available_bytes: 0]}, {:quoted_length, :does_not_start_with_a_length_quote}]
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
