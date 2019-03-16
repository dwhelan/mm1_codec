defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  alias MMS.{Address, Boolean, DateValue, EncodedStringValue, VersionInteger, LongInteger, TextString, Time}

  alias MMS.{ContentType, From, MessageClass, MessageType, PreviouslySentBy, PreviouslySentDate}
  alias MMS.{Priority, ReadStatus, ReplyCharging, ResponseStatus, RetrieveStatus, SenderVisibility, Status}

  use MMS.CodecMapper,
      values: [
        _unassigned:             nil,
        bcc:                     Address,
        cc:                      Address,
        content_location:        TextString,
        content_type:            ContentType,
        date:                    DateValue,
        delivery_report:         Boolean,
        delivery_time:           Time,
        expiry:                  Time,
        from:                    From,
        message_class:           MessageClass,
        message_id:              TextString,
        message_type:            MessageType,
        version:                 VersionInteger,
        message_size:            LongInteger,
        priority:                Priority,
        report_allowed:          Boolean,
        response_status:         ResponseStatus,
        response_text:           EncodedStringValue,
        sender_visibility:       SenderVisibility,
        read_report:             Boolean,
        status:                  Status,
        subject:                 EncodedStringValue,
        to:                      EncodedStringValue,
        transaction_id:          TextString,
        retrieve_status:         RetrieveStatus,
        retrieve_text:           EncodedStringValue,
        read_status:             ReadStatus,
        reply_charging:          ReplyCharging,
        reply_charging_deadline: Time,
        reply_charging_id:       TextString,
        reply_charging_size:     LongInteger,
        previously_sent_by:      PreviouslySentBy,
        previously_sent_date:    PreviouslySentDate,
      ],
      error: :header
end
