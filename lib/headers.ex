defmodule MMS.Headers do
  # Based on OMA-WAP-MMS-ENC-V1_1-20040715-A: Table 12. Field Name Assignments

  use MMS.Codec

  def decode bytes do
      bytes
      |> do_decode([])
  end

  defp do_decode <<>>, headers do
      headers
      |> Enum.reverse
      |> ok(<<>>)
  end

  defp do_decode bytes, headers do
      bytes
      |> MMS.Header.decode
      ~> fn {header, rest} -> do_decode rest, [header | headers] end
  end

  def encode headers do
       headers
       |> do_encode([])
  end

  def do_encode [], bytes_list do
        bytes_list
        |> Enum.reverse
        |> Enum.join
        |> ok
  end

  def do_encode [header | headers], bytes_list do
      header
      |> MMS.Header.encode
      ~> fn bytes -> do_encode headers, [bytes | bytes_list] end
  end
end
