defmodule MMS.Codec do
  import OkError
  import CodecError
  import OkError.Operators

  def is_module?(atom) when is_atom(atom), do: atom |> to_string |> String.starts_with?("Elixir.")
  def is_module?(_),                       do: false

  defp do_encode(f, value, map_codec, caller) do
    quote bind_quoted: [value: value, f: f, map_codec: map_codec, module: caller.module] do
      value
      |> f.()
      ~>  fn map_value -> map_value |> map_codec.encode end
      ~>> fn details   -> error data_type(module), value, nest_error(details) end
    end
  end

  defp invert {:%{}, context, kv_pairs} do
    {:%{}, context, kv_pairs |> Enum.map(fn {k, v} -> {v, k} end)}
  end

  defp to_map list do
    {:%{}, [], Enum.with_index(list)}
  end

  def ok value, rest do
    ok {value, rest}
  end

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

  defp identity do
    quote do & &1 end
  end

  defmacro defcodec as: delegate do
    quote do
      use MMS.Codec

      def decode bytes do
        bytes
        |> decode_as(unquote delegate)
      end

      def encode value do
        value
        |> encode_as(unquote delegate)
      end
    end
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
