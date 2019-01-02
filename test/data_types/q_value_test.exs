defmodule MMS.QValueTest do
  use ExUnit.Case
  import MMS.DataTypes

  use MMS.TestExamples,
      codec: MMS.QValue,
      examples: [
        # single byte: 2 decimal places
        {<<1>>,   "0.00"},
        {<<2>>,   "0.01"},
        {<<3>>,   "0.02"},
        {<<11>>,  "0.10"},
        {<<100>>, "0.99"},

        # single byte: 3 decimal places
        {<<101>>, "0.001"},
        {<<102>>, "0.002"},
        {<<127>>, "0.027"},

        # two bytes: 3 decimal places
        {<<129,  0>>, "0.028"},
        {<<129,  1>>, "0.029"},
        {<<136, 75>>, "0.999"},
      ],

      decode_errors: [
        { <<128>>,            :invalid_qvalue }, # Uint32 error
        { <<136, 76>>,        :invalid_qvalue }, # 1.000
        { max_uint32_bytes(), :invalid_qvalue }, #
      ],

      encode_errors: [
        { "0.9995",       :invalid_qvalue }, # rounds to 1.000
        { "0.00x",        :invalid_qvalue },
        { "x",            :invalid_qvalue },
        { :not_a_q_value, :invalid_qvalue },
      ]
end

