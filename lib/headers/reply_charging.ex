defmodule MMS.ReplyCharging do
  use MMS.Lookup,
      values: [
        :requested,
        :requested_text_only,
        :accepted,
        :accepted_text_only,
      ]
end
