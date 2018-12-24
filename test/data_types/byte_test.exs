defmodule MMS.ByteTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Byte,
      examples: [
        {<<0>>,     0},
        {<<255>>, 255},
      ],

      encode_errors: [
        {  -1, :invalid_byte},
        { 256, :invalid_byte},
        { "x", :invalid_byte},
      ]
end
