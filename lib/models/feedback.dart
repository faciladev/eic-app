class FeedbackModel {
  final String sender;
  final String subject;
  final String message;

  FeedbackModel({
    this.sender,
    this.subject,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {'sender': sender, 'subject': subject, 'message': message};
  }
}
