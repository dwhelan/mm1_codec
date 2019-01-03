defmodule MMS.DateTime do
  use MMS.Codec

  alias MMS.Long

  def decode(bytes) when is_binary(bytes) do
    bytes |> Long.decode <~> DateTime.from_unix!
  end

  def encode %DateTime{} = date_time do
    date_time |> DateTime.to_unix <~> Long.encode
  end

  defaults()
end
