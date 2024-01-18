import '../../worker/models/worker.dart';

class Request {
  final String id;
  final String description;
  final RequestStatus status;
  final Worker worker;

  const Request({
    required this.id,
    required this.status,
    required this.worker,
    required this.description,
  });
}

enum RequestStatus {
  waiting,
  cancelled,
  rejected,
  accepted;
}
