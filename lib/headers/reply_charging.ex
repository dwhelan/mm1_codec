defmodule MMS.ReplyCharging do
  use MMS.Codec,
      values: [
        :requested,
        :requested_text_only,
        :accepted,
        :accepted_text_only,
      ]
end
