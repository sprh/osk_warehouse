sealed class RequestsListEvent {}

class RequestsListEventOpenRequestInfo extends RequestsListEvent {
  final String requestId;

  RequestsListEventOpenRequestInfo(this.requestId);
}
