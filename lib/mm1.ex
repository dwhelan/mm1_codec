defmodule MM1 do
  @moduledoc """
  """

  require WAP.Octet

  defdelegate decode(bytes), to: WAP.Octet
end
