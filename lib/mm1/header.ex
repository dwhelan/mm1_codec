defmodule MM1.Header do
  defmacro __using__(opts) do
    quote bind_quoted: [codec: opts[:codec]] do
      @codec codec

      use MM1.Codecs.Default

      @header MM1.Headers.header_byte __MODULE__

      def header_byte do
        @header
      end

      def decode <<@header, bytes::binary>> do
        bytes |> @codec.decode |> map_result |> set_module
      end

      def new value do
        value |> @codec.new |> map_result |> set_module
      end

      def map_result result do
        %MM1.Result{result | bytes: <<@header>> <> result.bytes}
      end
    end
  end
end
