defmodule MMS.ContentLocationTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.ContentLocation,
      examples: [
        {<<"abc", 0>>, "abc"}
      ]
end
