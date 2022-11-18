import 'package:keyboard/core/abstracts/dto.dart';

typedef UserPostResult = Map<String, dynamic>;

class UserPostDto extends DTO<UserPostResult> {

  UserPostDto(super.status, super.message, {super.data});

}
