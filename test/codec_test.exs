defmodule MMS.CodecTest do
  use ExUnit.Case

  use MMS.Codec

  test "remove_trailing/2" do
    assert remove_trailing("hello world!", 1) == "hello world"
    assert remove_trailing("", 1)             == ""
  end

  def upcase!(reason), do: {:error, String.upcase reason}

  describe "<~> should" do
    test "pipe oks" do
      assert ok("x") <~> String.upcase == ok("X")
    end

    test "pipe decode oks" do
      assert ok("x", "rest") <~> String.upcase == ok("X", "rest")
    end

    test "wrap inputs" do
      assert "x" <~> String.upcase == ok("X")
    end

    test "ensure module errors" do
      assert error("reason") <~> String.upcase == error(:invalid_codec_test)
    end

    test "return module errors if function returns an error" do
      assert ok("x") <~> upcase! == error(:invalid_codec_test)
    end
  end

  describe "codec_error should" do
    @tag :skip
    test "add module atom to error" do
      assert error("x") |> codec_error == error({:invalid_codec_test, ["x"]})
    end

    test "short circuit plain values" do
      assert "x" |> codec_error == ok("x")
    end

    test "short circuit oks" do
      assert ok("x") |> codec_error == ok("x")
    end

    test "short circuit decode oks" do
      assert ok("x", "rest") |> codec_error == ok("x", "rest")
    end
  end
end
