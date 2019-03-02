defmodule MMS.RetrieveStatus do
  use MMS.Codec2
  import Codec.Map
  alias MMS.{ShortInteger}

  @map %{
     0 => :ok,
    64 => :transient_failure,
    65 => :transient_message_not_found,
    66 => :transient_network_problem,
    96 => :permanent_failure,
    97 => :permanent_service_denied,
    98 => :permanent_message_not_found,
    99 => :content_unsupported,
  }

  def decode bytes do
    bytes |> decode(ShortInteger, @map)
  end

  def encode(value) when is_atom(value) do
    value |> encode(ShortInteger, @map)
  end
end
