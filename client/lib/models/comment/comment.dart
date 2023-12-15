import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_media_with_chatgpt/models/file/file.dart';
import 'package:social_media_with_chatgpt/models/post/post.dart';
import 'package:social_media_with_chatgpt/shared/enum/comment_status.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    String? commentId,
    @Default([]) List<File> images,
    Post? post,
    CommentStatus? status,
    int? createAt,
    int? updateAt,
    String? content,
  }) = _Comment;
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}