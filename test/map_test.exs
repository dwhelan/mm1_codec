defmodule MMS.Mapper do
  @callback decode_map(any) :: any
  @callback encode_map(any) :: any

  defmacro defmapper decode_map, encode_map do
    quote do
      import OkError
      import Monad.Operators
      import OkError.Operators
      @behaviour MMS.Mapper

      def decode_map result do
        result
        ~> fn {value, rest} ->
             ok {unquote(decode_map).(value), rest}
           end
      end

      def encode_map value do
        value
        |> unquote(encode_map).()
      end
    end
  end
end

defmodule MMS.MapperTest do
  use MMS.CodecTest
  import MMS.Mapper

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
