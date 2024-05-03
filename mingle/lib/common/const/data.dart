import 'dart:io';
import 'dart:isolate';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FCM_TOKEN_KEY = 'FCM_TOKEN_KEY';
const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';
const ENCRYPTED_EMAIL_KEY = 'ENCRYPTED_EMAIL';
const CURRENT_USER_KEY = 'CURRENT_USER';
const IS_FRESH_LOGIN_KEY = 'IS_FRESH_LOGIN';
const IS_FRESH_ONBOARDING_KEY = "IS_FRESH_ONBOARDING_KEY";

const TIMETABLE_GRID_HEIGHT = 434 / 13;
const TIMETABLE_GRID_WIDTH = 48.0;
const TIMETABLE_TOTAL_HEIGHT = 436.0;

const HISTORY_KEY = "_histories";

// const baseUrl = "api.prod.mingle.community";
const baseUrl = "api.develop.mingle.community";
//  "dev.api.mingle.community";

const generalErrorMsg = "다시 시도해 주세요.";

// final List<String> COUNTRY_LIST = [
//   '홍콩',
//   '싱가포르',
// ];

// final List<String> HONG_KONG_SCHOOL_LIST = ['홍콩대학교', '과학기술대학교'];

// final List<String> SINGAPORE_SCHOOL_LIST = ['NUS', 'NTU'];

// // final List<String> ENGLAND_SCHOOL_LIST = ['영국명문대1', '영국명문대2', '영국명문대3'];

// final List<String> HONG_KONG_EMAIL_LIST = [
//   'connect.hku.hk',
//   'connect.ust.hk',
//   'gmail.com'
// ];

// final List<String> SINGAPORE_EMAIL_LIST = [
//   'u.nus.edu',
//   'e.ntu.edu.sg',
//   'gmail.com'
// ];

// final List<String> ENGLAND_EMAIL_LIST = ['영국이메일1', '영국이메일2', '영국이메일3'];
