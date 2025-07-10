import 'package:fcms_helpdesk/domain/app_user.dart';

class Reply {
  final String id;       
  final String ticketId; 
  final String content;
  final DateTime createdAt;
  final AppUser createdBy;

  const Reply({
    required this.id,
    required this.ticketId,
    required this.content,
    required this.createdAt,
    required this.createdBy,
  });
}