defmodule QValue.DecodeTest do
  use DecodeTest

  import QValue.Decode

  def uint32 value do
    value |> MMS.Uint32.encode |> elem(1)
  end

  def invalid_uint32 do
    <<128>>
  end

  test "with no bytes" do
    assert decode(<<>>) == error :insufficient_bytes, <<>>
  end

  test("0") do
    assert decode(uint32 0) == error :invalid_q_value, 0
  end

  test("1") do
    assert decode(uint32 1) == ok "0.00", <<>>
  end

  test "100" do
    assert decode(uint32 100) == ok "0.99", <<>>
  end

  test "101" do
    assert decode(uint32 101) == ok "0.001", <<>>
  end

  test "1099" do
    assert decode(uint32 1099) == ok "0.999", <<>>
  end

  test "1100" do
    assert decode(uint32 1100) == error :invalid_q_value, 1100
  end

  test "invalid uint32" do
    assert decode(invalid_uint32()) == error :invalid_uint32
  end
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

