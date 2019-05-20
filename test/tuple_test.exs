defmodule MMS.TupleTest do
  use MMS.CodecTest
  alias MMS.TestCodecs.{Tuple, TupleOk, TupleOkOk, TupleOkError, TupleErrorOk}

  @bytes <<1, 2>>

  describe "decode should" do
    test "return an empty tuple with no codecs" do
      assert Tuple.decode(@bytes) == ok {}, @bytes
    end

    test "return a single item tuple with one codec" do
      assert TupleOk.decode(@bytes) == ok {1}, <<2>>
    end

    test "return a multi-item tuple with multiple codecs" do
      assert TupleOkOk.decode(@bytes) == ok {1, 2}, <<>>
    end

    test "return an error if it occurs on first decode" do
      assert TupleErrorOk.decode(@bytes) == error :list, @bytes, %{error: {:data_type, @bytes, :reason}, values: []}
    end

    test "return an error if it occurs on subsequent decode" do
      assert TupleOkError.decode(@bytes) == error :list, @bytes, %{error: {:data_type, <<2>>, :reason}, values: [1]}
    end
  end

  describe "encode should" do
    test "encode an empty list of values" do
      assert Tuple.encode({}) == ok <<>>
    end

    test "encode a single value and codec" do
      assert TupleOk.encode({1}) == ok <<1>>
    end

    test "encode multiple values" do
      assert TupleOkOk.encode({1, 2}) == ok <<1, 2>>
    end

    test "ignore extra values" do
      assert TupleOk.encode({1, 2}) == ok <<1>>
    end

    test "ignore extra codecs" do
      assert TupleOkOk.encode({1}) == ok <<1>>
    end

    test "return an error if it occurs on first encode" do
      assert TupleErrorOk.encode({1,2}) == error :list, {1,2}, {:data_type, 1, :reason}
    end

    test "return an error if it occurs on subsequent encode" do
      assert TupleOkError.encode({1,2}) == error :list, {1, 2}, {:data_type, 2, :reason}
    end
  end
end
