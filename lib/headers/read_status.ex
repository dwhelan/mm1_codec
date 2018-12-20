defmodule MMS.ReadStatus do
  use MMS.Mapper,
      codec: MMS.Byte,
      values: [
        :read,
        :deleted,
      ],
      offset: 128
end
