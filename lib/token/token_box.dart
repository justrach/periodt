import 'package:hive/hive.dart';

part 'token_box.g.dart';

@HiveType(typeId: 0)
class TokenBox extends HiveObject {
  @HiveField(0)
  late String token;
}
