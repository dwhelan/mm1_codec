defmodule MMS.DateValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Date-value = Long-integer

  The encoding of dates shall be done in number of seconds from 1970-01-01, 00:00:00 GMT.
  """
  use MMS.Codec
  import MMS.As

  alias MMS.LongInteger

  def decode bytes do
    bytes
    |> decode_as(LongInteger, &DateTime.from_unix/1)
  end

  def encode date_time = %DateTime{} do
    date_time
    |> encode_as(LongInteger, &DateTime.to_unix/1)
  end

  def encode value do
    super value
  end
end
