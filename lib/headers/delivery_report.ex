defmodule MMS.DeliveryReport do
  use MMS.Mapper,
      codec: MMS.Short,
      values: [
        :yes,
        :no,
      ]
end
