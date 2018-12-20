defmodule MMS.MMSVersionTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MMSVersion,
      examples: [
        #    s
        {<<0b10010000>>, "1.0"},
        {<<0b10010001>>, "1.1"},
        {<<0b10011111>>, "1"  },
      ],

      decode_errors: [
      ]
end

