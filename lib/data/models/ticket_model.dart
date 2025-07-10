import 'package:fcms_helpdesk/core/enums/ticket_status_enum.dart';
import 'package:fcms_helpdesk/data/models/app_user_model.dart';
import 'package:fcms_helpdesk/domain/ticket.dart';

class TicketModel {
  final String id;
  final String referenceId;
  final String title;
  final String description;
  final String status;
  final String createdAt;
  final String updatedAt;
  final AppUserModel createdBy;

  const TicketModel({
    required this.id,
    required this.referenceId,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {

    if (json['id'] == null) {
      throw const FormatException(
        'Missing required field: "id" in TicketModel JSON.',
      );
    }
    if (json['reference_id'] == null) {
      throw const FormatException(
        'Missing required field: "reference_id" in TicketModel JSON.',
      );
    }
    if (json['title'] == null) {
      throw const FormatException(
        'Missing required field: "title" in TicketModel JSON.',
      );
    }
    if (json['description'] == null) {
      throw const FormatException(
        'Missing required field: "description" in TicketModel JSON.',
      );
    }
    if (json['status'] == null) {
      throw const FormatException(
        'Missing required field: "status" in TicketModel JSON.',
      );
    }
    if (json['created_at'] == null) {
      throw const FormatException(
        'Missing required field: "created_at" in TicketModel JSON.',
      );
    }
    if (json['updated_at'] == null) {
      throw const FormatException(
        'Missing required field: "updated_at" in TicketModel JSON.',
      );
    }
    if (json['app_users'] == null) {
      throw const FormatException(
        'Missing required nested object: "app_users" in TicketModel JSON.',
      );
    }

    return TicketModel(
      id: json['id'] as String,
      referenceId: json['reference_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      createdBy: AppUserModel.fromJson(json['app_users']),
    );
  }

  Ticket toEntity() {
    return Ticket(
      id: id,
      referenceId: referenceId,
      title: title,
      description: description,
      status: status == 'Open' ? TicketStatus.Open : TicketStatus.Closed,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      createdBy: createdBy.toEntity(),
    );
  }
}
