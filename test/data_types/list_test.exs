defmodule MMS.ListTest do
  use MMS.CodecTest

  import MMS.List

  def decode_ok(<<value , rest::binary>>), do: ok  value, rest
  def decode_error(bytes),                 do: error :test, bytes, :error_reason

  @bytes <<1, 2, "rest">>

  describe "decode should" do
    test "return an empty list with no function" do
      assert decode(@bytes, []) == ok [], @bytes
    end

    test "return a single item list with one function" do
      assert decode(@bytes, [&decode_ok/1]) == ok [1], <<2, "rest">>
    end

    test "return a multi-item list with multiple functions" do
      assert decode(@bytes, [&decode_ok/1, &decode_ok/1]) == ok [1, 2], <<"rest">>
    end

    test "return an error if it occurs on first function" do
      assert decode(@bytes, [&decode_error/1, &decode_ok/1]) == error :list, @bytes, %{error: {:test, @bytes, :error_reason}, values: []}
    end

    test "return an error if it occurs on subsequent functions" do
      assert decode(@bytes, [&decode_ok/1, &decode_error/1]) == error :list, @bytes, %{error: {:test, <<2, "rest">>, :error_reason}, values: [1]}
    end
  end

  def encode_ok(value),    do: ok <<value>>
  def encode_error(value), do: error(:test, value, :error_reason)

  describe "encode should" do
    test "encode an empty list of values" do
      assert encode([], [&encode_ok/1]) == ok <<>>
    end

    test "encode a single value and function" do
      assert encode([1], [&encode_ok/1]) == ok <<1>>
    end

    test "encode multiple values" do
      assert encode([1, 2], [&encode_ok/1, &encode_ok/1]) == ok <<1, 2>>
    end

    test "ignore extra values" do
      assert encode([1, 2], [&encode_ok/1]) == ok <<1>>
    end

    test "ignore extra functions" do
      assert encode([1], [&encode_ok/1, &encode_ok/1]) == ok <<1>>
    end

    test "return an error if it occurs on first function" do
      assert encode([1,2], [&encode_error/1, &encode_ok/1]) == error :list, [1,2], {:test, 1, :error_reason}
    end

    test "return an error if it occurs on subsequent functions" do
      assert encode([1,2], [&encode_ok/1, &encode_error/1]) == error :list, [1, 2], {:test, 2, :error_reason}
    end
  end
end
