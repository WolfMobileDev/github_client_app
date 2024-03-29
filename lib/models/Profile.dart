import 'package:json_annotation/json_annotation.dart';
import "User.dart";
import "CacheConfig.dart";
part 'Profile.g.dart';

@JsonSerializable()
class Profile {
    Profile();

    User user;
    String token;
    num theme;
    CacheConfig cache;
    String lastLogin;
    String locale;
    
    factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
