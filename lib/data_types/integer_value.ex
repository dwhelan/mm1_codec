defmodule MMS.IntegerValue do
  @moduledoc """
  8.4.2.3 Parameter Values

  Integer-Value = Short-integer | Long-integer
  """
  import MMS.Either

  defcodec as: [MMS.ShortInteger, MMS.LongInteger]
end
