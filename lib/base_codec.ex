defmodule MM1.BaseCodec do
  defmacro __using__(_opts) do
    quote do
      use MM1.BaseDecoder
      use MM1.DefaultEncoder
    end
  end
end
