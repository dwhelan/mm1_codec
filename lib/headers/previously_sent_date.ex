defmodule MMS.PreviouslySentDate do
  import MMS.OkError

  alias MMS.{Composer, Integer, Date}

  def decode bytes do
    Composer.decode bytes, {Integer, Date}
  end

  def encode values do
    Composer.encode values, {Integer, Date}
  end
end
