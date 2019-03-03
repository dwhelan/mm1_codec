defmodule MMS.MessageTypeTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MessageType,
      examples: [
        {<<128>>, :m_send_req        },
#        {<<129>>, :m_send_conf       },
#        {<<130>>, :m_notification_ind},
#        {<<131>>, :m_notifyresp_ind  },
#        {<<132>>, :m_retrieve_conf   },
#        {<<133>>, :m_acknowledge_ind },
#        {<<134>>, :m_delivery_ind    },
#        {<<135>>, :m_read_rec_ind    },
#        {<<136>>, :m_read_orig_ind   },
#        {<<137>>, :m_forward_ind     },
#        {<<138>>, :m_forward_conf    },
      ],

      decode_errors: [
#        { <<139>>, {:message_type, <<139>>, %{out_of_range: 11}} },
      ]

  import Codec.Map

  test "encode_function with function" do
    f = encode_function & &1+1
    assert f.(0) == 1
  end

  test "encode_function with map" do
    f = encode_function %{0 => :y}
    assert f.(:y) == ok 0
  end

  @map %{0 => :y}
  test "encode_function with map attribute" do
    f = encode_function @map
    assert f.(:y) == ok 0
  end

  test "encode_function with list" do
    f = encode_function [:a, :b, :c]
    assert f.(:a) == ok 0
  end

  @list [:a, :b, :c]
  test "encode_function with list attribute" do
    f = encode_function @list
    assert f.(:a) == ok 0
  end
end
