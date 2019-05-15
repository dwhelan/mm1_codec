defmodule MMS.Codec do
  import OkError

  def is_module?(atom) when is_atom(atom) do
    atom
    |> to_string
    |> String.starts_with?("Elixir.")
  end

  def is_module?(_), do: false

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
    |> Enum.map(& String.capitalize/1)
    |> Enum.join
  end

  def ok value, rest do
    ok {value, rest}
  end

  def error data_type, input, details do
    error {data_type, input, details}
  end

  def map_value {:ok, {value, rest}}, function do
    case function.(value) do
      {:ok, value} -> ok value, rest
      {:error, error} -> error error
      nil -> error :nil
      value -> ok value, rest
    end
  end

  def map_value {:error, error}, _function do
    error error
  end

  defmacro error input, details do
    quote do
      error data_type(unquote __CALLER__.module), unquote(input), nest_error(unquote details)
    end
  end

  def nest_error(error = {data_type, _, details}) do
    [{data_type, details}]
  end

  def nest_error reason do
    reason
  end

  defmacro __using__ (_ \\ []) do
    quote do
      import MMS.DataTypes
      import Monad.Operators
      import OkError
      import OkError.Operators
      import MMS.Codec
      import MMS.DataTypes

      def decode <<>> do
        error <<>>, :no_bytes
      end

      def decode(value) when not is_binary(value) do
        error value, :must_be_binary
      end

      def encode value do
        error value, :bad_data_type
      end

      def data_type do
        data_type __MODULE__
      end

      defoverridable encode: 1
    end
  end
end
