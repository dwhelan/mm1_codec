defmodule MMS.CodecTest do
  use ExUnit.Case

  use MMS.Codec

  test "prepend/2" do
    assert prepend("ello world", "h") == "hello world"
  end

  test "append/2" do
    assert append("hello worl", "d") == "hello world"
  end

  test "remove_trailing/2" do
    assert remove_trailing("hello world!", 1) == "hello world"
    assert remove_trailing("", 1)             == ""
  end

  def upcase!(reason), do: {:error, String.upcase reason}

  describe "<~> should" do
    test "pipe ok decoded tuples" do
      assert {:ok,{ "x", "rest"}} <~> String.upcase == ok "X", "rest"
    end

    test "pipe ok values" do
      assert {:ok, "x"} <~> String.upcase == ok "X"
    end

    test "wrap inputs as values" do
      assert "x" <~> String.upcase == {:ok, "X"}
    end

    test "ensure module errors" do
      assert {:error, "reason"} <~> String.upcase == {:error, :invalid_codec_test}
    end

    test "return module errorsif function returns an error" do
      assert {:ok, "x"} <~> upcase! == {:error, :invalid_codec_test}
    end
  end
end
