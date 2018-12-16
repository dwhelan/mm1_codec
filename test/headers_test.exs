defmodule MMS.HeadersTest do
  use ExUnit.Case
  alias MMS.Headers

  use MMS.TestExamples,
      codec: Headers,
      examples: [
        {<<0x81, "x",   0      >>, [{MMS.Bcc,             "x"              }]},
        {<<0x82, "x",   0      >>, [{MMS.Cc,              "x"              }]},
        {<<0x83, "x",   0      >>, [{MMS.ContentLocation, "x"              }]},
        {<<0x85,   1,   0      >>, [{MMS.Date,            0                }]},
        {<<0x86, 128           >>, [{MMS.DeliveryReport,  :yes             }]},
        {<<0x87,   3, 128, 1, 0>>, [{MMS.DeliveryTime,    {0, :absolute, 3}}]},
        {<<0x8c, 128           >>, [{MMS.MessageType,     :m_send_conf     }]},
        {<<0x8e,   1,   0      >>, [{MMS.MessageSize,     0                }]},
        {<<0x8f, 128           >>, [{MMS.Priority,        :low             }]},

        # Multiple headers
        {<<0x81, "x", 0, 0x81, "y", 0>>, [{MMS.Bcc, "x"}, {MMS.Bcc, "y"}]},
      ]
end
