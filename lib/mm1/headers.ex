defmodule MM2.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  @map %{
    0x81 => MM2.Bcc,
    0x82 => MM2.Cc,
    #MM1.XMmsContentLocation,
    #MM1.ContentType,
    #MM1.Date,
    #MM1.XMmsDeliveryReport,
    #MM1.M1:XMmsDeliveryTime,
    #MM1.M1:XMmsExpiry,
    #MM1.M1:From,
    #MM1.M1:XMmsMessageClass,
    #MM1.M1:MessageID,
    0x8c => MM2.XMmsMessageType,
    #MM1.XMmsMMSVersion,
    0x8e => MM2.XMmsMessageSize,
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
  }


  import MMS.OkError

  def decode bytes do
    decode bytes, []
  end

  @header_bytes Map.keys(@map)

  defp decode(<<byte, bytes:: binary>>, headers) when byte in @header_bytes do
    header = @map[byte]

    case header.decode bytes do
      {:ok,    {value, rest}} -> decode rest, [{header, value} | headers]
      {:error,        reason} -> error {header, reason}
    end
  end

  defp decode(rest, headers) do
    ok {Enum.reverse(headers), rest}
  end

  def encode headers do
    encode headers, []
  end

  @reverse_map MM1.Codecs.Mapper.reverse(@map)

  defp encode [{header, value} | headers], results do
    case header.encode value do
      {:ok,     bytes} -> encode headers, [{header, bytes} | results]
      {:error, reason} -> error {header, reason}
    end
  end

  defp encode [], results do
    ok results |> Enum.reverse |> Enum.map(&prepend_header_byte/1) |> Enum.join
  end

  defp prepend_header_byte {header, bytes} do
    <<@reverse_map[header]>> <> bytes
  end
end
