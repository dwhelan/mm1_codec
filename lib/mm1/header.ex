defmodule MM1.Header do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec opts[:codec]

      use MM1.BaseCodec

      @header MM1.Headers.header_byte __MODULE__

      def header_byte do
        @header
      end

      def decode <<@header, bytes::binary>> do
        bytes |> @codec.decode |> prefix_header_in_bytes |> return
      end

      defp prefix_header_in_bytes result do
        %MM1.Result{result | bytes: <<@header>> <> result.bytes}
      end

      def new value do
        value value, <<@header>> <> @codec.new(value).bytes
      end
    end
  end
end
