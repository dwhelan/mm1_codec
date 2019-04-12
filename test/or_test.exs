defmodule MMS.OrTest do
  use MMS.CodecTest
  import MMS.Or

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

  describe "decode should" do
    test "return ok from the first codec that returns ok" do
      assert decode(<<0>>, [Ok1], :data_type) == ok(1, "")
      assert decode(<<0>>, [Ok1, Error1], :data_type) == ok(1, "")
      assert decode(<<0>>, [Ok1, Ok2, Error1], :data_type) == ok(1, "")

      assert decode(<<0>>, [Error1, Ok1], :data_type) == ok(1, "")
      assert decode(<<0>>, [Error1, Error2, Ok2, Ok1], :data_type) == ok(2, "")
    end

    test "return error if all codecs fail" do
      assert decode(<<0>>, [Error1], :data_type) == error(:data_type, <<0>>, [error1: 1])
      assert decode(<<0>>, [Error1, Error2], :data_type) == error(:data_type, <<0>>, [error1: 1, error2: 2])
    end
  end

  describe "decode macro should" do
    test "return ok from the first codec that returns ok" do
      assert decode(<<0>>, [Ok1, Error1]) == ok(1, "")
    end

    test "return error if all codecs fail" do
      assert decode(<<0>>, [Error1]) == error(:or_test, <<0>>, [error1: 1])
    end
  end

  describe "encode should" do
    test "return ok from the first codec that returns ok" do
      assert encode(0, [Ok1], :data_type) == ok <<1>>
      assert encode(0, [Ok1, Error1], :data_type) == ok <<1>>
      assert encode(0, [Ok1, Ok2, Error1], :data_type) == ok <<1>>

      assert encode(0, [Error1, Ok1], :data_type) == ok <<1>>
      assert encode(0, [Error1, Error2, Ok2, Ok1], :data_type) == ok <<2>>
    end

    test "return error if all codecs fail" do
      assert encode(0, [Error1], :data_type) == error {:data_type, 0, [error1: 1]}
      assert encode(0, [Error1, Error2], :data_type) == error {:data_type, 0, [error1: 1, error2: 2]}
    end
  end

  describe "encode macro should" do
    test "return ok from the first codec that returns ok" do
      assert encode(0, [Ok1, Error1]) == ok <<1>>
    end

    test "return error if all codecs fail" do
      assert encode(0, [Error1]) == error(:or_test, 0, [error1: 1])
    end
  end
end