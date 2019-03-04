defmodule MMS.Codec2 do
  import OkError
  import CodecError
  import OkError.Operators

  def decode_ok value, rest do
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

  defmacro decode_with bytes, codec, opts \\ [] do
    ok = opts[:ok] || identity()
    error = case opts[:nest_errors] do
      false -> identity()
      _     -> nested_error(__CALLER__.module, bytes)
    end

    quote do
      unquote(bytes)
      |> unquote(codec).decode
      ~> unquote(ok)
      ~>> unquote(error)
    end
  end

  defp identity do
    quote do & &1 end
  end

  defp nested_error codec, input do
    quote do & error data_type(unquote codec), unquote(input), nest_error(&1) end
  end

  defmacro encode_with value, codec do
    data_type = data_type( __CALLER__.module)
    quote do
      Kernel.apply(unquote(codec), :encode, [unquote(value)])
      ~>> fn details -> error unquote(data_type), unquote(value), nest_error(details) end
    end
  end

  defmacro __using__ (_ \\ []) do
    quote do
      import MMS.DataTypes
      import Monad.Operators
      import OkError
      import OkError.Operators
      import MMS.Codec2
      import CodecError

      def decode <<>> do
        error {data_type(), <<>>, :no_bytes}
      end

      @deprecate "Use decode_error/2 or encode_error/2"
      defp error input, details do
        error data_type(), input, nest_error(details)
      end

      defp decode_error input, details do
        error data_type(), input, nest_error(details)
      end

      defp encode_error input, details do
        error data_type(), input, nest_error(details)
      end
    end
  end
end
