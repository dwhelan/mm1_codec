defmodule MM1.Message do
  use MM1.Codecs.Wrapper

  def codec do
    MM1.Headers
  end
end
