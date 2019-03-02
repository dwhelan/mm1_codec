defmodule MMS.ResponseStatus do
  use MMS.Codec2
  import Codec.Map
  alias MMS.{ShortInteger}

  @map %{
      0 => :ok,
      1 => :unspecified,
      2 => :service_denied,
      3 => :message_format_corrupt,
      4 => :sending_address_unresolved,
      5 => :message_not_found,
      6 => :network_problem,
      7 => :content_not_accepted,
      8 => :unsupported_message,
     64 => :transient_failure,
     65 => :transient_sending_address_unresolved,
     66 => :transient_message_not_found,
     67 => :transient_network_problem,
     96 => :permanent_failure,
     97 => :permanent_service_denied,
     98 => :permanent_message_format_corrupt,
     99 => :permanent_sending_address_unresolved,
    100 => :permanent_message_not_found,
    101 => :permanent_content_not_accepted,
    102 => :permanent_reply_charging_limitations_not_met,
    103 => :permanent_reply_charging_request_not_accepted,
    104 => :permanent_reply_charging_forwarding_denied,
    105 => :permanent_reply_charging_not_supported,
  }

  def decode bytes do
    bytes |> decode(ShortInteger, @map)
  end

  def encode(value) when is_atom(value) do
    value |> encode(ShortInteger, @map)
  end
end
