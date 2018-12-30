defmodule MMS.Address.EmailTest do
  use ExUnit.Case

  use MMS.MapExamples,
      mapper: MMS.Address.Email,

      examples: [
        { "@", "@" },
      ],

      map_errors: [
        "string without at",
        "@/TYPE=PLMN",
        :not_email,
      ],

      unmap_errors: [
        "string without at",
        "@/TYPE=PLMN",
        :not_email,
      ]
end
