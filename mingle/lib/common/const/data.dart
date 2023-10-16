import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';
const emulatorIp = '10.0.2.2:3000';
const simulatorIp = '127.0.0.1:3000';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;

final List<String> COUNTRY_LIST = [
  '홍콩',
  '싱가포르',
  '영국',
];

final List<String> HONG_KONG_SCHOOL_LIST = ['홍콩대학교', '과학기술대학교', '중문대학교'];

final List<String> SINGAPORE_SCHOOL_LIST = ['NUS', 'NTU', 'SMU'];

final List<String> ENGLAND_SCHOOL_LIST = ['영국명문대1', '영국명문대2', '영국명문대3'];

final List<String> HONG_KONG_EMAIL_LIST = ['홍콩이메일1', '홍콩이메일2', '홍콩이메일3'];

final List<String> SINGAPORE_EMAIL_LIST = ['싱가포르이메일1', '싱가포르이메일2', '싱가포르이메일3'];

final List<String> ENGLAND_EMAIL_LIST = ['영국이메일1', '영국이메일2', '영국이메일3'];
