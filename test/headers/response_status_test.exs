defmodule MMS.ResponseStatusTest do
  import MMS.Test

  use MMS.TestExamples,
      codec: MMS.ResponseStatus,

      examples: [
        { << s(  0) >>, :ok                                            },
        { << s(  1) >>, :unspecified                                   },
        { << s(  2) >>, :service_denied                                },
        { << s(  3) >>, :message_format_corrupt                        },
        { << s(  4) >>, :sending_address_unresolved                    },
        { << s(  5) >>, :message_not_found                             },
        { << s(  6) >>, :network_problem                               },
        { << s(  7) >>, :content_not_accepted                          },
        { << s(  8) >>, :unsupported_message                           },
        { << s( 64) >>, :transient_failure                             },
        { << s( 65) >>, :transient_sending_address_unresolved          },
        { << s( 66) >>, :transient_message_not_found                   },
        { << s( 67) >>, :transient_network_problem                     },
        { << s( 96) >>, :permanent_failure                             },
        { << s( 97) >>, :permanent_service_denied                      },
        { << s( 98) >>, :permanent_message_format_corrupt              },
        { << s( 99) >>, :permanent_sending_address_unresolved          },
        { << s(100) >>, :permanent_message_not_found                   },
        { << s(101) >>, :permanent_content_not_accepted                },
        { << s(102) >>, :permanent_reply_charging_limitations_not_met  },
        { << s(103) >>, :permanent_reply_charging_request_not_accepted },
        { << s(104) >>, :permanent_reply_charging_forwarding_denied    },
        { << s(105) >>, :permanent_reply_charging_not_supported        },
      ],

      decode_errors: [
        { << s(-1) >>,  :invalid_response_status},
        { << s(106) >>, :invalid_response_status},
      ],

      encode_errors: [
        { :not_a_response_status, :invalid_response_status},
      ]
end
