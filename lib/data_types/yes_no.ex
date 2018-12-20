defmodule MMS.YesNo do
  use MMS.Mapper,
      codec: MMS.Byte,
      values: [
        true,
        false,
      ],
      offset: 128
end
