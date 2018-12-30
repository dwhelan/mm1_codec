defmodule MMS.Address.PhoneNumberTest do
  use ExUnit.Case

  use MMS.MapExamples,
      mapper: MMS.Address.PhoneNumber,

      examples: [
        { "0/TYPE=PLMN",  "0"  },
        { "+0/TYPE=PLMN", "+0" },
        { "-/TYPE=PLMN",  "-"  },
        { "./TYPE=PLMN",  "."  },

        { "0123456789/TYPE=PLMN",  "0123456789" },
      ],

      map_errors: [
        "a/TYPE=PLMN",
        "0+/TYPE=PLMN",
        "1234567890/TYPE=xxxx",
        :not_phone_number,
      ],

      unmap_errors: [
        "a/TYPE=PLMN",
        "0+/TYPE=PLMN",
        "1234567890/TYPE=xxxx",
        :not_phone_number,
      ]
end
