defmodule MMS.Message do
  use MMS.Codec

  alias MMS.Headers

  def decode bytes do
    bytes
    |> Headers.decode
    |> wrap_headers
  end

  def encode [{:headers, value}] do
    value
    |> Headers.encode
  end

  def encode value do
    error value, :out_of_range
  end

  defp wrap_headers {:ok, {value, rest}} do
    ok [{:headers, value}], rest
  end

  defp wrap_headers {:error, reason} do
    error :headers, reason
  end
end
