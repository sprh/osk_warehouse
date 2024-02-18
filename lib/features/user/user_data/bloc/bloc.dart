import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/navigation_manager.dart';
import '../../../warehouse/models/warehouse.dart';
import '../../data/user_repository.dart';
import '../../models/user.dart';
import 'state.dart';

part 'events.dart';

abstract class UserDataBloc extends Bloc<UserDataPageEvent, UserDataState> {
  static UserDataBloc of(BuildContext context) => BlocProvider.of(context);

  factory UserDataBloc(
    AccountScopeNavigationManager navigationManager,
    UserRepository repository,
    String? userId,
  ) =>
      _UserDataBloc(
        navigationManager,
        repository,
        userId: userId,
      );
}

class _UserDataBloc extends Bloc<UserDataPageEvent, UserDataState>
    with RepositorySubscriber<(User?, List<Warehouse>)>
    implements UserDataBloc {
  final AccountScopeNavigationManager _navigationManager;
  final UserRepository _repository;
  final String? userId;

  _UserDataBloc(
    this._navigationManager,
    this._repository, {
    required this.userId,
  }) : super(UserDataStateInitial()) {
    on<UserDataPageEvent>(_onEvent);
  }

  @override
  Repository<(User?, List<Warehouse>)> get repository => _repository;

  Future<void> _onEvent(
    UserDataPageEvent event,
    Emitter<UserDataState> emit,
  ) async {
    switch (event) {
      case UserDataPageEventInitialize():
        _repository.start();
        start();
        await _repository.refreshData(userId);
      case _UserDataPageEventSetLoading():
        _maybeSetLoading(event.loading, emit);
      case _UserDataPageEventSetData():
        _setData(event.user, event.warehouses, emit);
    }
  }

  @override
  void onData((User?, List<Warehouse>) value) => add(
        _UserDataPageEventSetData(user: value.$1, warehouses: value.$2),
      );

  @override
  void onLoading(bool loading) => add(_UserDataPageEventSetLoading(loading));

  @override
  void onRepositoryError(RepositoryLocalizedError error) =>
      _navigationManager.showSomethingWentWrontDialog(error.message);

  void _maybeSetLoading(bool loading, Emitter<UserDataState> emit) {
    final state = this.state;
    switch (state) {
      case UserDataStateInitial():
        break;
      case UserDataStateUpdate():
        emit(
          UserDataStateUpdate(
            user: state.user,
            availableWarehouses: state.availableWarehouses,
            loading: loading,
          ),
        );
      case UserDataStateCreate():
        emit(
          UserDataStateCreate(
            availableWarehouses: state.availableWarehouses,
            loading: loading,
          ),
        );
    }
  }

  void _setData(
    User? user,
    List<Warehouse> warehouses,
    Emitter<UserDataState> emit,
  ) {
    if (user != null) {
      emit(UserDataStateUpdate(user: user, availableWarehouses: warehouses));
    } else {
      emit(UserDataStateCreate(availableWarehouses: warehouses));
    }
  }

  @override
  Future<void> close() {
    super.stop();
    return super.close();
  }
}
