defmodule MMS.ListTest do
  use MMS.CodecTest

  import MMS.List

  @bytes <<1, 2, "rest">>

  defmodule Ok do
    def decode(<<byte , rest::binary>>), do: ok(byte, rest)
    def encode(value),                   do: ok <<value>>
  end

  defmodule Error do
    def decode(bytes), do: error(:data_type, bytes, :reason)
    def encode(value), do: error(:data_type, value, :reason)
  end

  describe "decode should" do
    test "return an empty list with no function" do
      assert decode(@bytes, []) == ok [], @bytes
    end

    test "return a single item list with one function" do
      assert decode(@bytes, [Ok]) == ok [1], <<2, "rest">>
    end

    test "return a multi-item list with multiple functions" do
      assert decode(@bytes, [Ok, Ok]) == ok [1, 2], <<"rest">>
    end

    test "return an error if it occurs on first function" do
      assert decode(@bytes, [Error, Ok]) == error :list, @bytes, %{error: {:data_type, @bytes, :reason}, values: []}
    end

    test "return an error if it occurs on subsequent functions" do
      assert decode(@bytes, [Ok, Error]) == error :list, @bytes, %{error: {:data_type, <<2, "rest">>, :reason}, values: [1]}
    end
  end

  describe "encode should" do
    test "encode an empty list of values" do
      assert encode([], []) == ok <<>>
    end

    test "encode a single value and function" do
      assert encode([1], [Ok]) == ok <<1>>
    end

    test "encode multiple values" do
      assert encode([1, 2], [Ok, Ok]) == ok <<1, 2>>
    end

    test "ignore extra values" do
      assert encode([1, 2], [Ok]) == ok <<1>>
    end

    test "ignore extra functions" do
      assert encode([1], [Ok, Ok]) == ok <<1>>
    end

    test "return an error if it occurs on first function" do
      assert encode([1,2], [Error, Ok]) == error :list, [1,2], {:data_type, 1, :reason}
    end

    test "return an error if it occurs on subsequent functions" do
      assert encode([1,2], [Ok, Error]) == error :list, [1, 2], {:data_type, 2, :reason}
    end
  end
end
