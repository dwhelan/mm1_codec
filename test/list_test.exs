defmodule MMS.ListTest do
  use MMS.CodecTest
  alias MMS.TestCodecs.{List}

  require MMS.TestCodecs

  @bytes <<1, 2>>

  describe "decode should" do
    test "return an empty list with no codecs" do
      assert List.Empty.decode(@bytes) == ok [], @bytes
    end

    test "return a single item list with one codec" do
      assert List.Ok.decode(@bytes) == ok [1], <<2>>
    end

    test "return a multi-item list with multiple codecs" do
      assert List.OkOk.decode(@bytes) == ok [1, 2], <<>>
    end

    test "return an error if it occurs on first decode" do
      assert List.ErrorOk.decode(@bytes) == error :list, @bytes, %{error: {:data_type, @bytes, :reason}, values: []}
    end

    test "return an error if it occurs on subsequent decodes" do
      assert List.OkError.decode(@bytes) == error :list, @bytes, %{error: {:data_type, <<2>>, :reason}, values: [1]}
    end
  end

  describe "encode should" do
    test "encode an empty list of values" do
      assert List.Empty.encode([]) == ok <<>>
    end

    test "List.encode a single value and codec" do
      assert List.Ok.encode([1]) == ok <<1>>
    end

    test "List.encode multiple values" do
      assert List.OkOk.encode([1, 2]) == ok <<1, 2>>
    end

    test "ignore extra values" do
      assert List.Ok.encode([1, 2]) == ok <<1>>
    end

    test "ignore extra codecs" do
      assert List.OkOk.encode([1]) == ok <<1>>
    end

    test "return an error if it occurs on first encode" do
      assert List.ErrorOk.encode([1,2]) == error :list, [1,2], {:data_type, 1, :reason}
    end

    test "return an error if it occurs on subsequent encodes" do
      assert List.OkError.encode([1,2]) == error :list, [1, 2], {:data_type, 2, :reason}
    end
  end
end
