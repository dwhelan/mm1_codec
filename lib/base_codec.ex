defmodule MM1.BaseCodec do
  defmacro __using__(opts \\ []) do
    quote bind_quoted: [opts: opts] do
      @module opts[:wrap]

      alias MM1.{Result, Error}

      if @module do
        def decode bytes do
          bytes |> @module.decode |> return
        end
      end

      def return %Result{} = result do
        %Result{value: result, bytes: <<>>, rest: <<>>, module: __MODULE__}
      end

      def return %Error{} = error do
        %Error{value: error, bytes: <<>>, rest: <<>>, module: __MODULE__}
      end
    end
  end
end

