import '../application/application.dart';

class ApplicationListRepositoryState {
  final List<Application> applications;
  final bool hasMore;

  const ApplicationListRepositoryState({
    this.applications = const [],
    this.hasMore = true,
  });
}
