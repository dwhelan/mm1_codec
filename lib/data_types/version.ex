defmodule MMS.OneOf do
  import MMS.OkError

  def decode _, [] do
    error :invalid_version
  end

  def decode bytes, [codec | codecs] do
    case_error codec.decode bytes do
      _ -> decode bytes, codecs
    end
  end

  def encode _, [] do
    error :invalid_version
  end

  def encode value, [codec | codecs] do
    case_error codec.encode value do
      _ -> encode value, codecs
    end
  end
end

defmodule MMS.Version do
  import MMS.OkError
  import MMS.DataTypes

  def decode bytes do
    MMS.OneOf.decode bytes, [MMS.IntegerVersion, MMS.String]
  end

  def encode value do
    MMS.OneOf.encode value, [MMS.IntegerVersion, MMS.String]
  end
end
