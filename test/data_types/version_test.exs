defmodule MMS.VersionTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Version,
      examples: [
        #     ___ major - 3 bits
        #        ____ minor - 4 bits - all ones means major only
        {<<0b10000000>>,  {0,  0}},
        {<<"beta 1", 0>>,   "beta 1"},
      ],

      encode_errors: [
        {:x,       :invalid_version},
      ]
end

