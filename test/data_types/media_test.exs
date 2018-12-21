defmodule MMS.MediaTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.Media,
      examples: [
        {<<0x00>>, "*/*"},
      ]
end
