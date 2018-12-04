defmodule MM1.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  headers = [
    MM1.Bcc,
    MM1.Cc,
    #MM1.XMmsContentLocation,
    #MM1.ContentType,
    #MM1.Date,
    #MM1.XMmsDeliveryReport,
    #MM1.M1:XMmsDeliveryTime,
    #MM1.M1:XMmsExpiry,
    #MM1.M1:From,
    #MM1.M1:XMmsMessageClass,
    #MM1.M1:MessageID,
    MM1.XMmsMessageType,
    #MM1.XMmsMMSVersion,
    MM1.XMmsMessageSize,
    #MM1.XMmsPriority,
    #MM1.XMmsReportAllowed,
    #MM1.XMmsResponseStatus,
    #MM1.XMmsResponseText,
    #MM1.XMmsSenderVisibility,
    #MM1.XMmsReadReport,
    #MM1.XMmsStatus,
    #MM1.Subject,
    #MM1.To,
    #MM1.XMmsTransactionId,
    #MM1.XMmsRetrieveStatus,
    #MM1.XMmsRetrieveText,
    #MM1.XMmsReadStatus,
    #MM1.XMmsReplyCharging,
    #MM1.XMmsReplyChargingDeadline,
    #MM1.XMmsReplyChargingID,
    #MM1.XMmsReplyChargingSize,
    #MM1.XMmsPreviouslySentBy,
    #MM1.XMmsPreviouslySentDate,
  ]

  use MM1.Codecs.Base
  alias MM1.Result
  import Result

  def decode bytes do
    decode bytes, []
  end

  Enum.each(headers,
    fn header ->
      @module      header
      @header_byte @module.header_byte

      defp decode <<@header_byte, _ :: binary>> = bytes, headers do
        header = @module.decode bytes
        decode header.rest, [header | headers]
      end
    end
  )

  defp decode rest, headers do
    headers = Enum.reverse headers
    decode_ok headers, bytes(headers), rest
  end

  def new do
    new_ok [], <<>>
  end

  def new headers do
    new_ok headers, bytes(headers)
  end

  def add headers, header do
    %Result{headers | value: headers.value ++ [header]}
  end

  defp bytes headers do
    headers |> List.foldl(<<>>, & &2 <> &1.bytes)
  end
end
