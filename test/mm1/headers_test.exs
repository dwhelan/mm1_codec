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

  test "new(value) returns a Result with that value" do
    assert new([]) == %Result{module: Headers, value: []}
  end
end
