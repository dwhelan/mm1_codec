defmodule MMS.MMSVersionTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MMSVersion,
      examples: [
        #     ___ major - 3 bits
        #        ____ minor - 4 bits
        {<<0b10011111>>, "1"   },
        {<<0b10010000>>, "1.0" },
        {<<0b10010001>>, "1.1" },
        {<<0b11111110>>, "7.14"}, # max version
      ],

      encode_errors: [
        {"8",    :invalid_version_string},
        {"8.0",  :invalid_version_string},
        {"0.15", :invalid_version_string},
      ]
end

