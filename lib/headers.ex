defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  alias MMS.{Address, Boolean, EncodedString, IntegerVersion, Long, Seconds, Text}

  alias MMS.{ContentType, From, MessageClass, MessageType, Priority, ReadStatus, ReplyCharging, ResponseStatus, RetrieveStatus, SenderVisibility, Status}

  use MMS.CodecMapper2,
      values: [
        unassigned:              :error,
        bcc:                     Address,
        cc:                      Address,
        content_location:        Text,
        content_type:            ContentType,
        date:                    Long,
        delivery_report:         Boolean,
        delivery_time:           Seconds,
        expiry:                  Seconds,
        from:                    From,
        message_class:           MessageClass,
        message_id:              Text,
        message_type:            MessageType,
        version:                 IntegerVersion,
        message_size:            Long,
        priority:                Priority,
        report_allowed:          Boolean,
        response_status:         ResponseStatus,
        response_text:           EncodedString,
        sender_visibility:       SenderVisibility,
        read_report:             Boolean,
        status:                  Status,
        subject:                 EncodedString,
        to:                      EncodedString,
        transaction_id:          Text,
        retrieve_status:         RetrieveStatus,
        retrieve_text:           EncodedString,
        read_status:             ReadStatus,
        reply_charging:          ReplyCharging,
        reply_charging_deadline: Seconds,
        reply_charging_id:       Text,
        reply_charging_size:     Long,
#        PreviouslySentBy: PreviouslySentBy,
#        PreviouslySentDate: PreviouslySentDate,
      ],
      error: :invalid_header
end
