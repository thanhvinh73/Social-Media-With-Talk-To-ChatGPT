import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_media_with_chatgpt/models/file/file.dart';
import 'package:social_media_with_chatgpt/models/user/user.dart';
import 'package:social_media_with_chatgpt/shared/enum/post_status.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    String? postId,
    User? authorUser,
    @Default([]) List<User> sharedUser,
    @Default([]) List<File> images,
    PostStatus? status,
    String? title,
    String? description,
    int? createAt,
    bool? updated,
  }) = _Post;
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}