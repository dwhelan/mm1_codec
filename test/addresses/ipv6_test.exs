defmodule MMS.Address.IPv6Test do
  use ExUnit.Case

  use MMS.MapExamples,
      mapper: MMS.Address.IPv6,
      error: :invalid_ipv6_address,
      examples: [
        { ":/TYPE=IPv6", {0, 0, 0, 0, 0, 0, 0, 0} },
      ],

      map_errors: [
        { ":x/TYPE=IPv6",    :invalid_ipv6_address },
        { ":/TYPE=xxxx",     :invalid_ipv6_address },
        { :not_ipv6_address, :invalid_ipv6_address },
      ],

      unmap_errors: [
        { :not_ipv6_address,          :invalid_ipv6_address },
        { {0, 0, 0, 0},               :invalid_ipv6_address },
        { {0, 0, 0, 0, 0, 0, 0, 'x'}, :invalid_ipv6_address },
      ]
end
