defmodule MMS.ReplyCharging do
  use MMS.Mapper,
      codec: MMS.Byte,
      map: %{
        128 => :requested,
        129 => :requested_text_only,
        130 => :accepted,
        131 => :accepted_text_only,
      }
end
