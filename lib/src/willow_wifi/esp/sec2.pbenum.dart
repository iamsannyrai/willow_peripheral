///
//  Generated code. Do not modify.
//  source: sec2.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Sec2MsgType extends $pb.ProtobufEnum {
  static const Sec2MsgType S2Session_Command0 = Sec2MsgType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'S2Session_Command0');
  static const Sec2MsgType S2Session_Response0 = Sec2MsgType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'S2Session_Response0');
  static const Sec2MsgType S2Session_Command1 = Sec2MsgType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'S2Session_Command1');
  static const Sec2MsgType S2Session_Response1 = Sec2MsgType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'S2Session_Response1');

  static const $core.List<Sec2MsgType> values = <Sec2MsgType> [
    S2Session_Command0,
    S2Session_Response0,
    S2Session_Command1,
    S2Session_Response1,
  ];

  static final $core.Map<$core.int, Sec2MsgType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Sec2MsgType? valueOf($core.int value) => _byValue[value];

  const Sec2MsgType._($core.int v, $core.String n) : super(v, n);
}

