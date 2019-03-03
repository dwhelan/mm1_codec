defmodule MMS.ReadStatus do
  @moduledoc """
  Read-status-value = Read | Deleted without being read

  Read                       = <Octet 128>
  Deleted without being read = <Octet 129>
  """

  use MMS.Codec2
  import Codec.Map
  alias MMS.Byte

  @values %{
    128 => :read,
    129 => :deleted_without_being_read,
  }

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode(Byte, @values)
  end

  def encode(value) when is_atom(value) do
    value |> encode(Byte, @values)
  end
end
