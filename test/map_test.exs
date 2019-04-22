defmodule MMS.Mapper do
  @callback decode_map(any) :: any
  @callback encode_map(any) :: any

  defmacro defmapper map do
    decode_map =
      quote do
        fn value ->
          unquote(map)[value]
        end
      end

    encode_map =
      quote do
        fn value ->
          unquote(invert map)[value]
        end
      end

    create_mapper decode_map, encode_map
  end

  defmacro defmapper decode_map, encode_map do
    create_mapper decode_map, encode_map
  end

  defp create_mapper decode_map, encode_map do
    quote do
      import OkError
      import Monad.Operators
      import OkError.Operators

      @behaviour MMS.Mapper

      IO.inspect __MODULE__

      def decode_map result do
        result
        ~> fn {value, rest} ->
             value
             |> unquote(decode_map).()
             ~> fn mapped ->
                  ok {mapped, rest}
                end
             ~>> fn details -> error {data_type(__MODULE__), value, details || :not_found} end
           end
      end

      def encode_map value do
        new_value =
          value
          |> unquote(encode_map).()

        if new_value == nil do
          error {data_type(__MODULE__), value, :not_found}
        else
          new_value
        end
      end
    end
  end

  defp invert {:%{}, context, kv_pairs} do
    {:%{}, context, kv_pairs |> Enum.map(fn {k, v} -> {v, k} end)}
  end
end

defmodule MMS.MapperTest do
  use MMS.CodecTest
  import MMS.Mapper

  describe "with functions" do
    defmodule Plus1 do
      import MMS.Mapper

      defmapper fn x -> x + 1 end, fn x -> x - 1 end
    end

    test "decode_map" do
      assert Plus1.decode_map(ok(1, "rest")) == ok(2, "rest")
      assert Plus1.decode_map(error(:data_type, "bytes", :reason)) == error(:data_type, "bytes", :reason)
    end

    test "encode_map" do
      assert Plus1.encode_map(2) == 1
    end
  end

  describe "with a map" do
    defmodule CodecMap do
      import MMS.Mapper

      defmapper %{0 => :a, 1 => :b}
    end

    test "decode_map" do
      assert CodecMap.decode_map(ok(0, "rest")) == ok(:a, "rest")
      assert CodecMap.decode_map(ok(1, "rest")) == ok(:b, "rest")
      assert CodecMap.decode_map(ok(2, "rest")) == error {:codec_map, 2, :not_found}
    end

    test "encode_map" do
      assert CodecMap.encode_map(:a) == 0
      assert CodecMap.encode_map(:b) == 1
      assert CodecMap.encode_map(:c) == error {:codec_map, :c, :not_found}
    end
  end
end
