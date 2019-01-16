defmodule OldOkError.String do

  def append( string, suffix), do: string <> suffix
  def prepend(string, prefix), do: prefix <> string

  def pascalcase string do
    string
    |> String.split(~r/[A-Z]+[^A-Z]*/, include_captures: true)
    |> Enum.map(&String.capitalize/1)
    |> Enum.join
  end
end
