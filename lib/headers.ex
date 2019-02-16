defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  alias MMS.{Address, Boolean, DateTime, EncodedStringValue2, VersionInteger, Long, Text, Time}

  alias MMS.{ContentType, From, MessageClass, MessageType, PreviouslySentBy, PreviouslySentDate}
  alias MMS.{Priority, ReadStatus, ReplyCharging, ResponseStatus, RetrieveStatus, SenderVisibility, Status}

  use MMS.CodecMapper,
      values: [
        _unassigned:             nil,
        bcc:                     Address,
        cc:                      Address,
        content_location:        Text,
        content_type:            ContentType,
        date:                    DateTime,
        delivery_report:         Boolean,
        delivery_time:           Time,
        expiry:                  Time,
        from:                    From,
        message_class:           MessageClass,
        message_id:              Text,
        message_type:            MessageType,
        version:                 VersionInteger,
        message_size:            Long,
        priority:                Priority,
        report_allowed:          Boolean,
        response_status:         ResponseStatus,
        response_text:           EncodedStringValue2,
        sender_visibility:       SenderVisibility,
        read_report:             Boolean,
        status:                  Status,
        subject:                 EncodedStringValue2,
        to:                      EncodedStringValue2,
        transaction_id:          Text,
        retrieve_status:         RetrieveStatus,
        retrieve_text:           EncodedStringValue2,
        read_status:             ReadStatus,
        reply_charging:          ReplyCharging,
        reply_charging_deadline: Time,
        reply_charging_id:       Text,
        reply_charging_size:     Long,
        previously_sent_by:      PreviouslySentBy,
        previously_sent_date:    PreviouslySentDate,
      ],
      error: :invalid_header
end
