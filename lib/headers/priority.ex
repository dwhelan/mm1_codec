defmodule MMS.Priority do
  use MMS.Mapper,
      codec: MMS.Short,
      values: [
        :low,
        :normal,
        :high,
      ]
end
