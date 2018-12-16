defmodule MMS.Embed do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec]] do
      defdelegate decode(bytes), to: codec
      defdelegate encode(value), to: codec
    end
  end
end
®
