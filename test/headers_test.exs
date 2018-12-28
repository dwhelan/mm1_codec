defmodule MMS.HeadersTest do
  use ExUnit.Case
  alias MMS.Headers

  date_time_zero = DateTime.from_unix! 0

  use MMS.TestExamples,
      codec: Headers,
      examples: [
        { <<129, "@",   0        >>, bcc:                     "@"                 },
        { <<130, "@",   0        >>, cc:                      "@"                 },
        { <<131, "x",   0        >>, content_location:        "x"                 },
        { <<132, 128             >>, content_type:            "*/*"               },
        { <<133,   1,   0        >>, date:                    date_time_zero      },
        { <<134, 128             >>, delivery_report:         true                },
        { <<135,   3, 128,   1, 0>>, delivery_time:           date_time_zero      },
        { <<136,   3, 128,   1, 0>>, expiry:                  date_time_zero      },
        { <<137,   3, 128, "@", 0>>, from:                    "@"                 },
        { <<138, 128             >>, message_class:           :personal           },
        { <<139, "@",   0        >>, message_id:              "@"                 },
        { <<140, 128             >>, message_type:            :m_send_conf        },
        { <<141, 128             >>, version:                 {0, 0}              },
        { <<142,   1,   0        >>, message_size:            0                   },
        { <<143, 128             >>, priority:                :low                },
        { <<144, 128             >>, report_allowed:          true                },
        { <<145, 128             >>, response_status:         :ok                 },
        { <<146, "x",   0        >>, response_text:           "x"                 },
        { <<147, 128             >>, sender_visibility:       :hide               },
        { <<148, 128             >>, read_report:             true                },
        { <<149, 128             >>, status:                  :expired            },
        { <<150, "x",   0        >>, subject:                 "x"                 },
        { <<151, "x",   0        >>, to:                      "x"                 },
        { <<152, "x",   0        >>, transaction_id:          "x"                 },
        { <<153, 128             >>, retrieve_status:         :ok                 },
        { <<154, "x",   0        >>, retrieve_text:           "x"                 },
        { <<155, 128             >>, read_status:             :read               },
        { <<156, 128             >>, reply_charging:          :requested          },
        { <<157,   3, 128,   1, 0>>, reply_charging_deadline: date_time_zero      },
        { <<158, "x",   0        >>, reply_charging_id:       "x"                 },
        { <<159,   1,   0        >>, reply_charging_size:     0                   },
        { <<160,   3, 129, "@", 0>>, previously_sent_by:      {"@", 1}            },
        { <<161,   3, 129,  1,  0>>, previously_sent_date:    {date_time_zero, 1} },

        # Multiple headers
        {<<0x81, "@", 0, 0x82, "@", 0>>, bcc: "@", cc: "@"},
      ],

      encode_errors: [
        { [not_a_header: "x"], {:not_a_header, :invalid_header}},
      ]

  test "decode should terminate when an unmapped header byte is found" do
    assert Headers.decode(<<0>>) == {:ok, {[], <<0>>}}
  end
end
