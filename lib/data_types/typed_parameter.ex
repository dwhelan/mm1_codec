defmodule MMS.TypedParameter do
  @moduledoc """
  8.4.2.4 Parameter

  Typed-parameter = Well-known-parameter-token Typed-value
  """
  import MMS.NameValue

  defcodec as: MMS.IntegerValue, map: %{
    0x00 => {:q,                          MMS.QValue},
    0x01 => {:charset,                    MMS.WellKnownCharset},
    0x02 => {:level,                      MMS.VersionValue},
    0x03 => {:type,                       MMS.IntegerValue},
    0x05 => {:"name (deprecated)",        MMS.TextString},
    0x06 => {:"file_name (deprecated)",   MMS.TextString},
    0x07 => {:differences,                MMS.FieldName},
    0x08 => {:padding,                    MMS.ShortInteger},
    0x09 => {:type_multipart,             MMS.ConstrainedEncoding},
    0x0A => {:"start (deprecated)",       MMS.TextString},
    0x0B => {:"start_info (deprecated)",  MMS.TextString},
    0x0C => {:"comment (deprecated)",     MMS.TextString},
    0x0D => {:"domain (deprecated)",      MMS.TextString},
    0x0E => {:max_age,                    MMS.DeltaSecondsValue},
    0x0F => {:"path (deprecated)",        MMS.TextString},
    0x10 => {:secure,                     MMS.NoValue},
    0x11 => {:sec,                        MMS.ShortInteger},
    0x12 => {:mac,                        MMS.TextValue},
    0x13 => {:creation_date,              MMS.DateValue},
    0x14 => {:modification_date,          MMS.DateValue},
    0x15 => {:read_date,                  MMS.DateValue},
    0x16 => {:size,                       MMS.IntegerValue},
    0x17 => {:name,                       MMS.TextValue},
    0x18 => {:file_name,                  MMS.TextValue},
    0x19 => {:start,                      MMS.TextValue},
    0x1A => {:start_info,                 MMS.TextValue},
    0x1B => {:comment,                    MMS.TextValue},
    0x1C => {:domain,                     MMS.TextValue},
    0x1D => {:path,                       MMS.TextValue},
  }
end
