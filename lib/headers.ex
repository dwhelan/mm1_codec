defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  @map %{
    0x81 => MMS.Bcc,
    0x82 => MMS.Cc,
    0x83 => MMS.ContentLocation,
    #MMS.ContentType,
    0x85 => MMS.Date,
    0x86 => MMS.DeliveryReport,
    0x87 => MMS.DeliveryTime,
    #0x8 => MMS.Expiry,
    #0x8 => MMS.From,
    #0x8 => MMS.MessageClass,
    #0x8 => MMS.MessageID,
    0x8c => MMS.MessageType,
    #MMS.MMSVersion,
    0x8e => MMS.MessageSize,
    0x8f => MMS.Priority,
    #MMS.ReportAllowed,
    #MMS.ResponseStatus,
    #MMS.ResponseText,
    #MMS.SenderVisibility,
    #MMS.ReadReport,
    #MMS.Status,
    #MMS.Subject,
    #MMS.To,
    #MMS.TransactionId,
    #MMS.RetrieveStatus,
    #MMS.RetrieveText,
    #MMS.ReadStatus,
    #MMS.ReplyCharging,
    #MMS.ReplyChargingDeadline,
    #MMS.ReplyChargingID,
    #MMS.ReplyChargingSize,
    #MMS.PreviouslySentBy,
    #MMS.PreviouslySentDate,
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
      {:error,        reason} -> error header, reason
    end
  end

  defp decode(rest, headers) do
    ok Enum.reverse(headers), rest
  end

  def encode headers do
    encode headers, []
  end

  defp encode [{header, value} | headers], results do
    case header.encode value do
      {:ok,     bytes} -> encode headers, [{header, bytes} | results]
      {:error, reason} -> error header, reason
    end
  end

  defp encode [], results do
    ok results |> Enum.reverse |> Enum.map(&prepend_header_byte/1) |> Enum.join
  end

  @reverse_map MMS.Mapper.reverse(@map)

  defp prepend_header_byte {header, bytes} do
    <<@reverse_map[header]>> <> bytes
  end
end
