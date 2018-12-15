defmodule MMS.HeadersTest do
  use ExUnit.Case
  alias MMS.Headers

  use MM1.Codecs.TestExamples,
      codec: Headers,
      examples: [
        {<<0x81,   "x", 0>>, {[{MMS.Bcc,                      "x"}], <<>>}},
        {<<0x82,   "x", 0>>, {[{MMS.Cc,                       "x"}], <<>>}},
        {<<0x8c,  128    >>, {[{MMS.XMmsMessageType, :m_send_conf}], <<>>}},
        {<<0x8e,    1,  0>>, {[{MMS.XMmsMessageSize, 0           }], <<>>}},

        # Multiple headers
        {<<0x81, "x", 0, 0x81, "y", 0>>, {[{MMS.Bcc, "x"}, {MMS.Bcc, "y"}], <<>>}},
      ]
end
