defmodule MMS.Address.IPv4Test do
  use ExUnit.Case

  use MMS.MapExamples,
      mapper: MMS.Address.IPv4,
      examples: [
        { "0.0.0.0/TYPE=IPv4", {0, 0, 0, 0} },
      ],

      map_errors: [
#        { "value/TYPE",         :invalid_unknown_address },
#        { :not_unknown_address, :invalid_unknown_address },
      ],

      unmap_errors: [
#        { ≤:not_unknown_address,           :invalid_unknown_address },
#        { {:not_a_string, "type"       }, :invalid_unknown_address },
#        { {"value",       :not_a_string}, :invalid_unknown_address },
      ]
end
