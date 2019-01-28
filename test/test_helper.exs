ExUnit.start exclude: [:skip], include: [
  # Uncomment the line below to only run tests with: # @tag :focus
#     :focus], exclude: [:test
  ]


defmodule MMS.Test do
  def s(short),  do: short + 128
  def l(length), do: length

  def assert_code_raise code do
    ExUnit.Assertions.assert_raise ArgumentError, fn -> Code.eval_string(code) end
  end

  defmacro __using__ opts \\ [] do
    quote bind_quoted: [opts: opts] do
      use ExUnit.Case

      import MMS.Test
      import OldOkError
      import MMS.DataTypes
    end
  end
end

ExUnit.start()

defmodule CodecTest do
  def assert_code_raise error, code do
    ExUnit.Assertions.assert_raise error, fn -> Code.eval_string(code) end
  end
end

defmodule EncodeTest do
  defmacro __using__ _ do
    quote do
      use ExUnit.Case

      import DataTypes
      import OkError
      import Codec.Encode
    end
  end
end

defmodule DecodeTest do
  defmacro __using__ _ do
    quote do
      use ExUnit.Case

      import DataTypes
      import OkError
      import Codec.Decode
    end
  end
end
