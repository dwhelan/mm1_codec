defmodule MMS.WellKnownParametersTest do
  use ExUnit.Case
  alias MMS.WellKnownParameters

  time_zero = DateTime.from_unix!(0)

  use MMS.TestExamples,
      codec: WellKnownParameters,
      examples: [
        {<<128, 1>>,          q:                     "0.00"   },
        {<<129, 128>>,        charset:               :any     },
        {<<130, 0b10000000>>, level:                 {0,  0}  },
        {<<131, 128>>,        type:                  0        },
        {<<133, "x", 0>>,     name:                  "x"      },
        {<<134, "x", 0>>,     file_name:             "x"      },
        {<<135, "x", 0>>,     differences:           "x"      },
        {<<136, 128>>,        padding:               0        },
        {<<137, 128>>,        type_multipart:        "*/*"    },
        {<<138, "x", 0>>,     start_deprecated:      "x"      },
        {<<139, "x", 0>>,     start_info_deprecated: "x"      },
        {<<140, "x", 0>>,     comment_deprecated:    "x"      },
        {<<141, "x", 0>>,     domain_deprecated:     "x"      },
        {<<142, 128>>,        max_age:               0        },
        {<<143, "x", 0>>,     path_deprecated:       "x"      },
        {<<144, 0>>,          secure:                :no_value},
        {<<145, 128>>,        sec:                   0        },
        {<<146, "x", 0>>,     mac:                   "x"      },
        {<<147, 1, 0>>,       creation_date:         time_zero},
        {<<148, 1, 0>>,       modification_date:     time_zero},
        {<<149, 1, 0>>,       read_date:             time_zero},
        {<<150, 128>>,        size:                  0        },

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
