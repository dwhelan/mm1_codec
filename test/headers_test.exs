defmodule MMS.HeadersTest do
  use ExUnit.Case
  alias MMS.Headers

  time_zero = DateTime.from_unix!(0)

  use MMS.TestExamples,
      codec: Headers,
      examples: [
        {<<0x81, "@",   0      >>, [{MMS.Bcc,             "@"         }]},
        {<<0x82, "@",   0      >>, [{MMS.Cc,              "@"         }]},
        {<<0x83, "x",   0      >>, [{MMS.ContentLocation, "x"         }]},
        {<<0x85,   1,   0      >>, [{MMS.Date,            0           }]},
        {<<0x86, 128           >>, [{MMS.DeliveryReport,  :yes        }]},
        {<<0x87,   3, 128, 1, 0>>, [{MMS.DeliveryTime,    time_zero   }]},
        {<<0x88,   3, 128, 1, 0>>, [{MMS.Expiry,          time_zero   }]},
        {<<0x8c, 128           >>, [{MMS.MessageType,     :m_send_conf}]},
        {<<0x8e,   1,   0      >>, [{MMS.MessageSize,     0           }]},
        {<<0x8f, 128           >>, [{MMS.Priority,        :low        }]},

        # Multiple headers
        {<<0x81, "@", 0, 0x81, "@", 0>>, [{MMS.Bcc, "@"}, {MMS.Bcc, "@"}]},
      ]
end
