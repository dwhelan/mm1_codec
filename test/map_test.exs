defmodule MMS.Mapper do
  @callback decode_map(any) :: any
  @callback encode_map(any) :: any

  defmacro defmapper map = {:%{}, _, _} do
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

  defmacro defmapper decode_mapper, encode_mapper do
    create_mapper decode_mapper, encode_mapper
  end

  defp create_mapper decode_mapper, encode_mapper do
    quote do
      import OkError
      import Monad.Operators
      import OkError.Operators

      @behaviour MMS.Mapper

      IO.inspect __MODULE__

      def decode_mapper result do
        result
        ~> fn {value, rest} ->
             value
             |> unquote(decode_mapper).()
             ~> fn mapped ->
                  ok {mapped, rest}
                end
             ~>> fn details -> error {data_type(__MODULE__), value, details || :not_found} end
           end
      end

      def encode_mapper value do
        new_value =
          value
          |> unquote(encode_mapper).()
          ~>> fn details -> error {data_type(__MODULE__), value, details || :not_found} end
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

    test "decode_mapper" do
      assert Plus1.decode_mapper(ok(1, "rest")) == ok(2, "rest")
      assert Plus1.decode_mapper(error(:data_type, "bytes", :reason)) == error(:data_type, "bytes", :reason)
    end

    test "encode_mapper" do
      assert Plus1.encode_mapper(2) == ok(1)
    end
  end

  describe "with captures" do
    defmodule Plus1 do
      import MMS.Mapper

      defmapper & &1 + 1, & &1 - 1
    end

    test "decode_mapper" do
      assert Plus1.decode_mapper(ok(1, "rest")) == ok(2, "rest")
      assert Plus1.decode_mapper(error(:data_type, "bytes", :reason)) == error(:data_type, "bytes", :reason)
    end

    test "encode_mapper" do
      assert Plus1.encode_mapper(2) == ok(1)
    end
  end

  describe "with a map" do
    defmodule CodecMap do
      import MMS.Mapper

      defmapper %{0 => :a, 1 => :b}
    end

    test "decode_mapper" do
      assert CodecMap.decode_mapper(ok(0, "rest")) == ok(:a, "rest")
      assert CodecMap.decode_mapper(ok(1, "rest")) == ok(:b, "rest")
      assert CodecMap.decode_mapper(ok(2, "rest")) == error {:codec_map, 2, :not_found}
    end

    test "encode_mapper" do
      assert CodecMap.encode_mapper(:a) == ok(0)
      assert CodecMap.encode_mapper(:b) == ok(1)
      assert CodecMap.encode_mapper(:c) == error {:codec_map, :c, :not_found}
    end
  end
end
