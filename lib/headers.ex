defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments

  use MMS.Codec
  alias MMS.Header

  def decode bytes do
    bytes
    |> do_decode([])
  end

  defp do_decode <<>>, values do
    values
    |> ok(<<>>)
  end

  defp do_decode bytes, values do
    bytes
    |> Header.decode
    ~> fn {header, rest} -> do_decode rest, [header] ++ values end
  end

  def encode values do
    values
    |> do_encode([])
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
