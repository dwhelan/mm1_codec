defmodule MMS.RetrieveStatus do
  use MMS.Lookup,
      codec: MMS.Byte,
      map: %{
        128 => :ok,
        192 => :transient_failure,
        193 => :transient_message_not_found,
        194 => :transient_network_problem,
        224 => :permanent_failure,
        225 => :permanent_service_denied,
        226 => :permanent_message_not_found,
        227 => :content_unsupported,
      }
end
