defmodule MMS.BooleanTest do
  use ExUnit.Case
  import MMS.Test

  use MMS.TestExamples,
      codec: MMS.Boolean,
      examples: [
        { << s(0) >>, true  },
        { << s(1) >>, false },
      ],

      decode_errors: [
        { 0,    :invalid_boolean },
        { s(2), :invalid_boolean },
      ],

      encode_errors: [
        { :not_boolean, :invalid_boolean },
      ]
end

