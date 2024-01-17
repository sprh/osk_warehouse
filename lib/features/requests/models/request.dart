import '../../worker/models/worker.dart';

class Request {
  final String id;
  final String date;
  final RequestStatus status;
  final Worker worker;

  const Request({
    required this.id,
    required this.date,
    required this.status,
    required this.worker,
  });
}

enum RequestStatus {
  waiting,
  cancelled,
  accepted;
}
