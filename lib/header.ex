defmodule MMS.Header do
  import MMS.NameValue

  defcodec as: MMS.ShortInteger, map: %{
    0x01 => {:bcc,                     MMS.Address},
    0x02 => {:cc,                      MMS.Address},
    0x03 => {:content_location,        MMS.UriValue},
    0x04 => {:content_type,            MMS.ContentTypeValue},
    0x05 => {:date,                    MMS.DateValue},
    0x06 => {:delivery_report,         MMS.Boolean},
    0x07 => {:delivery_time,           MMS.Time},
    0x08 => {:expiry,                  MMS.Time},
    0x09 => {:from,                    MMS.From},
    0x0A => {:x_mms_message_class,     MMS.XMmsMessageClass},
    0x0B => {:message_id,              MMS.TextString},
    0x0C => {:message_type,            MMS.MessageType},
    0x0D => {:version,                 MMS.VersionInteger},
    0x0E => {:message_size,            MMS.LongInteger},
    0x0F => {:priority,                MMS.Priority},
    0x10 => {:report_allowed,          MMS.Boolean},
    0x11 => {:response_status,         MMS.ResponseStatus},
    0x12 => {:response_text,           MMS.EncodedStringValue},
    0x13 => {:sender_visibility,       MMS.SenderVisibility},
    0x14 => {:read_report,             MMS.Boolean},
    0x15 => {:status,                  MMS.Status},
    0x16 => {:subject,                 MMS.EncodedStringValue},
    0x17 => {:to,                      MMS.EncodedStringValue},
    0x18 => {:transaction_id,          MMS.TextString},
    0x19 => {:retrieve_status,         MMS.RetrieveStatus},
    0x1A => {:retrieve_text,           MMS.EncodedStringValue},
    0x1B => {:read_status,             MMS.ReadStatus},
    0x1C => {:reply_charging,          MMS.ReplyCharging},
    0x1D => {:reply_charging_deadline, MMS.Time},
    0x1E => {:reply_charging_id,       MMS.TextString},
    0x1F => {:reply_charging_size,     MMS.LongInteger},
    0x20 => {:previously_sent_by,      MMS.PreviouslySentBy},
    0x21 => {:previously_sent_date,    MMS.PreviouslySentDate},
  }
end
