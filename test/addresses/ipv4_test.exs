defmodule MMS.Address.IPv4Test do
  use ExUnit.Case

  use MMS.MapExamples,
      mapper: MMS.Address.IPv4,
      error: :invalid_ipv4_address,
      examples: [
        { "0.0.0.0/TYPE=IPv4", {0, 0, 0, 0} },
      ],

      map_errors: [
        { "x.0.0.0/TYPE=IPv4", :invalid_ipv4_address },
        { "0.0.0.0/TYPE=xxxx", :invalid_ipv4_address },
        { :not_ipv6_address,   :invalid_ipv4_address },
      ],

      unmap_errors: [
        { :not_ipv4_address,        :invalid_ipv4_address },
        { {0, 0, 0, 'x'},           :invalid_ipv4_address },
        { {0, 0, 0, 0, 0, 0, 0, 0}, :invalid_ipv4_address },
      ]
end
