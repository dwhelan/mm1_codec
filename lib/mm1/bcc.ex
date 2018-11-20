defmodule MM1.Bcc do
  use MM1.BaseCodec
  alias WAP.TextString

  @header MM1.Headers.byte __MODULE__

  def decode <<@header, bytes::binary>> do
    bytes |> TextString.decode |> prefix_header_in_bytes |> return
  end

  defp prefix_header_in_bytes result do
    %Result{result | bytes: <<@header>> <> result.bytes}
  end
end
