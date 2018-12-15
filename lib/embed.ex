defmodule MMS.Embed do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      defdelegate decode(bytes), to: opts[:codec]
      defdelegate encode(value), to: opts[:codec]
    end
  end
end
