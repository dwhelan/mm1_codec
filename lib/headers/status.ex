defmodule MMS.Status do
  use MMS.Mapper,
      codec: MMS.Byte,
      map: %{
        128 => :expired,
        129 => :retrieved,
        130 => :rejected,
        131 => :deferred,
        132 => :unrecognized,
        133 => :indeterminate,
        134 => :forwarded,
      }
end
