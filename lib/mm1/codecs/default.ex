defmodule MM1.Codecs.Default do
  defmacro __using__(_opts) do
    quote do
      use MM1.Codecs.Base
      use MM1.DefaultEncoder
    end
  end
end
