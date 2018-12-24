defmodule MMS.CodecMapper do
  
end

defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments
  @decode_map %{
    0x81 => MMS.Bcc,
    0x82 => MMS.Cc,
    0x83 => MMS.ContentLocation,
    0x84 => MMS.ContentType,
    0x85 => MMS.Date,
    0x86 => MMS.DeliveryReport,
    0x87 => MMS.DeliveryTime,
    0x88 => MMS.Expiry,
    0x89 => MMS.From,
    0x8a => MMS.MessageClass,
    0x8b => MMS.MessageId,
    0x8c => MMS.MessageType,
    0x8d => MMS.Version,
    0x8e => MMS.MessageSize,
    0x8f => MMS.Priority,
    0x90 => MMS.ReportAllowed,
    0x91 => MMS.ResponseStatus,
    0x92 => MMS.ResponseText,
    0x93 => MMS.SenderVisibility,
    0x94 => MMS.ReadReport,
    0x95 => MMS.Status,
    0x96 => MMS.Subject,
    0x97 => MMS.To,
    0x98 => MMS.TransactionId,
    0x99 => MMS.RetrieveStatus,
    0x9a => MMS.RetrieveText,
    0x9b => MMS.ReadStatus,
    0x9c => MMS.ReplyCharging,
    0x9d => MMS.ReplyChargingDeadline,
    0x9e => MMS.ReplyChargingId,
    0x9f => MMS.ReplyChargingSize,
    0xa0 => MMS.PreviouslySentBy,
    0xa1 => MMS.PreviouslySentDate,
  }

  import MMS.OkError

  def decode bytes do
    decode bytes, []
  end

  @codec_bytes Map.keys   @decode_map
  @codecs      Map.values @decode_map

  defp decode(<<byte, bytes:: binary>>, codecs) when byte in @codec_bytes do
    codec = @decode_map[byte]

    case codec.decode bytes do
      {:ok,    {value, rest}} -> decode rest, [{codec, value} | codecs]
      {:error,        reason} -> error codec, reason
    end
  end

  defp decode(<<byte, _:: binary>>, _) when byte not in @codec_bytes do
    error {:invalid_header, byte}
  end

  defp decode rest, values do
    ok Enum.reverse(values), rest
  end

  def encode values do
    encode values, []
  end

  defp encode [{codec, value} | values], results do
    case encode_one codec, value do
      {:ok,     bytes} -> encode values, [{codec, bytes} | results]
      {:error, reason} -> error codec, reason
    end
  end

  defp encode [], results do
    ok results |> Enum.reverse |> Enum.map(&prepend_codec_byte/1) |> Enum.join
  end

  defp encode_one(header, value) when header in @codecs do
    header.encode value
  end

  defp encode_one _, _ do
    error :unknown_header
  end

  @encode_map MMS.Mapper.reverse @decode_map

  defp prepend_codec_byte {codec, bytes} do
    <<@encode_map[codec]>> <> bytes
  end
end
