defmodule MMS.DeliveryReport do
  use MMS.Mapper,
      codec: MMS.ShortInteger,
      values: [
        :yes,
        :no,
      ]
end
