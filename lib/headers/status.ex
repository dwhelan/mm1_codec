defmodule MMS.Status do
  use MMS.Mapper,
      codec: MMS.Byte,
      values: [
        :expired,
        :retrieved,
        :rejected,
        :deferred,
        :unrecognized,
        :indeterminate,
        :forwarded,
      ],
      offset: 128
end
