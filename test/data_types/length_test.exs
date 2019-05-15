defmodule MMS.LengthTest do
  use MMS.CodecTest
  alias MMS.CodecTest.{Ok, Error}

  import MMS.Length
  alias MMS.ValueLength

  @max max_uintvar_integer()
  @max_bytes max_uintvar_integer_bytes()

  codec_examples [
    {"0", <<0>>, 0},
    {"max uintvar integer", @max_bytes, @max},
  ]

  decode_errors [
    {"128 as first byte", <<128>>},
  ]

  encode_errors [
    {"negative", -1},
  ]

  describe "decode_with_length/3" do
    test "when function returns ok" do
      assert decode_with_length(<<1, 42>>, ValueLength, Ok) == ok 42, <<>>
    end

    test "function returns an error" do
      bytes = <<1, 42>>
      assert decode_with_length(bytes, ValueLength, Error) == error :length_test, bytes, data_type: :reason
    end

    test "when incorrect number of bytes consumed" do
      assert decode_with_length(<<2, 42, 0>>, ValueLength, Ok) == error :length_test, <<2, 42, 0>>, required_bytes: 2, used_bytes: 1
    end

    test "when insufficient bytes" do
      assert decode_with_length(<<1>>, ValueLength, Ok) == error :length_test, <<1>>, value_length: [short_length: [required_bytes: 1, available_bytes: 0], quoted_length: :does_not_start_with_a_length_quote]
    end
  end

  describe "encode_with_length/3" do
    test "when function return ok" do
      assert encode_with_length(0, ValueLength, Ok) == ok <<1, 0>>
    end

    test "function returns an error" do
      assert encode_with_length(0, ValueLength, Error) == error :length_test, 0, data_type: :reason
    end
  end
end
