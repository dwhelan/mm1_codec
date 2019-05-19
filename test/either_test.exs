defmodule MMS.EitherTest do
  use MMS.CodecTest
  import MMS.Either

  defmodule Ok1 do
    def decode(<<_ , rest::binary>>), do: ok {1, rest}
    def encode(_),                    do: ok <<1>>
  end

  defmodule Ok2 do
    def decode(<<_ , rest::binary>>), do: ok {2, rest}
    def encode(_),                    do: ok <<2>>
  end

  defmodule Error1 do
    def decode(bytes), do: error {:error1, bytes, 1}
    def encode(value), do: error {:error1, value, 1}
  end

  defmodule Error2 do
    def decode(bytes), do: error {:error2, bytes, 2}
    def encode(value), do: error {:error2, value, 2}
  end

  defmodule Error1Ok1Ok2 do
    defcodec as: [Error1, Ok1, Ok2]
  end

  defmodule Error1Error2 do
    defcodec as: [Error1, Error2]
  end

  describe "decode" do
    test "return ok from the first codec that decodes ok" do
      assert Error1Ok1Ok2.decode(<<0>>) == ok(1, "")
    end

    test "return error if all codecs fail  to decode" do
      assert Error1Error2.decode(<<0>>) == error(:error1_error2, <<0>>, error1: 1, error2: 2)
    end
  end

  describe "encode" do
    test "return ok from the first codec that encodes ok" do
      assert Error1Ok1Ok2.encode(0) == ok <<1>>
    end

    test "return error if all codecs fail" do
      assert Error1Error2.encode(0) == error :error1_error2, 0, error1: 1, error2: 2
    end
  end
end
