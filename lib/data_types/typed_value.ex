defmodule MMS.TypedValue do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-value = Compact-value | Text-value

  In addition to the expected type, there may be no value.

  If the value cannot be encoded using the expected type, it shall be encoded as text.

  """
  use MMS.Codec

  alias MMS.{CompactValue, TextValue, NoValue}

  def decode bytes, token do
    bytes
    |> CompactValue.decode(token)
    ~>> fn _ -> bytes |> decode_as(TextValue) end
    ~>> fn _ -> bytes |> decode_error(%{cannot_be_decoded_as: [CompactValue, TextValue]}) end
  end

  def encode {_, :no_value} do
    :no_value
    |> NoValue.encode
  end

  def encode {token, value} do
    {token, to_string(value)}
    |> CompactValue.encode
    ~>> fn _ -> value |> to_string |> encode_as(TextValue) end
    ~>> fn _ -> value |> to_string |> encode_error(%{cannot_be_encoded_as: [CompactValue, TextValue]}) end
  end

  defp encode_as_text_value(string) when is_binary(string) do
    string
    |> encode_as(TextValue)
  end
 end
