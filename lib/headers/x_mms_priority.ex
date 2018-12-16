defmodule MMS.XMmsPriority do
  use MMS.Mapper,
      codec: MMS.ShortInteger,
      values: [
        :low,
        :normal,
        :high,
      ]
end
