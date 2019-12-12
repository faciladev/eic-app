class FeedbackModel {
  final String from;
  final String subject;
  final String message;

  FeedbackModel({
    this.from,
    this.subject,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {'from': from, 'subject': subject, 'message': message};
  }
}
