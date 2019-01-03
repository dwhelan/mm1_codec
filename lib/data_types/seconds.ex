defmodule MMS.Seconds do
  use MMS.Codec

  alias MMS.Composer

  @absolute 0
  @relative 1

  @codecs [MMS.Short, MMS.Long]

  def decode bytes do
    bytes |> Composer.decode(@codecs) <~> to_seconds
  end

  defp to_seconds {seconds, @absolute} do
    DateTime.from_unix! seconds
  end

  defp to_seconds {seconds, @relative} do
    seconds
  end

  defp to_seconds _ do
    error()
  end

  def encode %DateTime{} = date_time do
    from_seconds DateTime.to_unix(date_time), @absolute
  end

  def encode seconds do
    from_seconds seconds, @relative
  end

  defp from_seconds seconds, absolute do
    Composer.encode [absolute, seconds], @codecs
  end
end
