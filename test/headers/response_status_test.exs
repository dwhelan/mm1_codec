defmodule MMS.ResponseStatusTest do
  import MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.ResponseStatus,

      examples: [
        {<<128>>, :ok},

        # Obsolete failures
        {<<129>>, {:permanent_failure, :obsolete_unspecified}},
        {<<130>>, {:permanent_failure, :obsolete_service_denied}},
        {<<131>>, {:permanent_failure, :obsolete_message_format_corrupt}},
        {<<132>>, {:permanent_failure, :obsolete_sending_address_unresolved}},
        {<<133>>, {:transient_failure, :obsolete_message_not_found}},
        {<<134>>, {:transient_failure, :obsolete_network_problem}},
        {<<135>>, {:permanent_failure, :obsolete_content_not_accepted}},

        {<<136>>, {:permanent_failure, :unsupported_message}},

        # Transient failures
        {<<192>>, {:transient_failure, :unspecified}},
        {<<193>>, {:transient_failure, :sending_address_unresolved}},
        {<<194>>, {:transient_failure, :message_not_found}},
        {<<195>>, {:transient_failure, :network_problem}},
        {<<196>>, {:transient_failure, 196}},
        {<<197>>, {:transient_failure, 197}},
        {<<198>>, {:transient_failure, 198}},
        {<<199>>, {:transient_failure, 199}},
        {<<200>>, {:transient_failure, 200}},
        {<<201>>, {:transient_failure, 201}},
        {<<202>>, {:transient_failure, 202}},
        {<<203>>, {:transient_failure, 203}},
        {<<204>>, {:transient_failure, 204}},
        {<<205>>, {:transient_failure, 205}},
        {<<206>>, {:transient_failure, 206}},
        {<<207>>, {:transient_failure, 207}},
        {<<208>>, {:transient_failure, 208}},
        {<<209>>, {:transient_failure, 209}},
        {<<210>>, {:transient_failure, 210}},
        {<<211>>, {:transient_failure, 211}},
        {<<212>>, {:transient_failure, 212}},
        {<<213>>, {:transient_failure, 213}},
        {<<214>>, {:transient_failure, 214}},
        {<<215>>, {:transient_failure, 215}},
        {<<216>>, {:transient_failure, 216}},
        {<<217>>, {:transient_failure, 217}},
        {<<218>>, {:transient_failure, 218}},
        {<<219>>, {:transient_failure, 219}},
        {<<220>>, {:transient_failure, 220}},
        {<<221>>, {:transient_failure, 221}},
        {<<222>>, {:transient_failure, 222}},
        {<<223>>, {:transient_failure, 223}},

        # Permanent failures
        {<<224>>, {:permanent_failure, :unspecified}},
        {<<225>>, {:permanent_failure, :service_denied}},
        {<<226>>, {:permanent_failure, :message_format_corrupt}},
        {<<227>>, {:permanent_failure, :sending_address_unresolved}},
        {<<228>>, {:permanent_failure, :message_not_found}},
        {<<229>>, {:permanent_failure, :content_not_accepted}},
        {<<230>>, {:permanent_failure, :reply_charging_limitations_not_met}},
        {<<231>>, {:permanent_failure, :reply_charging_request_not_accepted}},
        {<<232>>, {:permanent_failure, :reply_charging_forwarding_denied}},
        {<<233>>, {:permanent_failure, :reply_charging_not_supported}},
        {<<234>>, {:permanent_failure, 234}},
        {<<235>>, {:permanent_failure, 235}},
        {<<236>>, {:permanent_failure, 236}},
        {<<237>>, {:permanent_failure, 237}},
        {<<238>>, {:permanent_failure, 238}},
        {<<239>>, {:permanent_failure, 239}},
        {<<240>>, {:permanent_failure, 240}},
        {<<241>>, {:permanent_failure, 241}},
        {<<242>>, {:permanent_failure, 242}},
        {<<243>>, {:permanent_failure, 243}},
        {<<244>>, {:permanent_failure, 244}},
        {<<245>>, {:permanent_failure, 245}},
        {<<246>>, {:permanent_failure, 246}},
        {<<247>>, {:permanent_failure, 247}},
        {<<248>>, {:permanent_failure, 248}},
        {<<249>>, {:permanent_failure, 249}},
        {<<250>>, {:permanent_failure, 250}},
        {<<251>>, {:permanent_failure, 251}},
        {<<252>>, {:permanent_failure, 252}},
        {<<253>>, {:permanent_failure, 253}},
        {<<254>>, {:permanent_failure, 254}},
        {<<255>>, {:permanent_failure, 255}},
      ],

      decode_errors: [
        {<<127>>, {:response_status, <<127>>, %{out_of_range: 127}}},
        {<<137>>, {:response_status, <<137>>, %{out_of_range: 137}}},
      ],

      encode_errors: [
        {:not_a_response_status, {:response_status, :not_a_response_status, :out_of_range}},
      ]
end
