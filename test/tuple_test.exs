defmodule MMS.TupleTest do
  use MMS.CodecTest
  alias MMS.CodecTest.{Ok, Error}

  alias MMS.Tuple

  @bytes <<1, 2, "rest">>

  import MMS.Tuple

  defmodule EmptyFunctions do tuple_codec [] end
  defmodule OkCodec do tuple_codec [Ok] end
  defmodule ErrorCodec do tuple_codec [Error] end
  defmodule OkOkCodec do tuple_codec [Ok, Ok] end
  defmodule ErrorOkCodec do tuple_codec [Error, Ok] end
  defmodule OkErrorCodec do tuple_codec [Ok, Error] end

  test "decode" do
    assert EmptyFunctions.decode(@bytes) == ok {}, @bytes
    assert OkCodec.decode(@bytes) == ok {1}, <<2, "rest">>
    assert OkOkCodec.decode(@bytes) == ok {1, 2}, <<"rest">>
    assert OkErrorCodec.decode(@bytes) == error :ok_error_codec, @bytes, %{error: {:data_type, <<2, "rest">>, :reason}, values: [1]}
    assert ErrorCodec.decode(@bytes) == error :error_codec, @bytes, %{error: {:data_type, @bytes, :reason}, values: []}
    assert ErrorOkCodec.decode(@bytes) == error :error_ok_codec, @bytes, %{error: {:data_type, @bytes, :reason}, values: []}
  end

  test "encode" do
    assert EmptyFunctions.encode({}) == ok <<>>
    assert OkCodec.encode({1}) == ok <<1>>
    assert OkOkCodec.encode({1, 2}) == ok <<1, 2>>
    assert OkErrorCodec.encode({1, 2}) == error :ok_error_codec, {1, 2}, {:data_type, 2, :reason}
    assert ErrorCodec.encode({1}) == error :error_codec, {1}, {:data_type, 1, :reason}
    assert ErrorOkCodec.encode({1, 2}) == error :error_ok_codec, {1, 2}, {:data_type, 1, :reason}
  end
end
