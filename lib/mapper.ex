defmodule MMS.Mapper do
  @callback decode_map(any) :: any
  @callback encode_map(any) :: any

  defmacro defmapper map = {:%{}, _, _} do
    decode_mapper = quote do & unquote(map)[&1] end
    encode_mapper = quote do & unquote(invert map)[&1] end

    create_mapper decode_mapper, encode_mapper
  end

  defmacro defmapper _ do
    raise ArgumentError, message: "You must pass a map"
  end

  defmacro defmapper(decode_mapper = {d, _, _}, encode_mapper = {e, _, _}) when d in [:fn, :&] and e in [:fn, :&] do
    create_mapper decode_mapper, encode_mapper
  end

  defmacro defmapper _, _ do
    raise ArgumentError, message: "You must pass two functions"
  end

  defp invert {:%{}, context, kv_pairs} do
    {:%{}, context, kv_pairs |> Enum.map(fn {k, v} -> {v, k} end)}
  end

  defp create_mapper decode_mapper, encode_mapper do
    quote do
      import OkError
      import Monad.Operators
      import OkError.Operators

      @behaviour MMS.Mapper

      def decode_map result do
        decode_mapper = unquote(decode_mapper)
        result
        ~> fn {value, rest} ->
             {value, rest}
             |> do_decode_map(decode_mapper)
             ~>> & handle_error value, &1
           end
      end

      defp do_decode_map {value, rest}, decode_mapper do
        case Function.info(decode_mapper)[:arity] do
          1 ->
            decode_mapper.(value)
            ~> fn value -> ok value, rest end
          2 ->
            decode_mapper.(value, rest)
        end
      end

      def encode_map value do
        value
        |> unquote(encode_mapper).()
        ~>> & handle_error value, &1
      end

      defp handle_error value, details do
        error {data_type(__MODULE__), value, details || :not_found}
      end
    end
  end
end
