defmodule MMS.Mapper do
  @callback decode(any) :: any
  @callback encode(any) :: any

  defmacro defmapper fun do
    quote do
      import OkError
      import Monad.Operators
      import OkError.Operators
      @behaviour MMS.Mapper

      def decode result do
        result
        ~> fn {value, rest} ->
             ok {unquote(fun).(value), rest}
           end
      end

      def encode value do
        value
      end
    end
  end
end

defmodule MMS.MapperTest do
  use MMS.CodecTest
  import MMS.Mapper

  defmodule Plus1 do
    import MMS.Mapper

    defmapper fn x -> x + 1 end
  end

  test "decode" do
    assert Plus1.decode(ok(1, "rest")) == ok(2, "rest")
    assert Plus1.decode(error(:data_type, "bytes", :reason)) == error(:data_type, "bytes", :reason)
  end
end
