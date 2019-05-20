defmodule MMS.TestCodecs do
  import MMS.Module
  import OkError

  alias MMS.TestCodecs.{List,  ListOk,  ListOkOk,  ListOkError,  ListErrorOk}
  alias MMS.TestCodecs.{Tuple, TupleOk, TupleOkOk, TupleOkError, TupleErrorOk}

  defmodule Ok do
    def decode(<<byte, rest :: binary>>), do: ok {byte, rest}
    def encode(value) when is_integer(value), do: ok <<value>>
    def encode(value), do: error {:data_type, value, :bad_type}
  end

  defmodule Error do
    def decode(bytes), do: error {:data_type, bytes, :reason}
    def encode(value), do: error {:data_type, value, :reason}
  end

  defmodule List do
    create []
    create [Ok]
    create [Ok, Ok]
    create [Ok, Error]
    create [Error, Ok]
  end

  create Tuple,        {}
  create TupleOk,      {Ok}
  create TupleOkOk,    {Ok, Ok}
  create TupleOkError, {Ok, Error}
  create TupleErrorOk, {Error, Ok}
end
