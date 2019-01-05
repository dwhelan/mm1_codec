defmodule MMS.RetrieveStatus do
  use MMS.Lookup,
      map: %{
         0 => :ok,
        64 => :transient_failure,
        65 => :transient_message_not_found,
        66 => :transient_network_problem,
        96 => :permanent_failure,
        97 => :permanent_service_denied,
        98 => :permanent_message_not_found,
        99 => :content_unsupported,
      }
end
