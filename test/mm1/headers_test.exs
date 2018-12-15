defmodule MM1.HeadersTest do
  use ExUnit.Case
  alias MM1.{Result, Headers}

  use MM1.Codecs.TestExamples,
      codec: Headers,
      examples: [
        {<<0x81, "x", 0>>, [%Result{bytes: <<0x81, "x", 0>>, module: MM1.Bcc,             rest: "rest", value: "x"         }]},
        {<<0x82, "x", 0>>, [%Result{bytes: <<0x82, "x", 0>>, module: MM1.Cc,              rest: "rest", value: "x"         }]},
        {<<0x8c,    128>>, [%Result{bytes: <<0x8c,    128>>, module: MM1.XMmsMessageType, rest: "rest", value: :m_send_conf}]},
        {<<0x8e,   1, 0>>, [%Result{bytes: <<0x8e,   1, 0>>, module: MM1.XMmsMessageSize, rest: "rest", value:  0          }]},

        {
          <<0x81, "x", 0, 0x82, "x", 0>>,
          [
            %Result{module: MM1.Bcc, value: "x", bytes: <<0x81, "x", 0>>, rest: <<0x82, "x", 0, "rest">>},
            %Result{module: MM1.Cc,  value: "x", bytes: <<0x82, "x", 0>>, rest: "rest"                  }
          ]
        },
      ]
  test "add" do
    bcc = MM1.Bcc.new "abc"
    original = Headers.new
    headers = Headers.add original, bcc
    assert headers.value == [bcc]
  end
end

defmodule MM2.HeadersTest do
  use ExUnit.Case
  alias MM1.Result
  alias MM2.Headers

  use MM1.Codecs2.TestExamples,
      codec: Headers,
      examples: [
        {<<0x81, "x", 0>>, {[{MM2.Bcc, "x"}], <<>>}},
        {<<0x82, "x", 0>>, {[{MM2.Cc, "x"}], <<>>}},
        {<<0x8c, 128>>, {[{MM2.XMmsMessageType, :m_send_conf}], <<>>}},
        {<<0x8e, 1, 0>>, {[{MM2.XMmsMessageSize, 0}], <<>>}},
#        {<<0x82, "x", 0>>, [%Result{bytes: <<0x82, "x", 0>>, module: MM1.Cc,              rest: "rest", value: "x"         }]},
#        {<<0x8c,    128>>, [%Result{bytes: <<0x8c,    128>>, module: MM1.XMmsMessageType, rest: "rest", value: :m_send_conf}]},
#        {<<0x8e,   1, 0>>, [%Result{bytes: <<0x8e,   1, 0>>, module: MM1.XMmsMessageSize, rest: "rest", value:  0          }]},
#
#        {
#          <<0x81, "x", 0, 0x82, "x", 0>>,
#          [
#            %Result{module: MM1.Bcc, value: "x", bytes: <<0x81, "x", 0>>, rest: <<0x82, "x", 0, "rest">>},
#            %Result{module: MM1.Cc,  value: "x", bytes: <<0x82, "x", 0>>, rest: "rest"                  }
#          ]
#        },
      ]
#  test "add" do
#    bcc = MM1.Bcc.new "abc"
#    original = Headers.new
#    headers = Headers.add original, bcc
#    assert headers.value == [bcc]
#  end
end
