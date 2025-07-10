import 'package:fcms_helpdesk/data/models/app_user_model.dart';
import 'package:fcms_helpdesk/domain/reply.dart';

class ReplyModel {
  final String id;
  final String ticketId;
  final String content;
  final String createdAt;
  final AppUserModel createdBy;

  const ReplyModel({
    required this.id,
    required this.ticketId,
    required this.content,
    required this.createdAt,
    required this.createdBy,
  });

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw const FormatException(
        'Missing required field: "id" in ReplyModel JSON.',
      );
    }
    if (json['ticket_id'] == null) {
      throw const FormatException(
        'Missing required field: "ticket_id" in ReplyModel JSON.',
      );
    }
    if (json['content'] == null) {
      throw const FormatException(
        'Missing required field: "content" in ReplyModel JSON.',
      );
    }
    if (json['created_at'] == null) {
      throw const FormatException(
        'Missing required field: "created_at" in ReplyModel JSON.',
      );
    }
    if (json['app_users'] == null) {
      throw const FormatException(
        'Missing required nested object: "app_users" in ReplyModel JSON.',
      );
    }

    return ReplyModel(
      id: json['id'] as String,
      ticketId: json['ticket_id'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] as String,
      createdBy: AppUserModel.fromJson(json['app_users']),
    );
  }

  Reply toEntity() {
    return Reply(
      id: id,
      ticketId: ticketId,
      content: content,
      createdAt: DateTime.parse(createdAt),
      createdBy: createdBy.toEntity(),
    );
  }
}
