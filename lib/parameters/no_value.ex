defmodule MMS.NoValue do
  import MMS.OkError

  def decode <<0, rest::binary>> do
    ok :no_value, rest
  end

  def decode _ do
    error :invalid_no_value
  end

  def encode :no_value do
    ok <<0>>
  end

  def encode _ do
    error :invalid_no_value
  end
end
