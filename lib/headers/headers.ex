defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  @map %{
    0x81 => MMS.Bcc,
    0x82 => MMS.Cc,
    #MMS.XMmsContentLocation,
    #MMS.ContentType,
    #MMS.Date,
    #MMS.XMmsDeliveryReport,
    #MMS.M1:XMmsDeliveryTime,
    #MMS.M1:XMmsExpiry,
    #MMS.M1:From,
    #MMS.M1:XMmsMessageClass,
    #MMS.M1:MessageID,
    0x8c => MMS.XMmsMessageType,
    #MMS.XMmsMMSVersion,
    0x8e => MMS.XMmsMessageSize,
    0x8f => MMS.XMmsPriority,
    #MMS.XMmsReportAllowed,
    #MMS.XMmsResponseStatus,
    #MMS.XMmsResponseText,
    #MMS.XMmsSenderVisibility,
    #MMS.XMmsReadReport,
    #MMS.XMmsStatus,
    #MMS.Subject,
    #MMS.To,
    #MMS.XMmsTransactionId,
    #MMS.XMmsRetrieveStatus,
    #MMS.XMmsRetrieveText,
    #MMS.XMmsReadStatus,
    #MMS.XMmsReplyCharging,
    #MMS.XMmsReplyChargingDeadline,
    #MMS.XMmsReplyChargingID,
    #MMS.XMmsReplyChargingSize,
    #MMS.XMmsPreviouslySentBy,
    #MMS.XMmsPreviouslySentDate,
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
    ok Enum.reverse(headers), rest
  end

  def encode headers do
    encode headers, []
  end

  @reverse_map MMS.Mapper.reverse(@map)

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
