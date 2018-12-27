defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  alias MMS.{Address, Bcc, Cc, ContentType, Text}

  use MMS.CodecMapper2,
      values: [
        unassigned:            :error,
        bcc:                   Address,
        cc:                    Address,
        content_location:      Text,
        content_type:          ContentType,
#       xDate: Date,
#       xDeliveryReport: DeliveryReport,
#       xDeliveryTime: DeliveryTime,
#       xExpiry: Expiry,
#       xFrom: From,
#       xMessageClass: MessageClass,
#       xMessageId: MessageId,
#       xMessageType: MessageType,
#       xMMSVersion: MMSVersion,
#       xMessageSize: MessageSize,
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
