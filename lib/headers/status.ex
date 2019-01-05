defmodule MMS.Status do
  use MMS.Codec,
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
