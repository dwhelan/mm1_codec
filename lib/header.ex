defmodule MMS.Header do
  use MMS.Codec

  alias MMS.{Address, Boolean, DateValue, EncodedStringValue, VersionInteger, LongInteger, TextString, Time}
  alias MMS.{ContentTypeValue, From, MessageClass, MessageType, PreviouslySentBy, PreviouslySentDate}
  alias MMS.{Priority, ReadStatus, ReplyCharging, ResponseStatus, RetrieveStatus, SenderVisibility, Status}

  @short_map %{
    0x01 => {:bcc,                     Address},
    0x02 => {:cc,                      Address},
    0x03 => {:content_location,        TextString},
    0x04 => {:content_type,            ContentTypeValue},
    0x05 => {:date,                    DateValue},
    0x06 => {:delivery_report,         Boolean},
    0x07 => {:delivery_time,           Time},
    0x08 => {:expiry,                  Time},
    0x09 => {:from,                    From},
    0x0A => {:message_class,           MessageClass},
    0x0B => {:message_id,              TextString},
    0x0C => {:message_type,            MessageType},
    0x0D => {:version,                 VersionInteger},
    0x0E => {:message_size,            LongInteger},
    0x0F => {:priority,                Priority},
    0x10 => {:report_allowed,          Boolean},
    0x11 => {:response_status,         ResponseStatus},
    0x12 => {:response_text,           EncodedStringValue},
    0x13 => {:sender_visibility,       SenderVisibility},
    0x14 => {:read_report,             Boolean},
    0x15 => {:status,                  Status},
    0x16 => {:subject,                 EncodedStringValue},
    0x17 => {:to,                      EncodedStringValue},
    0x18 => {:transaction_id,          TextString},
    0x19 => {:retrieve_status,         RetrieveStatus},
    0x1A => {:retrieve_text,           EncodedStringValue},
    0x1B => {:read_status,             ReadStatus},
    0x1C => {:reply_charging,          ReplyCharging},
    0x1D => {:reply_charging_deadline, Time},
    0x1E => {:reply_charging_id,       TextString},
    0x1F => {:reply_charging_size,     LongInteger},
    0x20 => {:previously_sent_by,      PreviouslySentBy},
    0x21 => {:previously_sent_date,    PreviouslySentDate},
  }

  def decode bytes do
    bytes
    |> MMS.ShortInteger.decode
    ~> fn {short, rest} -> ok Map.get(@short_map, short), rest  end
    ~> fn { {keyword, codec}, rest} ->
         rest
         |> codec.decode
         ~> fn {value, rest} ->
              ok {keyword, value}, rest
            end
       end
  end

  @keyword_map Enum.reduce(@short_map, %{},
                 fn {short, {keyword, codec}}, acc ->
                   Map.put(acc, keyword, {short, codec})
                 end)

  def encode {keyword, value} do
    Map.get(@keyword_map, keyword)
    ~> fn {short, codec} ->
         value
         |> codec.encode
         ~> fn value_bytes ->
              short
              |> MMS.ShortInteger.encode
              ~> & &1 <> value_bytes
            end
       end
  end

  def encode value do
    error value, :out_of_range
  end
end
