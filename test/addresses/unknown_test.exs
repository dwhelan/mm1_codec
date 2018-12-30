defmodule MMS.Address.UnknownTest do
  use ExUnit.Case

  use MMS.MapExamples,
      mapper: MMS.Address.Unknown,
      error: :invalid_unknown_address,
      examples: [
        { "value/TYPE=type", {"value", "type"} },
      ],

      map_errors: [
        "value/TYPE",
        "value/TYPE=type/TYPE=type",
        :not_unknown_address,
      ],

      unmap_errors: [
        :not_unknown_address,
        {:not_a_string, "type"},
        {"value", :not_a_string},
      ]
end
