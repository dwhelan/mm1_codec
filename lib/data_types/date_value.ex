defmodule MMS.DateValue do
  @moduledoc """
  Specification: OMA-WAP-MMS-ENC-V1_1-20040715-A 7.2.5 Date field

  Date-value = LongInteger-integer

  In seconds from 1970-01-01, 00:00:00 GMT
  """
  use MMS.Codec
  alias MMS.LongInteger

  def decode bytes do
    bytes
    |> decode_as(LongInteger, &DateTime.from_unix/1)
  end

  def encode date_time = %DateTime{} do
    date_time
    |> encode_as(LongInteger, &DateTime.to_unix/1)
  end
end
