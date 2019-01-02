defmodule MMS.Status do
  use MMS.Mapper,
      codec: MMS.Short,
      values: [
        :expired,
        :retrieved,
        :rejected,
        :deferred,
        :unrecognized,
        :indeterminate,
        :forwarded,
      ]
end
