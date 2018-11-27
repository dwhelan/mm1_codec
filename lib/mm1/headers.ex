defmodule MM1.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  @headers [
    Bcc:                       0x01,
    Cc:                        0x02,
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
    XMmsMessageSize:           0x0e,
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
  use MM1.BaseDecoder
  import MM1.Result

  def decode bytes do
    decode bytes, []
  end

  @headers
  |> Enum.each(fn {header, value} ->
    @module      :"Elixir.MM1.#{header}"
    @header_byte value + 128

    defp decode <<@header_byte, _::binary>> = bytes, headers do
      %{rest: rest} = header = @module.decode bytes
      decode rest, [header | headers]
    end
  end)

  defp decode <<>>, headers do
    ok Enum.reverse headers
  end

  defp decode rest, headers do
    ok Enum.reverse(headers), <<>>, rest
  end

  def encode %{value: headers} do
    Enum.reduce headers, <<>>, fn header, acc -> acc <> header.module.encode header end
  end

  def header_name module do
    module |> to_string |> String.split(".") |> List.last
  end

  def header_byte module do
    value = module |> header_name |> String.to_atom
    @headers[value] + 128
  end

  def new headers do
    ok Enum.map(headers, fn header -> header.module.new(header.value)  end)
  end
end
