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
  import MM1.Result

  def decode bytes do
    decode bytes, []
  end

  Enum.each(headers,
    fn header ->
      @module      header
      @header_byte @module.header_byte

      defp decode <<@header_byte, _ :: binary>> = bytes, headers do
        %{rest: rest} = header = @module.decode bytes
        decode rest, [header | headers]
      end
    end
  )

  defp decode rest, headers do
    decode_ok Enum.reverse(headers), <<>>, rest
  end

  def encode result do
    result.value |> Enum.map(& &1.bytes) |> Enum.join
  end

  def new do
    new_ok [], <<>>
  end

  def new headers do
    new_ok Enum.map(headers, fn header -> header.module.new(header.value)  end), <<>>
  end

  def add headers, header do
    %MM1.Result{headers | value: headers.value ++ [header]}
  end
end
