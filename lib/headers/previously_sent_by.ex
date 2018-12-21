defmodule MMS.PreviouslySentBy do
  import MMS.OkError

  alias MMS.{Composer, Integer, Address}

  def decode bytes do
    Composer.decode bytes, {Integer, Address}
  end

  def encode {forwarded_count, sent_by} do
    Composer.encode {forwarded_count, sent_by}, {Integer, Address}
  end
end
