defmodule MMS.TypedValue do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-value = Compact-value | Text-value

  In addition to the expected type, there may be no value.

  If the value cannot be encoded using the expected type, it shall be encoded as text.

  Compact-value = Integer-value | Date-value | Delta-seconds-value | Q-value | Version-value | Uri-value

  Table 38. Well-Known Parameter Assignments (excerpts)

  |-----------------|----------------|--------------------|
  |Token            |Assigned Number |BNF Rule for Value  |
  |-----------------|----------------|--------------------|
  |Q                |0x00            |Q-value             |
  |Charset          |0x01            |Well-known-charset  |
  |Level            |0x02            |Version-value       |
  |Type             |0x03            |Integer-value       |
  |Name*            |0x05            |Text-string         |
  |Filename*        |0x06            |Text-string         |
  |Differences      |0x07            |Field-name          |
  |Padding          |0x08            |Short-integer       |
  |Type             |0x09            |Constrained-encoding|
  |Start*           |0x0A            |Text-string         |
  |Start-info*      |0x0B            |Text-string         |
  |Comment*         |0x0C            |Text-string         |
  |Domain*          |0x0D            |Text-string         |
  |Max-Age          |0x0E            |Delta-seconds-value |
  |Path*            |0x0F            |Text-string         |
  |Secure           |0x10            |No-value            |
  |SEC              |0x11            |Short-integer       |
  |MAC              |0x12            |Text-value          |
  |Creation-date    |0x13            |Date-value          |
  |Modification-date|0x14            |Date-value          |
  |Read-date        |0x15            |Date-value          |
  |Size             |0x16            |Integer-value       |
  |Name             |0x17            |Text-value          |
  |Filename         |0x18            |Text-value          |
  |Start            |0x19            |Text-value          |
  |Start-info       |0x1A            |Text-value          |
  |Comment          |0x1B            |Text-value          |
  |Domain           |0x1C            |Text-value          |
  |Path             |0x1D            |Text-value          |
  |-----------------|----------------|--------------------|

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
