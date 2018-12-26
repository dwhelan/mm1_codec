defmodule MMS.WellKnownParametersTest do
  use ExUnit.Case
  alias MMS.WellKnownParameters

  use MMS.TestExamples,
      codec: WellKnownParameters,
      examples: [
        {<<128, 1>>,          q:         "0.00" },
        {<<129, 128>>,        charset:   :any   },
        {<<130, 0b10000000>>, level:     {0,  0}},
        {<<131, 128>>,        type:      0      },
        {<<132, "x", 0>>,     name:      "x"    },
        {<<133, "x", 0>>,     file_name: "x"    },
        {<<134, "x", 0>>,     differences: "x"    },

        # Multiple parameters
        {<<128, 1, 128, 2>>, q: "0.00", q: "0.01"},
      ],

      encode_errors: [
        {[x: ""], {:x, :invalid_well_known_parameter}},
      ]

  test "decode should terminate when an unmapped byte is found" do
    assert WellKnownParameters.decode(<<128, 1, "rest">>) == {:ok, {[q: "0.00"], "rest"}}
  end
end
