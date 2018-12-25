defmodule MMS.WellKnownParameters do
  # Based on WAP-230-WSP-20010705-a: Table 38. Well-Known Parameter Assignments
  #
  # The values below are expressed as short-integers so the map starts at 128

  use MMS.CodecMapper,
      map: %{
         128 => MMS.Q,
         129 => MMS.Charset,
      },
      error: :invalid_well_known_parameter
end
