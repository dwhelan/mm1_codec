defmodule MM1.Message do
  require MM1.Headers

  use MM1.BaseCodec, wrap: MM1.Headers
end
