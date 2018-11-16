defmodule MM1.Result do
  @enforce_keys [:value]
  defstruct value: nil, bytes: <<>>, rest: <<>>, module: nil
end

