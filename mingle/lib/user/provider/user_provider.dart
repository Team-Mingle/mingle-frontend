import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/user/model/user_model.dart';

final currentUserProvider = StateProvider<UserModel?>((ref) => null);
