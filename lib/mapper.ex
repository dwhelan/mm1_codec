defmodule MMS.Mapper do
  import MMS.Codec
  import OkError
  import Monad.Operators
  import OkError.Operators

  @callback decode_map(any) :: any
  @callback encode_map(any) :: any

  defmacro defmapper map = {:%{}, _, _} do
    create_mapper mapper(map), mapper(invert map)
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

  defp mapper map do
    quote do
      fn value -> unquote(map)[value] || error :not_found end
    end
  end

  def decode_map result, decode_mapper, module do
    result
    ~> fn {value, rest} ->
         {value, rest}
         |> do_decode_map(decode_mapper)
         ~>> & error {data_type(module), value, mapper: &1}
       end
  end

  defp do_decode_map {value, rest}, decode_mapper do
    do_decode_map {value, rest}, decode_mapper, Function.info(decode_mapper)[:arity]
  end

  defp do_decode_map {value, rest}, decode_mapper, 1 do
    value
    |> decode_mapper.()
    ~> fn value -> ok {value, rest} end
  end

  defp do_decode_map {value, rest}, decode_mapper, 2 do
    value
    |> decode_mapper.(rest)
  end

  def encode_map value, encode_mapper, module do
    value
    ~> fn value ->
         value
         |> encode_mapper.()
         ~>> & error {data_type(module), value, mapper: &1}
       end
  end

  defp invert {:%{}, context, kv_pairs} do
    {
      :%{},
      context,
      Enum.map(kv_pairs, fn {k, v} -> {v, k} end)
    }
  end

  defp create_mapper decode_mapper, encode_mapper do
    quote do
      @behaviour MMS.Mapper

      def decode_map result do
        result
        |> decode_map(unquote(decode_mapper), __MODULE__)
      end

      def encode_map value do
        value
        |> encode_map(unquote(encode_mapper), __MODULE__)
      end
    end
  end
end
