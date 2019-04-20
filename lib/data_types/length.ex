defmodule MMS.Length do
  @moduledoc """
  8.4.2.2 Length

  Length = Uintvar-integer
  """
  use MMS.As

  defcodec as: MMS.UintvarInteger
end
