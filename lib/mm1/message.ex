defmodule MM1.Message do
  use MM1.Codecs.Wrapper

  def codec do
    MM1.Headers
  end
end

defmodule MM2.Message do
  import MM1.Codecs2.Wrapper

  wrap MM2.Headers
end
