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

defmodule Codec2Test do
  def uint32 value do
    value |> MMS.Uint32.encode |> elem(1)
  end

  def invalid_uint32 do
    <<128>>
  end

  defmacro __using__ _ do
    quote do
      use ExUnit.Case

      import OkError
      import Codec
      import Codec2Test
    end
  end
end
