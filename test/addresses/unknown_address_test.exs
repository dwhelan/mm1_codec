defmodule MMS.UnknownAddressTest do
  use ExUnit.Case

  use MMS.MapExamples,
      mapper: MMS.UnknownAddress,
      error: :invalid_unknown_address,
      examples: [
        { "value/TYPE=type", {"value", "type"} },
      ],

      map_errors: [
        "value/TYPE",
        "value/TYPE=PLMN",
        "value/TYPE=IPv4",
        "value/TYPE=IPv6",
        "value/TYPE=type/TYPE=type",
        :not_unknown_address,
      ],

      unmap_errors: [
        :not_unknown_address,
        {:not_a_string, "type"},
        {"value", :not_a_string},
        {"value", "PLMN"},
        {"value", "IPv4"},
        {"value", "IPv6"},
      ]
end
