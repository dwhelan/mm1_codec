defmodule MMS.Message do
  import MMS.OkError

  alias MMS.Headers

  def decode bytes do
    bytes |> Headers.decode |> wrap
  end

  def encode {Headers, value} do
    value |> Headers.encode
  end

  defp wrap {:ok, {value, rest}} do
    ok {Headers, value}, rest
  end

  defp wrap {:error, reason} do
    error Headers, reason
  end
end