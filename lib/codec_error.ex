defmodule CodecError do
  import OkError

  def data_type module do
    module
    |> to_string
    |> String.split(".")
    |> List.last
    |> pascalcase
    |> Macro.underscore
    |> String.to_atom
  end

  def pascalcase string do
    string
    |> String.split(~r/[A-Z]+[^A-Z]*/, include_captures: true)
    |> Enum.map(&String.capitalize/1)
    |> Enum.join
  end
end
