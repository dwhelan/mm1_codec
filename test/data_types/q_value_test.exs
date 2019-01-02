defmodule MMS.QValueTest do
  use ExUnit.Case

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

        # values that are decodeable but invalid
        {<<136,  76>>,  "1.000"},
        {<<255, 127>>, "16.283"},
      ]
end

