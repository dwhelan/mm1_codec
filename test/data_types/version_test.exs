defmodule MMS.VersionTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Version,

      examples: [
        #     _ '1' indicates short byte
        #      ___ major - 3 bits
        #         ____ minor - 4 bits - all ones means major only
        { <<0b10000000>>, {0, 0}   },
        { "beta 1\0",     "beta 1" },
      ],

      decode_errors: [
        { "no terminator", :invalid_version},
      ],

      encode_errors: [
        {:not_a_version, :invalid_version},
      ]
end

