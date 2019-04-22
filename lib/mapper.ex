defmodule MMS.Mapper do
  @callback decode_map(any) :: any
  @callback encode_map(any) :: any

  defmacro defmapper map = {:%{}, _, _} do
    decode_mapper = quote do & unquote(map)[&1] end
    encode_mapper = quote do & unquote(invert map)[&1] end

    create_mapper decode_mapper, encode_mapper
  end

  defmacro defmapper(decode_mapper = {d, _, _}, encode_mapper = {e, _, _}) when d in [:fn, :&] and e in [:fn, :&] do
    create_mapper decode_mapper, encode_mapper
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
        result
        ~> fn {value, rest} ->
             value
             |> unquote(decode_mapper).()
             ~> fn mapped -> ok {mapped, rest} end
             ~>> fn details -> error {data_type(__MODULE__), value, details || :not_found} end
           end
      end

      def encode_map value do
        value
        |> unquote(encode_mapper).()
        ~>> fn details -> error {data_type(__MODULE__), value, details || :not_found} end
      end
    end
  end
end
