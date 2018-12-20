defmodule MMS.MMSVersionTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MMSVersion,
      examples: [
        #     ___ major - 3 bits
        #        ____ minor - 4 bits
        {<<0b10000000>>, "0.0" },
        {<<0b10000001>>, "0.1" },
        {<<0b10001110>>, "0.14"},
        {<<0b10001111>>, "0"   },
        {<<0b10010000>>, "1.0" },
        {<<0b11111111>>, "7"   },
      ],

      encode_errors: [
        {"x",    :invalid_version_string},
        {"8",    :invalid_version_string},
        {"8.0",  :invalid_version_string},
        {"0.15", :invalid_version_string},
      ]
end

