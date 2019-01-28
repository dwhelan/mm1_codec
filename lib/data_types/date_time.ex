defmodule MMS.DateTime do
  use MMS.Codec

  alias MMS.Long

  def decode bytes do
    bytes |> Long.decode <~> DateTime.from_unix
  end

  def encode date_time = %DateTime{} do
    date_time |> DateTime.to_unix |> Long.encode
  end

  def encode(_)  do
    {:error, __MODULE__}
  end
end
