import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mingle/common/const/data.dart';
import 'package:mingle/dio/dio.dart';
import 'package:mingle/user/view/signup_screen/model/country_model.dart';
import 'package:mingle/user/view/signup_screen/model/university_domain_model.dart';
import 'package:retrofit/http.dart';

part 'auth_repository.g.dart';

final authRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final memberRepository =
      AuthRepository(dio, baseUrl: "https://$baseUrl/auth");
  return memberRepository;
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = _AuthRepository;

  @POST('/countries')
  Future<List<CountryModel>> getCountries();

  @POST('email-domains/{countryName}')
  Future<List<UniversityDomainModel>> getEmailDomains(
      {@Path() required String countryName});

  // @POST('/logout')
  // @Headers({'accessToken': 'true'})
  // Future<void> logout();

  // @PATCH('/nickname')
  // @Headers({'accessToken': 'true'})
  // Future<void> changeNickname({@Body() required ChangeNicknameDto newNickname});
}
