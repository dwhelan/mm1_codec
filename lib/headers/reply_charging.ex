defmodule MMS.ReplyCharging do
  use MMS.Mapper,
      codec: MMS.Byte,
      values: [
        :requested,
        :requested_text_only,
        :accepted,
        :accepted_text_only,
      ],
      offset: 128
end
