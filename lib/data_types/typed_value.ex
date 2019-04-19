defmodule MMS.TypedValue do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-value = Compact-value | Text-value

  In addition to the expected type, there may be no value.

  If the value cannot be encoded using the expected type, it shall be encoded as text.
  """
  use MMS.Codec
  import MMS.As

  alias MMS.{CompactValue, TextValue, NoValue}

  def decode bytes, expected_type do
    bytes
    |> CompactValue.decode(expected_type)
    ~>> fn _ ->
          bytes
          |> decode_as(TextValue, fn value -> {expected_type, value} end)
        end
    ~>> fn _ -> bytes |> error(%{cannot_be_decoded_as: [CompactValue, TextValue]}) end
  end

  def encode {_, :no_value} do
    :no_value
    |> NoValue.encode
  end

  def encode({expected_type, value}) when is_atom(expected_type) do
    try do
      {expected_type, value}
      |> CompactValue.encode
      ~>> fn _ ->
            value
              |> encode_as(TextValue)
              ~>> fn _ -> {expected_type, value} |> error(%{cannot_be_encoded_as: [CompactValue, TextValue]}) end
          end
    rescue
      FunctionClauseError -> {expected_type, value} |> error(%{cannot_be_encoded_as: [CompactValue, TextValue]})
    end
  end
 end
