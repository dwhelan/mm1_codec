defmodule MMS.HeadersTest do
  use MMS.CodecTest

  alias MMS.Headers

#  date_time_zero = DateTime.from_unix! 0

  use MMS.TestExamples,
      codec: Headers,
      examples: [
        { << s(1),  "@\0"               >>, bcc:                     {"@", ""}       },
#        { << s(2),  "@\0"               >>, cc:                      {"@", ""}       },
#        { << s(3),  "x\0"               >>, content_location:        "x"                 },
#        { << s(4),  s(0)                >>, content_type:            0             },
#        { << s(5),  l(1), 0             >>, date:                    date_time_zero      },
#        { << s(6),  s(0)                >>, delivery_report:         true                },
#        { << s(7),  l(3), s(0), l(1), 0 >>, delivery_time:           date_time_zero      },
#        { << s(8),  l(3), s(0), l(1), 0 >>, expiry:                  date_time_zero      },
##        { << s(9),  l(3), s(0), "@\0"   >>, from:                    {"@", ""}       },
#        { << s(10), s(0)                >>, message_class:           :personal           },
#        { << s(11), "x\0"               >>, message_id:              "x"                 },
#        { << s(12), s(0)                >>, message_type:            :m_send_req         },
#        { << s(13), 0b10000000          >>, version:                 {0, 0}              },
#        { << s(14), l(1), 0             >>, message_size:            0                   },
#        { << s(15), s(0)                >>, priority:                :low                },
#        { << s(16), s(0)                >>, report_allowed:          true                },
#        { << s(17), s(0)                >>, response_status:         :ok                 },
#        { << s(18), "x\0"               >>, response_text:           "x"                 },
#        { << s(19), s(0)                >>, sender_visibility:       :hide               },
#        { << s(20), s(0)                >>, read_report:             true                },
#        { << s(21), s(0)                >>, status:                  :expired            },
#        { << s(22), "x\0"               >>, subject:                 "x"                 },
#        { << s(23), "x\0"               >>, to:                      "x"                 },
#        { << s(24), "x\0"               >>, transaction_id:          "x"                 },
#        { << s(25), s(0)                >>, retrieve_status:         :ok                 },
#        { << s(26), "x\0"               >>, retrieve_text:           "x"                 },
#        { << s(27), s(0)                >>, read_status:             :read               },
#        { << s(28), s(0)                >>, reply_charging:          :requested          },
#        { << s(29), l(3), s(0), l(1), 0 >>, reply_charging_deadline: date_time_zero      },
#        { << s(30), "x\0"               >>, reply_charging_id:       "x"                 },
#        { << s(31), l(1), 0             >>, reply_charging_size:     0                   },
#        { << s(32), l(3), s(2), "@\0"   >>, previously_sent_by:      {{"@", ""}, 2}  },
#        { << s(33), l(3), s(2), l(1), 0 >>, previously_sent_date:    {date_time_zero, 2} },
#
#        # Multiple headers
#        {<< s(1), "@bcc\0", s(2), "@cc\0" >>, bcc: {"@bcc", ""}, cc: {"@cc", ""}},
      ]
#
#      encode_errors: [
#        { [not_a_header: "x"], {:not_a_header, :header}},
#      ]
end
