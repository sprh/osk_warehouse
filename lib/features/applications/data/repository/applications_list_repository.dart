import '../../../../common/interface/repository.dart';
import '../api/api.dart';

abstract class ApplicationsListRepository extends Repository<void> {
  factory ApplicationsListRepository(ApplicationsApi api) =>
      _ApplicationsListRepository(api);

  Future<void> loadApplications();
}

class _ApplicationsListRepository extends Repository<void>
    implements ApplicationsListRepository {
  final ApplicationsApi _api;

  _ApplicationsListRepository(this._api);

  @override
  Future<void> loadApplications() async {
    try {
      final applications = await _api.getApplications();
      print(applications);
    } on Exception catch (e) {
      print(e);
    }
  }
}
