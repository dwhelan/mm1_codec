defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  alias MMS.{Address, Bcc, Boolean, Cc, ContentType, From, IntegerVersion, Long, MessageClass, MessageType}
  alias MMS.{Seconds, Text}

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
#       xPriority: Priority,
#       xReportAllowed: ReportAllowed,
#       xResponseStatus: ResponseStatus,
#       xResponseText: ResponseText,
#       xSenderVisibility: SenderVisibility,
#       xReadReport: ReadReport,
#       xStatus: Status,
#       xSubject: Subject,
#       xTo: To,
#       xTransactionId: TransactionId,
#       xRetrieveStatus: RetrieveStatus,
#       xRetrieveText: RetrieveText,
#       xReadStatus: ReadStatus,
#       xReplyCharging: ReplyCharging,
#       xReplyChargingDeadline: ReplyChargingDeadline,
#       xReplyChargingId: ReplyChargingId,
#       xReplyChargingSize: ReplyChargingSize,
#       xPreviouslySentBy: PreviouslySentBy,
#       xPreviouslySentDate: PreviouslySentDate,
      ],
      error: :invalid_header
end
