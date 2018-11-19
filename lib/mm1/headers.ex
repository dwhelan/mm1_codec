defmodule MM1.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  @headers [
    Bcc:                       0x01,
    #Cc:                        0x02,
    #XMmsContentLocation:       0x03,
    #ContentType:               0x04,
    #Date:                      0x05,
    #XMmsDeliveryReport:        0x06,
    #M1:XMmsDeliveryTime,       0x07,
    #M1:XMmsExpiry,             0x08,
    #M1:From,                   0x09,
    #M1:XMmsMessageClass,       0x0a,
    #M1:MessageID,              0x0b,
    XMmsMessageType:           0x0c,
    #XMmsMMSVersion:            0x0d,
    #XMmsMessageSize:           0x0e,
    #XMmsPriority:              0x0f,
    #XMmsReportAllowed:         0x11,
    #XMmsResponseStatus:        0x12,
    #XMmsResponseText:          0x13,
    #XMmsSenderVisibility:      0x14,
    #XMmsReadReport:            0x10,
    #XMmsStatus:                0x15,
    #Subject:                   0x16,
    #To:                        0x17,
    #XMmsTransactionId:         0x18,
    #XMmsRetrieveStatus:        0x19,
    #XMmsRetrieveText:          0x1a,
    #XMmsReadStatus:            0x1b,
    #XMmsReplyCharging:         0x1c,
    #XMmsReplyChargingDeadline: 0x1d,
    #XMmsReplyChargingID:       0x1e,
    #XMmsReplyChargingSize:     0x1f,
    #XMmsPreviouslySentBy:      0x20,
    #XMmsPreviouslySentDate:    0x21,
  ]
  use MM1.BaseCodec
  alias MM1.Result

  def decode bytes do
    decode bytes, []
  end

  @headers
  |> Enum.each(fn {header, value} ->
    @module :"Elixir.MM1.#{header}"
    @header value + 128

    defp decode <<@header, _::binary>> = bytes, headers do
      %{rest: rest} = header = @module.decode bytes
      decode rest, [header | headers]
    end
  end)

  defp decode <<>>, headers do
    value Enum.reverse headers
  end

  def encode %{value: headers} do
    Enum.reduce headers, <<>>, fn header, acc -> acc <> header.module.encode header end
  end

  def byte module do
    header = module |> to_string |> String.split(".") |> List.last |> String.to_atom
    @headers[header] + 128
  end
end
