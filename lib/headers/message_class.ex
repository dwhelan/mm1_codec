defmodule MMS.MessageClass do
  use MMS.Mapper,
      codec: MMS.Short,
      values: [
        :personal,
        :advertisement,
        :informational,
        :auto,
      ]
end
