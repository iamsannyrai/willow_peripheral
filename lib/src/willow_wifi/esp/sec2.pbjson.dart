///
//  Generated code. Do not modify.
//  source: sec2.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use sec2MsgTypeDescriptor instead')
const Sec2MsgType$json = const {
  '1': 'Sec2MsgType',
  '2': const [
    const {'1': 'S2Session_Command0', '2': 0},
    const {'1': 'S2Session_Response0', '2': 1},
    const {'1': 'S2Session_Command1', '2': 2},
    const {'1': 'S2Session_Response1', '2': 3},
  ],
};

/// Descriptor for `Sec2MsgType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List sec2MsgTypeDescriptor = $convert.base64Decode('CgtTZWMyTXNnVHlwZRIWChJTMlNlc3Npb25fQ29tbWFuZDAQABIXChNTMlNlc3Npb25fUmVzcG9uc2UwEAESFgoSUzJTZXNzaW9uX0NvbW1hbmQxEAISFwoTUzJTZXNzaW9uX1Jlc3BvbnNlMRAD');
@$core.Deprecated('Use s2SessionCmd0Descriptor instead')
const S2SessionCmd0$json = const {
  '1': 'S2SessionCmd0',
  '2': const [
    const {'1': 'client_username', '3': 1, '4': 1, '5': 12, '10': 'clientUsername'},
    const {'1': 'client_pubkey', '3': 2, '4': 1, '5': 12, '10': 'clientPubkey'},
  ],
};

/// Descriptor for `S2SessionCmd0`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List s2SessionCmd0Descriptor = $convert.base64Decode('Cg1TMlNlc3Npb25DbWQwEicKD2NsaWVudF91c2VybmFtZRgBIAEoDFIOY2xpZW50VXNlcm5hbWUSIwoNY2xpZW50X3B1YmtleRgCIAEoDFIMY2xpZW50UHVia2V5');
@$core.Deprecated('Use s2SessionResp0Descriptor instead')
const S2SessionResp0$json = const {
  '1': 'S2SessionResp0',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.Status', '10': 'status'},
    const {'1': 'device_pubkey', '3': 2, '4': 1, '5': 12, '10': 'devicePubkey'},
    const {'1': 'device_salt', '3': 3, '4': 1, '5': 12, '10': 'deviceSalt'},
  ],
};

/// Descriptor for `S2SessionResp0`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List s2SessionResp0Descriptor = $convert.base64Decode('Cg5TMlNlc3Npb25SZXNwMBIfCgZzdGF0dXMYASABKA4yBy5TdGF0dXNSBnN0YXR1cxIjCg1kZXZpY2VfcHVia2V5GAIgASgMUgxkZXZpY2VQdWJrZXkSHwoLZGV2aWNlX3NhbHQYAyABKAxSCmRldmljZVNhbHQ=');
@$core.Deprecated('Use s2SessionCmd1Descriptor instead')
const S2SessionCmd1$json = const {
  '1': 'S2SessionCmd1',
  '2': const [
    const {'1': 'client_proof', '3': 1, '4': 1, '5': 12, '10': 'clientProof'},
  ],
};

/// Descriptor for `S2SessionCmd1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List s2SessionCmd1Descriptor = $convert.base64Decode('Cg1TMlNlc3Npb25DbWQxEiEKDGNsaWVudF9wcm9vZhgBIAEoDFILY2xpZW50UHJvb2Y=');
@$core.Deprecated('Use s2SessionResp1Descriptor instead')
const S2SessionResp1$json = const {
  '1': 'S2SessionResp1',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.Status', '10': 'status'},
    const {'1': 'device_proof', '3': 2, '4': 1, '5': 12, '10': 'deviceProof'},
    const {'1': 'device_nonce', '3': 3, '4': 1, '5': 12, '10': 'deviceNonce'},
  ],
};

/// Descriptor for `S2SessionResp1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List s2SessionResp1Descriptor = $convert.base64Decode('Cg5TMlNlc3Npb25SZXNwMRIfCgZzdGF0dXMYASABKA4yBy5TdGF0dXNSBnN0YXR1cxIhCgxkZXZpY2VfcHJvb2YYAiABKAxSC2RldmljZVByb29mEiEKDGRldmljZV9ub25jZRgDIAEoDFILZGV2aWNlTm9uY2U=');
@$core.Deprecated('Use sec2PayloadDescriptor instead')
const Sec2Payload$json = const {
  '1': 'Sec2Payload',
  '2': const [
    const {'1': 'msg', '3': 1, '4': 1, '5': 14, '6': '.Sec2MsgType', '10': 'msg'},
    const {'1': 'sc0', '3': 20, '4': 1, '5': 11, '6': '.S2SessionCmd0', '9': 0, '10': 'sc0'},
    const {'1': 'sr0', '3': 21, '4': 1, '5': 11, '6': '.S2SessionResp0', '9': 0, '10': 'sr0'},
    const {'1': 'sc1', '3': 22, '4': 1, '5': 11, '6': '.S2SessionCmd1', '9': 0, '10': 'sc1'},
    const {'1': 'sr1', '3': 23, '4': 1, '5': 11, '6': '.S2SessionResp1', '9': 0, '10': 'sr1'},
  ],
  '8': const [
    const {'1': 'payload'},
  ],
};

/// Descriptor for `Sec2Payload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sec2PayloadDescriptor = $convert.base64Decode('CgtTZWMyUGF5bG9hZBIeCgNtc2cYASABKA4yDC5TZWMyTXNnVHlwZVIDbXNnEiIKA3NjMBgUIAEoCzIOLlMyU2Vzc2lvbkNtZDBIAFIDc2MwEiMKA3NyMBgVIAEoCzIPLlMyU2Vzc2lvblJlc3AwSABSA3NyMBIiCgNzYzEYFiABKAsyDi5TMlNlc3Npb25DbWQxSABSA3NjMRIjCgNzcjEYFyABKAsyDy5TMlNlc3Npb25SZXNwMUgAUgNzcjFCCQoHcGF5bG9hZA==');
