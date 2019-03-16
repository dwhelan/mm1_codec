defmodule MMS.TupleTest do
  use MMS.CodecTest
  alias MMS.CodecTest.{Ok, Error}

  alias MMS.List
  alias MMS.Tuple

  @bytes <<1, 2, "rest">>

  describe "decode should" do
    test "return an empty tuple with no functions" do
      assert Tuple.decode(@bytes, {}) == ok {}, @bytes
    end

    test "return a single item tuple with one function" do
      assert Tuple.decode(@bytes, {Ok}) == ok {1}, <<2, "rest">>
    end

    test "return a multi-item tuple with multiple functions" do
      assert Tuple.decode(@bytes, {Ok, Ok}) == ok {1, 2}, <<"rest">>
    end

    test "return an error if it occurs on first function" do
      assert Tuple.decode(@bytes, {Error, Ok}) == error :list, @bytes, %{error: {:data_type, @bytes, :reason}, values: []}
    end

    test "return an error if it occurs on subsequent functions" do
      assert Tuple.decode(@bytes, {Ok, Error}) == error :list, @bytes, %{error: {:data_type, <<2, "rest">>, :reason}, values: [1]}
    end
  end

  describe "encode should" do
    test "encode an empty list of values" do
      assert List.encode([], []) == ok <<>>
    end

    test "List.encode a single value and function" do
      assert List.encode([1], [Ok]) == ok <<1>>
    end

    test "List.encode multiple values" do
      assert List.encode([1, 2], [Ok, Ok]) == ok <<1, 2>>
    end

    test "List.encode multiple values when a tuple" do
      assert List.encode({1, 2}, {Ok, Ok}) == ok <<1, 2>>
    end

    test "ignore extra values" do
      assert List.encode([1, 2], [Ok]) == ok <<1>>
    end

    test "ignore extra functions" do
      assert List.encode([1], [Ok, Ok]) == ok <<1>>
    end

    test "return an error if it occurs on first function" do
      assert List.encode([1,2], [Error, Ok]) == error :list, [1,2], {:data_type, 1, :reason}
    end

    test "return an error if it occurs on subsequent functions" do
      assert List.encode([1,2], [Ok, Error]) == error :list, [1, 2], {:data_type, 2, :reason}
    end
  end
end
