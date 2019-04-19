defmodule MMS.Codec do
  import OkError
  import CodecError

  def is_module?(atom) when is_atom(atom), do: atom |> to_string |> String.starts_with?("Elixir.")
  def is_module?(_),                       do: false

  def ok value, rest do
    ok {value, rest}
  end

  def error data_type, input, details do
    error {data_type, input, details}
  end

  def nest_error({data_type, _, error}) when is_list(error) do
    [data_type | error]
  end

  def nest_error {data_type, _, error} do
    [data_type, error]
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
      import CodecError

      def decode <<>> do
        error <<>>, :no_bytes
      end

      def encode value do
        error value, :bad_data_type
      end

      defp error input, details do
        error data_type(), input, nest_error(details)
      end

      def data_type do
        data_type __MODULE__
      end

      defoverridable encode: 1
    end
  end
end
