defmodule MMS.WellKnownParameterToken do
  @moduledoc """
  8.4.2.4 Parameter

  Well-known-parameter-token = Integer-value

  The code values used for parameters are specified in the Assigned Numbers appendix.

  Table 38. Well-Known Parameter Assignments (excerpts)

  |----------------|-----------------|
  |Assigned Number |Token            |
  |----------------|-----------------|
  |0x00            |Q                |
  |0x01            |Charset          |
  |0x02            |Level            |
  |0x03            |Type             |
  |0x05            |Name*            |
  |0x06            |Filename*        |
  |0x07            |Differences      |
  |0x08            |Padding          |
  |0x09            |Type             |
  |0x0A            |Start*           |
  |0x0B            |Start-info*      |
  |0x0C            |Comment*         |
  |0x0D            |Domain*          |
  |0x0E            |Max-Age          |
  |0x0F            |Path*            |
  |0x10            |Secure           |
  |0x11            |SEC              |
  |0x12            |MAC              |
  |0x13            |Creation-date    |
  |0x14            |Modification-date|
  |0x15            |Read-date        |
  |0x16            |Size             |
  |0x17            |Name             |
  |0x18            |Filename         |
  |0x19            |Start            |
  |0x1A            |Start-info       |
  |0x1B            |Comment          |
  |0x1C            |Domain           |
  |0x1D            |Path             |
  |----------------|-----------------|

  Note: * These numbers have been deprecated and should not be used.

  This codec represents a well known parameter token as a Pascal cased `atom`.
  """

  use MMS.Codec

  alias MMS.{QValue, WellKnownCharset, VersionValue, IntegerValue, TextString}
  alias MMS.{FieldName, ShortInteger, ConstrainedEncoding, DeltaSecondsValue}
  alias MMS.{NoValue, DateValue, TextValue}

  @map %{
    0x00 => :q,
    0x01 => :charset,
    0x02 => :level,
    0x03 => :type,
    0x05 => :"name (deprecated)",
    0x06 => :"file_name (deprecated)",
    0x07 => :differences,
    0x08 => :padding,
    0x09 => :type_multipart,
    0x0A => :"start (deprecated)",
    0x0B => :"start_info (deprecated)",
    0x0C => :"comment (deprecated)",
    0x0D => :"domain (deprecated)",
    0x0E => :max_age,
    0x0F => :"path (deprecated)",
    0x10 => :secure,
    0x11 => :sec,
    0x12 => :mac,
    0x13 => :creation_date,
    0x14 => :modification_date,
    0x15 => :read_date,
    0x16 => :size,
    0x17 => :name,
    0x18 => :file_name,
    0x19 => :start,
    0x1A => :start_info,
    0x1B => :comment,
    0x1C => :domain,
    0x1D => :path,
  }

  def decode bytes do
    bytes
    |> decode_as(IntegerValue, @map)
  end

  def encode token do
    token
    |> encode_as(IntegerValue, @map)
  end
end
