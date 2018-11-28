defmodule MM1.HeadersTest do
  use ExUnit.Case
  alias MM1.{Result, Headers}

  import Headers

  #       header_byte -----+      +----- valid header value
  #                        |      |
  #                        V      V
  headers = [
   {MM1.Bcc,             <<129,   0>>},
   {MM1.Cc,              <<130,   0>>},
   {MM1.XMmsMessageType, <<140, 128>>},
   {MM1.XMmsMessageSize, <<142,   0>>},
  ]

  Enum.each(headers, fn {module, bytes} ->
    @module module
    @bytes  bytes

    test "decode(#{inspect bytes}) => #{header_name module}" do
      assert %{module: Headers, value: [%{module: @module}]} = decode @bytes
    end

    test "encode([#{header_name module}]) => #{inspect bytes}" do
      assert @bytes |> decode |> encode == @bytes
    end
  end)

  describe "new" do
    test "new() returns a Result with empty headers" do
      assert new() == %Result{module: Headers, value: []}
    end

    test "new([]) returns a Result with empty headers" do
      assert new([]) == %Result{module: Headers, value: []}
    end

    test "new([%Result{value}]) should create new bytes" do
      bcc = MM1.Bcc.new "abc"
      assert new([bcc]).value == [%Result{bcc | bytes: <<129, "abc", 0>>}]
    end
  end

  test "add" do
    bcc = MM1.Bcc.new "abc"
    headers = add new(), bcc
    assert headers.value == [bcc]
  end

end
