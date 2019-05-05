defmodule MMS.OrTest do
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

  describe "decode/3 should" do
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

    test "should not compile with incorrect types" do
      assert_function_clause_error "MMS.Either.decode(:not_binary, [], :data_type)"
      assert_function_clause_error "MMS.Either.decode(\"\", :not_a_list, :data_type)"
      assert_function_clause_error "MMS.Either.decode(\"\", [], 'not an atom')"
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

  describe "using" do
    defmodule Ok1Error1 do
      defcodec either: [Ok1, Error1]
    end
    defmodule Error1Error2 do
      defcodec either: [Error1, Error2]
    end

    test "return ok from the first codec that decodes ok" do
      assert Ok1Error1.decode(<<0>>) == ok(1, "")
    end

    test "return error if all codecs fail  to decode" do
      assert Error1Error2.decode(<<0>>) == error(:error1_error2, <<0>>, error1: 1, error2: 2)
    end
    test "return ok from the first codec that encodes ok" do
      assert Ok1Error1.encode(0) == ok <<1>>
    end

    test "return error if all codecs fail" do
      assert Error1Error2.encode(0) == error(:error1_error2, 0, error1: 1, error2: 2)
    end
  end
end
