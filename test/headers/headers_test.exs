defmodule MM2.HeadersTest do
  use ExUnit.Case
  alias MM2.Headers

  use MM1.Codecs.TestExamples,
      codec: Headers,
      examples: [
        {<<0x81,   "x", 0>>, {[{MM2.Bcc,                      "x"}], <<>>}},
        {<<0x82,   "x", 0>>, {[{MM2.Cc,                       "x"}], <<>>}},
        {<<0x8c,  128    >>, {[{MM2.XMmsMessageType, :m_send_conf}], <<>>}},
        {<<0x8e,    1,  0>>, {[{MM2.XMmsMessageSize, 0           }], <<>>}},

        # Multiple headers
        {<<0x81, "x", 0, 0x81, "y", 0>>, {[{MM2.Bcc, "x"}, {MM2.Bcc, "y"}], <<>>}},
      ]
end
