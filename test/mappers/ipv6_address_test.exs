defmodule MMS.Mapper.IPv6AddressTest do
  use ExUnit.Case

  use MMS.MapExamples,
      mapper: MMS.Mapper.IPv6Address,
      error: :invalid_ipv6_address,
      examples: [
        { ":/TYPE=IPv6", {0, 0, 0, 0, 0, 0, 0, 0} },
      ],

      map_errors: [
        ":x/TYPE=IPv6",
        ":/TYPE=xxxx",
        :not_ipv6_address,
      ],

      unmap_errors: [
        :not_ipv6_address,
        {0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 'x'},
      ]
end
