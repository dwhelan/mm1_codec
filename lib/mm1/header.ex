defmodule MM1.Header do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec opts[:codec]

      use MM1.BaseCodec

      @header MM1.Headers.byte __MODULE__

      def decode <<@header, bytes::binary>> do
        bytes |> @codec.decode |> prefix_header_in_bytes |> return
      end

      defp prefix_header_in_bytes result do
        %MM1.Result{result | bytes: <<@header>> <> result.bytes}
      end
    end
  end
end
