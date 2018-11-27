defmodule MM1.IdentityMapper do
  def map anything do
    anything
  end
  def unmap anything do
    anything
  end
end

defmodule MM1.Header do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec  opts[:codec]
      @mapper opts[:mapper] || MM1.IdentityMapper

      use MM1.BaseCodec

      @header MM1.Headers.header_byte __MODULE__

      def header_byte do
        @header
      end

      def decode <<@header, bytes::binary>> do
        bytes |> @codec.decode |> prefix_header_in_bytes |> @mapper.map |> embed
      end

      defp prefix_header_in_bytes result do
        %MM1.Result{result | bytes: <<@header>> <> result.bytes}
      end

      def new value do
        ok value, <<@header>> <> @codec.new(@mapper.unmap value).bytes
      end
    end
  end
end
