defmodule MMS.KnownParameterTest do
  use MMS.CodecTest

  alias MMS.WellKnownParameter

  use MMS.TestExamples,
      codec: WellKnownParameter,
      examples: [
        # Input bytes              Parameter              Value
        { << s(0),  1          >>, q:                     "00"          },
        { << s(1),  s(0)       >>, charset:               :any          },
        { << s(2),  0b10000000 >>, level:                 {0, 0}        },
        { << s(3),  s(0)       >>, type:                  0             },
        { << s(5),  "x\0"      >>, name_deprecated:       "x"           },
        { << s(6),  "x\0"      >>, file_name_deprecated:  "x"           },
        { << s(7),  "x\0"      >>, differences:           "x"           },
        { << s(8),  s(0)       >>, padding:               0             },
        { << s(9),  s(0)       >>, type_multipart:        "*/*"         },
        { << s(10), "x\0"      >>, start_deprecated:      "x"           },
        { << s(11), "x\0"      >>, start_info_deprecated: "x"           },
        { << s(12), "x\0"      >>, comment_deprecated:    "x"           },
        { << s(13), "x\0"      >>, domain_deprecated:     "x"           },
        { << s(14), s(0)       >>, max_age:               0             },
        { << s(15), "x\0"      >>, path_deprecated:       "x"           },
        { << s(16), 0          >>, secure:                :no_value     },
        { << s(17), s(0)       >>, sec:                   0             },
        { << s(18), "x\0"      >>, mac:                   "x"           },
        { << s(19), l(1), 0    >>, creation_date:         date_time(0)  },
        { << s(20), l(1), 0    >>, modification_date:     date_time(0)  },
        { << s(21), l(1), 0    >>, read_date:             date_time(0)  },
        { << s(22), s(0)       >>, size:                  0             },
        { << s(23), "x\0"      >>, name:                  "x"           },
        { << s(24), "x\0"      >>, file_name:             "x"           },
        { << s(25), "x\0"      >>, start:                 "x"           },
        { << s(26), "x\0"      >>, start_info:            "x"           },
        { << s(27), "x\0"      >>, comment:               "x"           },
        { << s(28), "x\0"      >>, domain:                "x"           },
        { << s(29), "x\0"      >>, path:                  "x"           },

        # Multiple parameters
#        {<<s(0), 1, s(1), s(0)>>, q: "0.00", charset: :any},
      ],

      encode_errors: [
        {[x: ""], {:x, :known_parameter}},
      ]

  test "decode should terminate when an unmapped parameter byte is found" do
    assert WellKnownParameter.decode(<<"rest">>) == {:ok, {[], "rest"}}
  end
end
