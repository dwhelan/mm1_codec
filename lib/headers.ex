defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  alias MMS.{Address, Bcc, Boolean, Cc, ContentType, EncodedString, From, IntegerVersion, Long, MessageClass, MessageType}
  alias MMS.{Priority, ResponseStatus, SenderVisibility, Seconds, Status, Text}

  use MMS.CodecMapper2,
      values: [
        unassigned:            :error,
        bcc:                   Address,
        cc:                    Address,
        content_location:      Text,
        content_type:          ContentType,
        date:                  Long,
        delivery_report:       Boolean,
        delivery_time:         Seconds,
        expiry:                Seconds,
        from:                  From,
        message_class:         MessageClass,
        message_id:            Text,
        message_type:          MessageType,
        version:               IntegerVersion,
        message_size:          Long,
        priority:              Priority,
        report_allowed:        Boolean,
        response_status:       ResponseStatus,
        response_text:         EncodedString,
        sender_visibility:     SenderVisibility,
        read_report:           Boolean,
        status:                Status,
        subject:               EncodedString,
#        To: To,
#        TransactionId: TransactionId,
#        RetrieveStatus: RetrieveStatus,
#        RetrieveText: RetrieveText,
#        ReadStatus: ReadStatus,
#        ReplyCharging: ReplyCharging,
#        ReplyChargingDeadline: ReplyChargingDeadline,
#        ReplyChargingId: ReplyChargingId,
#        ReplyChargingSize: ReplyChargingSize,
#        PreviouslySentBy: PreviouslySentBy,
#        PreviouslySentDate: PreviouslySentDate,
      ],
      error: :invalid_header
end
