defmodule MMS.WellKnownMediaTest do
  use MMS.CodecTest

  import MMS.WellKnownMedia

  codec_examples [
    {"*/*",                                       << s( 0) >>, :"*/*"},
    {"text/*",                                    << s( 1) >>, :"text/*"},
    {"text/html",                                 << s( 2) >>, :"text/html"},
    {"text/plain",                                << s( 3) >>, :"text/plain"},
    {"text/x-hdml",                               << s( 4) >>, :"text/x-hdml"},
    {"text/x-ttml",                               << s( 5) >>, :"text/x-ttml"},
    {"text/x-vCalendar",                          << s( 6) >>, :"text/x-vCalendar"},
    {"text/x-vCard",                              << s( 7) >>, :"text/x-vCard"},
    {"text/vnd.wap.wml",                          << s( 8) >>, :"text/vnd.wap.wml"},
    {"text/vnd.wap.wmlscript",                    << s( 9) >>, :"text/vnd.wap.wmlscript"},
    {"text/vnd.wap.wta-event",                    << s(10) >>, :"text/vnd.wap.wta-event"},
    {"multipart/*",                               << s(11) >>, :"multipart/*"},
    {"multipart/mixed",                           << s(12) >>, :"multipart/mixed"},
    {"multipart/form-data",                       << s(13) >>, :"multipart/form-data"},
    {"multipart/byterantes",                      << s(14) >>, :"multipart/byterantes"},
    {"multipart/alternative",                     << s(15) >>, :"multipart/alternative"},
    {"application/*",                             << s(16) >>, :"application/*"},
    {"application/java-vm",                       << s(17) >>, :"application/java-vm"},
    {"application/x-www-form-urlencoded",         << s(18) >>, :"application/x-www-form-urlencoded"},
    {"application/x-hdmlc",                       << s(19) >>, :"application/x-hdmlc"},
    {"application/vnd.wap.wmlc",                  << s(20) >>, :"application/vnd.wap.wmlc"},
    {"application/vnd.wap.wmlscriptc",            << s(21) >>, :"application/vnd.wap.wmlscriptc"},
    {"application/vnd.wap.wta-eventc",            << s(22) >>, :"application/vnd.wap.wta-eventc"},
    {"application/vnd.wap.uaprof",                << s(23) >>, :"application/vnd.wap.uaprof"},
    {"application/vnd.wap.wtls-ca-certificate",   << s(24) >>, :"application/vnd.wap.wtls-ca-certificate"},
    {"application/vnd.wap.wtls-user-certificate", << s(25) >>, :"application/vnd.wap.wtls-user-certificate"},
    {"application/x-x509-ca-cert",                << s(26) >>, :"application/x-x509-ca-cert"},
    {"application/x-x509-user-cert",              << s(27) >>, :"application/x-x509-user-cert"},
    {"image/*",                                   << s(28) >>, :"image/*"},
    {"image/gif",                                 << s(29) >>, :"image/gif"},
    {"image/jpeg",                                << s(30) >>, :"image/jpeg"},
    {"image/tiff",                                << s(31) >>, :"image/tiff"},
    {"image/png",                                 << s(32) >>, :"image/png"},
    {"image/vnd.wap.wbmp",                        << s(33) >>, :"image/vnd.wap.wbmp"},
    {"application/vnd.wap.multipart.*",           << s(34) >>, :"application/vnd.wap.multipart.*"},
    {"application/vnd.wap.multipart.mixed",       << s(35) >>, :"application/vnd.wap.multipart.mixed"},
    {"application/vnd.wap.multipart.form-data",   << s(36) >>, :"application/vnd.wap.multipart.form-data"},
    {"application/vnd.wap.multipart.byteranges",  << s(37) >>, :"application/vnd.wap.multipart.byteranges"},
    {"application/vnd.wap.multipart.alternative", << s(38) >>, :"application/vnd.wap.multipart.alternative"},
    {"application/xml",                           << s(39) >>, :"application/xml"},
    {"text/xml",                                  << s(40) >>, :"text/xml"},
    {"application/x-x968-cross-cert",             << s(42) >>, :"application/x-x968-cross-cert"},
    {"application/vnd.wap.wbxml",                 << s(41) >>, :"application/vnd.wap.wbxml"},
    {"application/x-x968-ca-cert",                << s(43) >>, :"application/x-x968-ca-cert"},
    {"application/x-x968-user-cert",              << s(44) >>, :"application/x-x968-user-cert"},
    {"text/vnd.wap.si",                           << s(45) >>, :"text/vnd.wap.si"},
    {"application/vnd.wap.sic",                   << s(46) >>, :"application/vnd.wap.sic"},
    {"text/vnd.wap.sl",                           << s(47) >>, :"text/vnd.wap.sl"},
    {"application/vnd.wap.slc",                   << s(48) >>, :"application/vnd.wap.slc"},
    {"text/vnd.wap.co",                           << s(49) >>, :"text/vnd.wap.co"},
    {"application/vnd.wap.coc",                   << s(50) >>, :"application/vnd.wap.coc"},
    {"application/vnd.wap.multipart.related",     << s(51) >>, :"application/vnd.wap.multipart.related"},
    {"application/vnd.wap.sia",                   << s(52) >>, :"application/vnd.wap.sia"},
    {"text/vnd.wap.connectivity-xml",             << s(53) >>, :"text/vnd.wap.connectivity-xml"},
    {"application/vnd.wap.connectivity-wbxml",    << s(54) >>, :"application/vnd.wap.connectivity-wbxml"},
    {"application/pkcs7-mime",                    << s(55) >>, :"application/pkcs7-mime"},
    {"application/vnd.wap.hashed-certificate",    << s(56) >>, :"application/vnd.wap.hashed-certificate"},
    {"application/vnd.wap.signed-certificate",    << s(57) >>, :"application/vnd.wap.signed-certificate"},
    {"application/vnd.wap.cert-response",         << s(58) >>, :"application/vnd.wap.cert-response"},
    {"application/xhtml+xml",                     << s(59) >>, :"application/xhtml+xml"},
    {"application/wml+xml",                       << s(60) >>, :"application/wml+xml"},
    {"text/css",                                  << s(61) >>, :"text/css"},
    {"application/vnd.wap.mms-message",           << s(62) >>, :"application/vnd.wap.mms-message"},
    {"application/vnd.wap.rollover-certificate",  << s(63) >>, :"application/vnd.wap.rollover-certificate"},
    {"application/vnd.wap.locc+wbxml",            << s(64) >>, :"application/vnd.wap.locc+wbxml"},
    {"application/vnd.wap.loc+xml",               << s(65) >>, :"application/vnd.wap.loc+xml"},
    {"application/vnd.syncml.dm+wbxml",           << s(66) >>, :"application/vnd.syncml.dm+wbxml"},
    {"application/vnd.syncml.dm+xml",             << s(67) >>, :"application/vnd.syncml.dm+xml"},
    {"application/vnd.syncml.notification",       << s(68) >>, :"application/vnd.syncml.notification"},
    {"application/vnd.wap.xhtml+xml",             << s(69) >>, :"application/vnd.wap.xhtml+xml"},
    {"application/vnd.wv.csp.cir",                << s(70) >>, :"application/vnd.wv.csp.cir"},
    {"application/vnd.oma.dd+xml",                << s(71) >>, :"application/vnd.oma.dd+xml"},
    {"application/vnd.oma.drm.message",           << s(72) >>, :"application/vnd.oma.drm.message"},
    {"application/vnd.oma.drm.content",           << s(73) >>, :"application/vnd.oma.drm.content"},
    {"application/vnd.oma.drm.rights+xml",        << s(74) >>, :"application/vnd.oma.drm.rights+xml"},
    {"application/vnd.oma.drm.rights+wbxml",      << s(75) >>, :"application/vnd.oma.drm.rights+wbxml"},
    {"application/vnd.wv.csp+xml",                << s(76) >>, :"application/vnd.wv.csp+xml"},
    {"application/vnd.wv.csp+wbxml",              << s(77) >>, :"application/vnd.wv.csp+wbxml"},
    {"application/vnd.syncml.ds.notification",    << s(78) >>, :"application/vnd.syncml.ds.notification"},
    {"audio/*",                                   << s(79) >>, :"audio/*"},
    {"video/*",                                   << s(80) >>, :"video/*"},
    {"application/vnd.oma.dd2+xml",               << s(81) >>, :"application/vnd.oma.dd2+xml"},
    {"application/mikey",                         << s(82) >>, :"application/mikey"},
    {"application/vnd.oma.dcd",                   << s(83) >>, :"application/vnd.oma.dcd"},
    {"application/vnd.oma.dcdc",                  << s(84) >>, :"application/vnd.oma.dcdc"},
    {"text/x-vMessage",                           << s(85) >>, :"text/x-vMessage"},
    {"application/vnd.omads-email+wbxml",         << s(86) >>, :"application/vnd.omads-email+wbxml"},
    {"text/x-vBookmark",                          << s(87) >>, :"text/x-vBookmark"},
    {"application/vnd.syncml.dm.notification",    << s(88) >>, :"application/vnd.syncml.dm.notification"},
  ]

  decode_errors [
    {"too small", << s(-1) >>},
    {"too large", << s(89) >>},
  ]

  encode_errors [
    {"invalid extension media", "x\0"},
  ]
end
