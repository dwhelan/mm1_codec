defmodule MMS.Priority do
  use MMS.Mapper,
      codec: MMS.Byte,
      values: [
        :low,
        :normal,
        :high,
      ],
      offset: 128
end
