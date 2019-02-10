defmodule MMS.ValueLengthComposerTest do
  use MMS.CodecTest

  import MMS.ValueLengthComposer

  def decode_ok(<<value , rest::binary>>), do: ok {value, rest}
  def decode_error(bytes),                 do: error(:test, bytes, nil)

  @bytes <<l(2), 3, 4, 5>>

  describe "decode should" do
    test "return nested values" do
      assert decode(@bytes, [&decode_ok/1, &decode_ok/1]) == ok [2, 3, 4], <<5>>
    end

    test "return error if too few bytes used" do
      assert decode(@bytes, [&decode_ok/1]) == error [error(:incorrect_value_length, 2, [bytes_actually_used: 1]), 3]
    end

    test "return error if too many bytes used" do
      assert decode(@bytes, [&decode_ok/1, &decode_ok/1, &decode_ok/1]) == error [error(:incorrect_value_length, 2, [bytes_actually_used: 3]), 3, 4, 5]
    end

    test "return error if any decoder returns an error" do
      assert decode(@bytes, [&decode_error/1]) == error [2, {:error, {:test, <<3, 4, 5>>, nil}}]
    end
  end
end

defmodule MMS.Composer2Test do
  use MMS.CodecTest

  import MMS.Composer2

  def decode_ok(<<value , rest::binary>>), do: ok {value, rest}
  def decode_error(bytes),                 do: error(:test, bytes, nil)

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
      assert decode(@bytes, [&decode_error/1, &decode_ok/1]) == error [error(:test, @bytes, nil)]
    end

    test "return an error if it occurs on subsequent functions" do
      assert decode(@bytes, [&decode_ok/1, &decode_error/1]) == error [1, error(:test, <<2, "rest">>, nil)]
    end
  end

  def encode_ok(value),    do: ok <<value>>
  def encode_error(value), do: error(:test, value, nil)

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
      assert encode([1,2], [&encode_error/1, &encode_ok/1]) == error [error(:test, 1, nil)]
    end

    test "return an error if it occurs on subsequent functions" do
      assert encode([1,2], [&encode_ok/1, &encode_error/1]) == error [<<1>>, error(:test, 2, nil)]
    end
  end
end
