defmodule MMS.TypedValue do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-value = Compact-value | Text-value

  In addition to the expected type, there may be no value.

  If the value cannot be encoded using the expected type, it shall be encoded as text.

  Compact-value = Integer-value | Date-value | Delta-seconds-value | Q-value | Version-value | Uri-value

  Note that the second argument, `codec` to `decode` and `encode`, must be a Codec which can decode and encode
  values of the expected type. So, we do not need a `MMS.CompactValue` to implement this.
  """
  use MMS.Codec

  alias MMS.{TextValue}

  def decode bytes, codec do
    bytes
    |> decode_as(codec)
    ~>> fn _ -> bytes |> decode_as(TextValue) end
    ~>> fn _ -> bytes |> decode_error(%{cannot_be_decoded_as: [codec, TextValue]}) end
  end

  def encode value, codec do
    value
    |> encode_as(codec)
    ~>> fn _ -> value |> encode_as(TextValue) end
    ~>> fn _ -> value |> encode_error(%{cannot_be_encoded_as: [codec, TextValue]}) end
  end
end
