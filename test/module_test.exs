defmodule MMS.ModuleTest do
  use MMS.CodecTest
  alias MMS.CodecTest.{Ok, Error}
  alias MMS.TestCodecs.{List}

  @bytes <<1, 2, "rest">>

  require MMS.TestCodecs
  import List

#  defmodule OkCodec do defcodec as: [Ok] end
#  defmodule OkOkCodec do defcodec as: [Ok, Ok] end
#  defmodule OkErrorCodec do defcodec as: [Ok, Error] end
#  defmodule ErrorCodec do defcodec as: [Error] end
#  defmodule ErrorOkCodec do defcodec as: [Error, Ok] end
#  defmodule ErrorErrorCodec do defcodec as: [Error, Error] end

  test "decode" do
    assert List.decode(@bytes) == ok [], @bytes
#    assert OkCodec.decode(@bytes) == ok [1], <<2, "rest">>
#    assert OkOkCodec.decode(@bytes) == ok [1, 2], <<"rest">>
#    assert OkErrorCodec.decode(@bytes) == error :ok_error_codec, @bytes, %{error: {:data_type, <<2, "rest">>, :reason}, values: [1]}
#    assert ErrorCodec.decode(@bytes) == error :error_codec, @bytes, %{error: {:data_type, @bytes, :reason}, values: []}
#    assert ErrorOkCodec.decode(@bytes) == error :error_ok_codec, @bytes, %{error: {:data_type, @bytes, :reason}, values: []}
#    assert ErrorErrorCodec.decode(@bytes) == error :error_error_codec, @bytes, %{error: {:data_type, @bytes, :reason}, values: []}
  end

  test "encode" do
    assert List.encode([]) == ok <<>>
#    assert OkCodec.encode([1]) == ok <<1>>
#    assert OkOkCodec.encode([1, 2]) == ok <<1, 2>>
#    assert OkErrorCodec.encode([1, 2]) == error :ok_error_codec, {1, 2}, data_type: :reason
#    assert ErrorCodec.encode({1}) == error :error_codec, {1}, data_type: :reason
#    assert ErrorOkCodec.encode({1, 2}) == error :error_ok_codec, {1, 2}, data_type: :reason
#    assert ErrorErrorCodec.encode({1, 2}) == error :error_error_codec, {1, 2}, data_type: :reason
  end
end
