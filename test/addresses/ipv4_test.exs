defmodule MMS.Address.IPv4Test do
  use ExUnit.Case

  use MMS.MapExamples,
      mapper: MMS.Address.IPv4,
      error: :invalid_ipv4_address,

      examples: [
        { "0.0.0.0/TYPE=IPv4", {0, 0, 0, 0} },
      ],

      map_errors: [
        "x.0.0.0/TYPE=IPv4",
        "0.0.0.0/TYPE=xxxx",
        :not_ipv6_address,
      ],

      unmap_errors: [
        :not_ipv4_address,
        {0, 0, 0, 'x'},
        {0, 0, 0, 0, 0, 0, 0, 0},
      ]
end
