defmodule MMS.MessageClassTest do
  use ExUnit.Case

  use MMS.TestExamples,
      codec: MMS.MessageClass,
      examples: [
        {<<128       >>, :personal     },
        {<<129       >>, :advertisement},
        {<<130       >>, :informational},
        {<<131       >>, :auto         },
        {<<132       >>, 4             },
        {<<"other", 0>>, "other"       },
      ]end

