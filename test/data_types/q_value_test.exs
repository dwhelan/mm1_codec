defmodule QValue.DecodeTest do
  use DecodeTest

  import QValue.Decode

  test "00",  do: assert decode(uint32 1)    == ok "00",  <<>>
  test "99",  do: assert decode(uint32 100)  == ok "99",  <<>>
  test "001", do: assert decode(uint32 101)  == ok "001", <<>>
  test "999", do: assert decode(uint32 1099) == ok "999", <<>>

  test "<<>>",    do: assert decode(<<>>)        == error :insufficient_bytes, <<>>
  test "<<0>>",   do: assert decode(<<0>>)       == error :invalid_q_value, <<0>>, 0
  test "<<128>>", do: assert decode(<<128>>)     == error :invalid_uint32
  test "1100",    do: assert decode(uint32 1100) == error :invalid_q_value, uint32(1100), 1100
end

defmodule QValue.EncodeTest do
  use EncodeTest

  import QValue.Encode

  test "00",  do: assert encode("00")  == ok uint32(1)
  test "99",  do: assert encode("99")  == ok uint32(100)
  test "001", do: assert encode("001") == ok uint32(101)
  test "999", do: assert encode("999") == ok uint32(1099)

  test "1000", do: assert encode("1000") == error :invalid_q_value, "1000"
  test "abcd", do: assert encode("abcd") == error :invalid_q_value, "abcd"
end

defmodule MMS.QValueTest do
  use MMS.Test

  use MMS.TestExamples,
      codec: MMS.QValue,

      examples: [
        # single byte: 2 decimal places
        { <<1>>,   "0.00" },
        { <<2>>,   "0.01" },
        { <<3>>,   "0.02" },
        { <<11>>,  "0.10" },
        { <<100>>, "0.99" },

        # single byte: 3 decimal places
        { <<101>>, "0.001" },
        { <<102>>, "0.002" },
        { <<127>>, "0.027" },

        # two bytes: 3 decimal places
        { <<129,  0>>, "0.028" },
        { <<129,  1>>, "0.029" },
        { <<136, 75>>, "0.999" },
      ],

      decode_errors: [
        { <<128>>,            :invalid_qvalue }, # Uint32 error
        { <<136, 76>>,        :invalid_qvalue }, # 1.000
        { max_uint32_bytes(), :invalid_qvalue }, # > 1.0
      ],

      encode_errors: [
        { "0.9995",       :invalid_qvalue }, # rounds to 1.000
        { "0.00x",        :invalid_qvalue },
        { "x",            :invalid_qvalue },
        { :not_a_q_value, :invalid_qvalue },
      ]
end

