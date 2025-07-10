import 'package:fcms_helpdesk/core/enums/ticket_status_enum.dart';
import 'package:fcms_helpdesk/domain/app_user.dart';

class Ticket {
  final String id;
  final String referenceId;
  final String title;
  final String description;
  final TicketStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AppUser createdBy;

  const Ticket({
    required this.id,
    required this.referenceId,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });
}