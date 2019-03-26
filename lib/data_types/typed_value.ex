defmodule MMS.TypedValue do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-value = Compact-value | Text-value

  In addition to the expected type, there may be no value.

  If the value cannot be encoded using the expected type, it shall be encoded as text.

  Compact-value = Integer-value | Date-value | Delta-seconds-value | Q-value | Version-value | Uri-value
  """
  use MMS.Codec

  alias MMS.{TextValue}

  def decode bytes, compactValueCodec do
    bytes
    |> decode_as(compactValueCodec)
    ~>> fn _ ->
          bytes
          |> decode_as(TextValue)
        end
    ~>> fn _ ->
          bytes
          |> decode_error(%{cannot_be_decoded_as: [compactValueCodec, TextValue]})
        end
  end
end
