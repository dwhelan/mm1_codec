defmodule MMS.MediaTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.Media,

      examples: [
        # Well known media
        { << s(0) >>, "*/*" },

        # Extension media
        { << 0 >>,         <<>>          },
        { << 32, 0 >>,     <<32>>        },
        { << 0x7f, 0 >>,   <<0x7f>>      },
        { "other/other\0", "other/other" },
      ],

      decode_errors: [
        { <<1>>,  :invalid_media },
        { <<31>>, :invalid_media },
        { "x",    :invalid_media }, # missing terminator
      ]
end

defmodule MMS.KnownMediaTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.KnownMedia,

      examples: [
        {<< s( 0) >>, "*/*"},
        {<< s( 1) >>, "text/*"},
        {<< s( 2) >>, "text/html"},
        {<< s( 3) >>, "text/plain"},
        {<< s( 4) >>, "text/x-hdml"},
        {<< s( 5) >>, "text/x-ttml"},
        {<< s( 6) >>, "text/x-vCalendar"},
        {<< s( 7) >>, "text/x-vCard"},
        {<< s( 8) >>, "text/vnd.wap.wml"},
        {<< s( 9) >>, "text/vnd.wap.wmlscript"},
        {<< s(10) >>, "text/vnd.wap.wta-event"},
        {<< s(11) >>, "multipart/*"},
        {<< s(12) >>, "multipart/mixed"},
        {<< s(13) >>, "multipart/form-data"},
        {<< s(14) >>, "multipart/byterantes"},
        {<< s(15) >>, "multipart/alternative"},
        {<< s(16) >>, "application/*"},
        {<< s(17) >>, "application/java-vm"},
        {<< s(18) >>, "application/x-www-form-urlencoded"},
        {<< s(19) >>, "application/x-hdmlc"},
        {<< s(20) >>, "application/vnd.wap.wmlc"},
        {<< s(21) >>, "application/vnd.wap.wmlscriptc"},
        {<< s(22) >>, "application/vnd.wap.wta-eventc"},
        {<< s(23) >>, "application/vnd.wap.uaprof"},
        {<< s(24) >>, "application/vnd.wap.wtls-ca-certificate"},
        {<< s(25) >>, "application/vnd.wap.wtls-user-certificate"},
        {<< s(26) >>, "application/x-x509-ca-cert"},
        {<< s(27) >>, "application/x-x509-user-cert"},
        {<< s(28) >>, "image/*"},
        {<< s(29) >>, "image/gif"},
        {<< s(30) >>, "image/jpeg"},
        {<< s(31) >>, "image/tiff"},
        {<< s(32) >>, "image/png"},
        {<< s(33) >>, "image/vnd.wap.wbmp"},
        {<< s(34) >>, "application/vnd.wap.multipart.*"},
        {<< s(35) >>, "application/vnd.wap.multipart.mixed"},
        {<< s(36) >>, "application/vnd.wap.multipart.form-data"},
        {<< s(37) >>, "application/vnd.wap.multipart.byteranges"},
        {<< s(38) >>, "application/vnd.wap.multipart.alternative"},
        {<< s(39) >>, "application/xml"},
        {<< s(40) >>, "text/xml"},
        {<< s(41) >>, "application/vnd.wap.wbxml"},
        {<< s(42) >>, "application/x-x968-cross-cert"},
        {<< s(43) >>, "application/x-x968-ca-cert"},
        {<< s(44) >>, "application/x-x968-user-cert"},
        {<< s(45) >>, "text/vnd.wap.si"},
        {<< s(46) >>, "application/vnd.wap.sic"},
        {<< s(47) >>, "text/vnd.wap.sl"},
        {<< s(48) >>, "application/vnd.wap.slc"},
        {<< s(49) >>, "text/vnd.wap.co"},
        {<< s(50) >>, "application/vnd.wap.coc"},
        {<< s(51) >>, "application/vnd.wap.multipart.related"},
        {<< s(52) >>, "application/vnd.wap.sia"},
        {<< s(53) >>, "text/vnd.wap.connectivity-xml"},
        {<< s(54) >>, "application/vnd.wap.connectivity-wbxml"},
        {<< s(55) >>, "application/pkcs7-mime"},
        {<< s(56) >>, "application/vnd.wap.hashed-certificate"},
        {<< s(57) >>, "application/vnd.wap.signed-certificate"},
        {<< s(58) >>, "application/vnd.wap.cert-response"},
        {<< s(59) >>, "application/xhtml+xml"},
        {<< s(60) >>, "application/wml+xml"},
        {<< s(61) >>, "text/css"},
        {<< s(62) >>, "application/vnd.wap.mms-message"},
        {<< s(63) >>, "application/vnd.wap.rollover-certificate"},
        {<< s(64) >>, "application/vnd.wap.locc+wbxml"},
        {<< s(65) >>, "application/vnd.wap.loc+xml"},
        {<< s(66) >>, "application/vnd.syncml.dm+wbxml"},
        {<< s(67) >>, "application/vnd.syncml.dm+xml"},
        {<< s(68) >>, "application/vnd.syncml.notification"},
        {<< s(69) >>, "application/vnd.wap.xhtml+xml"},
        {<< s(70) >>, "application/vnd.wv.csp.cir"},
        {<< s(71) >>, "application/vnd.oma.dd+xml"},
        {<< s(72) >>, "application/vnd.oma.drm.message"},
        {<< s(73) >>, "application/vnd.oma.drm.content"},
        {<< s(74) >>, "application/vnd.oma.drm.rights+xml"},
        {<< s(75) >>, "application/vnd.oma.drm.rights+wbxml"},
        {<< s(76) >>, "application/vnd.wv.csp+xml"},
        {<< s(77) >>, "application/vnd.wv.csp+wbxml"},
        {<< s(78) >>, "application/vnd.syncml.ds.notification"},
        {<< s(79) >>, "audio/*"},
        {<< s(80) >>, "video/*"},
        {<< s(81) >>, "application/vnd.oma.dd2+xml"},
        {<< s(82) >>, "application/mikey"},
        {<< s(83) >>, "application/vnd.oma.dcd"},
        {<< s(84) >>, "application/vnd.oma.dcdc"},
        {<< s(85) >>, "text/x-vMessage"},
        {<< s(86) >>, "application/vnd.omads-email+wbxml"},
        {<< s(87) >>, "text/x-vBookmark"},
        {<< s(88) >>, "application/vnd.syncml.dm.notification"},
      ],

      decode_errors: [
        {<< s(-1) >>, {:invalid_known_media, << s(-1) >>, {:invalid_integer, <<s(-1)>>, {:invalid_long, <<s(-1)>>, {:invalid_short_length, <<s(-1)>>, 127}}}}},
        {<< s(89) >>, {:invalid_known_media, << s(89) >>, :out_of_range}},
      ],

      encode_errors: [
        { "bad media", {:invalid_known_media, "bad media", :unknown}}
      ]
end
