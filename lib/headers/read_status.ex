defmodule MMS.ReadStatus do
  @moduledoc """
  Read-status-value = Read | Deleted without being read

  Read                       = <Octet 128>
  Deleted without being read = <Octet 129>
  """

  use MMS.Codec
  alias MMS.Octet

  @map %{
    128 => :read,
    129 => :deleted_without_being_read,
  }

  def decode bytes do
    bytes
    |> decode_as(Octet, @map)
  end

  def encode(value) when is_atom(value) do
    value
    |> encode_as(Octet, @map)
  end
end
