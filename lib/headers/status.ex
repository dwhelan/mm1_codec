defmodule MMS.Status do
  use MMS.Lookup,
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
