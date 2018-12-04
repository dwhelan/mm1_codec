defmodule MM1.Header do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec opts[:codec]

      use MM1.Codecs.Base

      if opts[:map] do
        @codec String.to_atom "#{__MODULE__}.Codec"
        MM1.Codecs.Mapper.create @codec, opts
      end

      @header opts[:value]

      def header_byte do
        @header
      end

      def decode <<@header, bytes::binary>> do
        bytes |> @codec.decode |> map_result
      end

      def new value do
        value |> @codec.new |> map_result
      end

      defp map_result result do
        %MM1.Result{result | module: __MODULE__, bytes: <<header_byte()>> <> result.bytes}
      end
    end
  end
end
