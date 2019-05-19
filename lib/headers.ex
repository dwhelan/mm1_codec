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
    error = fn details -> error input, details end
    index = fn data_type ->
              headers
              |> Enum.map(& elem(&1, 0))
              |> Enum.find_index(& &1 == data_type)
            end

    cond do
      index.(:message_type) != 0 ->
        error.(:message_type_must_be_first_header)

      index.(:transaction_id) not in [nil, 1] ->
        error.(:transaction_id_must_be_second_header_if_present)

      index.(:transaction_id) == nil && index.(:version) != 1 ->
        error.(:version_must_be_second_header_when_no_transaction_id)

      index.(:transaction_id) == 1 && index.(:version) != 2 ->
        error.(:version_must_be_third_header_when_transaction_id_present)

      index.(:content_type) != nil && index.(:content_type) != Enum.count(headers) - 1->
        error.(:content_type_must_be_the_last_header)

      true -> ok headers
    end
  end

  def encode(values) when is_list(values) do
    values
    |> do_encode([])
    ~>> fn error -> error values, error end
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
