defmodule MM1.XMmsMessageSizeTest do
  alias MM1.{Result, Headers, XMmsMessageSize}
  import XMmsMessageSize

  use MM1.CodecTest

  def bytes do
    <<Headers.header_byte(XMmsMessageSize), 1, 42>>
  end

  def result do
    %Result{module: XMmsMessageSize, value: 42, bytes: bytes()}
  end
end
