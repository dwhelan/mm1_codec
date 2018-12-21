defmodule MMS.PreviouslySentBy do
  import MMS.OkError

  alias MMS.{Composer, Short, Address}

  def decode bytes do
    Composer.decode bytes, {Short, Address}
  end

  def encode {forwarded_count, sent_by} do
    Composer.encode {forwarded_count, sent_by}, {Short, Address}
  end
end
