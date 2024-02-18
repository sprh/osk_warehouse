class Request {
  final String id;
  final String description;
  final RequestStatus status;
  // final User user;

  const Request({
    required this.id,
    required this.status,
    // required this.worker,
    required this.description,
  });
}

enum RequestStatus {
  waiting,
  cancelled,
  rejected,
  accepted;
}
