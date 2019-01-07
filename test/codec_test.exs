defmodule MMS.CodecTest do
  use ExUnit.Case

  use MMS.Codec

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
    test "handle no args" do
      assert codec_error() == error :invalid_codec_test, []
    end

    test "handle nil" do
      assert nil |> codec_error() == error :invalid_codec_test, []
    end

    test "use module error name as name" do
      assert error("x") |> codec_error == error :invalid_codec_test, ["x"]
    end

    test "maintain error history" do
      assert error({"x", ["history"]}) |> codec_error == error :invalid_codec_test, ["x", "history"]
    end

    test "short circuit oks" do
      assert ok("x") |> codec_error == ok("x")
    end

    test "short circuit ok tuples" do
      assert ok("x", "rest") |> codec_error == ok("x", "rest")
    end

    test "wrap input values as ok" do
      assert "x" |> codec_error == ok("x")
    end
  end
end
