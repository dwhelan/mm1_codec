defmodule MMS.Address.PhoneNumberTest do
  use ExUnit.Case

  use MMS.MapExamples,
      mapper: MMS.Address.PhoneNumber,

      examples: [
        { "1234567890/TYPE=PLMN", "1234567890" },
      ],

      map_errors: [
        "@/TYPE=PLMN",
        "1234567890/TYPE=xxxx",
        :not_phone_number,
      ],

      unmap_errors: [
        :not_phone_number,
        "@",
      ]
end
