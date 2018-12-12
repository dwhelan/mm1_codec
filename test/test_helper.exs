ExUnit.start exclude: [:skip], include: [
  # Uncomment the line below to only run tests with: # @tag :focus
#     :focus], exclude: [:test
  ]

defmodule MM1.Codecs.Test do
  import Kernel, except: [inspect: 1]

  def inspect(values) when is_list(values) do
    "[ #{values |> Enum.map(&inspect/1) |> Enum.join(", ")} ]"
  end

  def inspect %MM1.Result{} = result do
    "%{module: #{result.module}, value: #{inspect result.value}"
  end

  def inspect value do
    string = Kernel.inspect value
  end

  def inspect value do
    Kernel.inspect value
  end

  def inspect2 value do
    string = value |> Kernel.inspect |> String.slice(0..40)
    end
end
