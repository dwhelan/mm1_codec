defmodule MMS.SenderVisibility do
  @moduledoc """
  OMA-WAP-MMS-ENC-V1_1-20040715-A; 7.2.31 X-Mms-Sender-Visibility field
  """
  use MMS.Codec
  alias MMS.Byte

  @map %{
    128 => :hide,
    129 => :show,
  }

  def decode(bytes) when is_binary(bytes) do
    bytes |> decode_with(Byte, @map)
  end

  def encode(value) when is_atom(value) do
    value |> encode_with(Byte, @map)
  end
end
