defmodule MMS.WellKnownParametersTest do
  use ExUnit.Case
  alias MMS.WellKnownParameters

  use MMS.TestExamples,
      codec: WellKnownParameters,
      examples: [
        {<<128, 1>>,   q:       "0.00"},
        {<<129, 128>>, charset: :any  },

        # Multiple headers
        {<<128, 1, 128, 2>>, q: "0.00", q: "0.01"},
      ],

      encode_errors: [
        {[x: ""], {:x, :invalid_well_known_parameter}},
      ]

  test "decode should terminate when an unmapped byte is found" do
    assert WellKnownParameters.decode(<<128, 1, "rest">>) == {:ok, {[q: "0.00"], "rest"}}
  end
end
