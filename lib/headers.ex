defmodule MMS.Headers do
  @moduledoc """
  7. Binary Encoding of Protocol Data Units

  In the encoding of the header fields, the order of the fields is not significant,
  except that X-Mms-Message-Type, X-Mms- Transaction-ID (when present) and X-Mms-MMS-Version
  MUST be at the beginning of the message headers, in that order,
  and if the PDU contains a message body the Content Type MUST be the last header field, followed by message body.
  """

  use MMS.Codec
  alias MMS.Header

  def decode bytes do
    bytes
    |> do_decode([])
    ~> fn {headers, rest} ->
         headers
         |> validate_order(bytes)
         ~> &(ok &1, rest)
       end
    ~>> fn error -> error bytes, error end
  end

  defp do_decode <<>>, values do
    values
    |> ok(<<>>)
  end

  defp do_decode bytes, values do
    bytes
    |> Header.decode
    ~> fn {header, rest} -> do_decode rest, values ++ [header] end
  end

  defp validate_order headers, input do
    data_types = Enum.map(headers, fn {data_type, _} -> data_type end)

    cond do
      index(data_types, :message_type) != 0 -> error input, :message_type_must_be_first_header
      index(data_types, :transaction_id) != 1 -> error input, :mms_version_must_be_second_header
      true -> ok headers
    end
  end

  defp index headers, dt do
    Enum.find_index(headers, fn data_type ->  data_type == dt end)
  end

  def encode(values) when is_list(values) do
    values
    |> do_encode([])
  end

  def encode value do
    error value, :out_of_range
  end

  defp do_encode [], bytes_list do
    ok Enum.join bytes_list
  end

  defp do_encode [value | values], bytes_list do
    value
    ~> Header.encode
    ~> fn bytes -> do_encode values, bytes_list ++ [bytes] end
  end
end
