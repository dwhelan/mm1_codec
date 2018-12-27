defmodule MMS.HeadersTestHelper do
  def header name, value do
    [{name, value}]
  end
end

defmodule MMS.HeadersTest do
  use ExUnit.Case
  import MMS.HeadersTestHelper
  alias MMS.Headers

  time_zero = DateTime.from_unix!(0)

  use MMS.TestExamples,
      codec: Headers,
      examples: [
        {<<0x81, "@",   0        >>, bcc:                   "@"         },
        {<<0x82, "@",   0        >>, cc:                    "@"         },
        {<<0x83, "x",   0        >>, content_location:      "x"         },
        {<<0x84, 128             >>, content_type:          "*/*"       },
        {<<0x85,   1,   0        >>, date:                  0           },
        {<<0x86, 128             >>, delivery_report:       true        },
        {<<0x87,   3, 128,   1, 0>>, delivery_time:         time_zero   },
        {<<0x88,   3, 128,   1, 0>>, expiry:                time_zero   },
        {<<0x89,   3, 128, "@", 0>>, from:                  "@"         },
        {<<0x8a, 128             >>, message_class:         :personal   },
        {<<0x8b, "@",   0        >>, message_id:            "@"         },
        {<<0x8c, 128             >>, message_type:          :m_send_conf},
        {<<0x8d, 128             >>, version:               {0, 0}      },
        {<<0x8e,   1,   0        >>, message_size:          0           },
        {<<0x8f, 128             >>, priority:              :low        },
        {<<0x90, 128             >>, report_allowed:        true        },
#        {<<0x91, 128             >>, ResponseStatus:        :ok         },
#        {<<0x92, "x",   0        >>, ResponseText:          "x"         },
#        {<<0x93, 128             >>, SenderVisibility:      :hide       },
#        {<<0x94, 128             >>, ReadReport:            true        },
#        {<<0x95, 128             >>, Status:                :expired    },
#        {<<0x96, "x",   0        >>, Subject:               "x"         },
#        {<<0x97, "x",   0        >>, To:                    "x"         },
#        {<<0x98, "x",   0        >>, TransactionId:         "x"         },
#        {<<0x99, 128             >>, RetrieveStatus:        :ok         },
#        {<<0x9a, "x",   0        >>, RetrieveText:          "x"         },
#        {<<0x9b, 128             >>, ReadStatus:            :read       },
#        {<<0x9c, 128             >>, ReplyCharging:         :requested  },
#        {<<0x9d,   3, 128,   1, 0>>, ReplyChargingDeadline: time_zero   )},
#        {<<0x9e, "x",   0        >>, ReplyChargingId:       "x"         },
#        {<<0x9f,   1,   0        >>, ReplyChargingSize:     0           },
#        {<<0xa0,   3, 129, "@", 0>>, PreviouslySentBy:      [1, "@"]    },
#        {<<0xa1,   3, 129,  1,  0>>, PreviouslySentDate:    [1, 0]      },

        # Multiple headers
#        {<<0x81, "@", 0, 0x82, "@", 0>>, [{MMS.Bcc, "@"}, {MMS.Cc, "@"}]},
      ],

      encode_errors: [
#        { [{MMS.NotAHeader, "x"}], {MMS.NotAHeader,  :invalid_header}},
      ]

  test "decode should terminate when an unmapped byte is found" do
    assert Headers.decode(<<0x80>>) == {:ok, {[], <<0x80>>}}
  end
end
