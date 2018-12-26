defmodule MMS.MMSVersionTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MMSVersion,
      examples: [
        {<<0b10000000>>, {0,  0}},
      ],

      encode_errors: [
        {"x", :invalid_version},
      ]
end

