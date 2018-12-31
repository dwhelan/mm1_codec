defmodule MMS.Message do
  import MMS.OkError

  alias MMS.Headers

  def decode bytes do
    bytes |> Headers.decode |> wrap_headers
  end

  def encode {Headers, value} do
    value |> Headers.encode
  end

  defp wrap_headers {:ok, {value, rest}} do
    ok {Headers, value}, rest
  end

  defp wrap_headers {:error, reason} do
    error Headers, reason
  end
end
