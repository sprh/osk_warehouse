import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../core/navigation/manager/navigation_manager.dart';
import '../../../../utils/kotlin_utils.dart';
import '../../data/repository.dart';

part 'new_warehouse_bloc_event.dart';

abstract class NewWarehouseBloc implements Bloc<NewWarehouseBlocEvent, bool> {
  static NewWarehouseBloc of(BuildContext context) => BlocProvider.of(context);

  factory NewWarehouseBloc(
    WarehouseRepository repository,
    AccountScopeNavigationManager navigationManager,
  ) =>
      _NewWarehouseBloc(repository, navigationManager);
}

class _NewWarehouseBloc extends Bloc<NewWarehouseBlocEvent, bool>
    implements NewWarehouseBloc {
  final WarehouseRepository _repository;
  final AccountScopeNavigationManager _navigationManager;

  _NewWarehouseBloc(this._repository, this._navigationManager) : super(false) {
    on<NewWarehouseBlocEvent>(
      _onEvent,
    );
  }

  void _onEvent(NewWarehouseBlocEvent event, Emitter<bool> emit) {
    switch (event) {
      case NewWarehouseBlocCreateEvent():
        _createWarehouse(event.name, event.address, emit);
    }
  }

  Future<void> _createWarehouse(
    String name,
    String address,
    Emitter<bool> emit,
  ) async {
    emit(true);
    await _repository.createWarehouse(name, address).callTrowable(
      onError: (error) {
        emit(false);
        _navigationManager.showSomethingWentWrontDialog(
          (error as RepositoryLocalizedError).message,
        );
      },
      onSuccess: (_) {
        _navigationManager.pop();
        emit(false);
      },
    );
  }
}
