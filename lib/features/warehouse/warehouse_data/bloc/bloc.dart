import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../core/navigation/manager/navigation_manager.dart';
import '../../../../utils/kotlin_utils.dart';
import '../../data/repository.dart';
import 'state.dart';

part 'event.dart';

abstract class WarehouseDataBloc
    implements Bloc<WarehouseDataBlocEvent, WarehouseDataState> {
  static WarehouseDataBloc of(BuildContext context) => BlocProvider.of(context);

  factory WarehouseDataBloc(
    WarehouseRepository repository,
    AccountScopeNavigationManager navigationManager,
    String? warehouseId,
  ) =>
      _WarehouseDataBloc(
        repository,
        navigationManager,
        warehouseId: warehouseId,
      );
}

class _WarehouseDataBloc
    extends Bloc<WarehouseDataBlocEvent, WarehouseDataState>
    implements WarehouseDataBloc {
  final WarehouseRepository _repository;
  final AccountScopeNavigationManager _navigationManager;
  final String? warehouseId;

  _WarehouseDataBloc(
    this._repository,
    this._navigationManager, {
    required this.warehouseId,
  }) : super(WarehouseDataStateInitial()) {
    on<WarehouseDataBlocEvent>(
      _onEvent,
    );
  }

  Future<void> _onEvent(
    WarehouseDataBlocEvent event,
    Emitter<WarehouseDataState> emit,
  ) async {
    switch (event) {
      case WarehouseDataBlocCreateOrUpdateEvent():
        await _createOrUpdateWarehouse(event.name, event.address, emit);
      case WarehouseDataBlocInitializeEvent():
        await _initialize(emit);
    }
  }

  Future<void> _initialize(Emitter<WarehouseDataState> emit) async {
    final warehouseId = this.warehouseId;
    if (warehouseId == null) {
      emit(const WarehouseDataStateNewWarehouse());
    } else {
      await _repository.getWarehouse(warehouseId).callTrowable(
        onError: (error) {
          emit(_getLoadingState(loading: false));
          _navigationManager.showSomethingWentWrontDialog(
            (error as RepositoryLocalizedError).message,
            onCloseTap: _navigationManager.pop,
          );
        },
        onSuccess: (data) {
          emit(
            WarehouseDataStateUpdateWarehouse(
              name: data.name,
              address: data.address,
            ),
          );
        },
      );
    }
  }

  Future<void> _createOrUpdateWarehouse(
    String name,
    String address,
    Emitter<WarehouseDataState> emit,
  ) async {
    emit(_getLoadingState(loading: true));

    final request = warehouseId?.let(
          (id) => _repository.updateWarehouse(name, address, id),
        ) ??
        _repository.createWarehouse(name, address);

    await request.callTrowable(
      onError: (error) {
        emit(_getLoadingState(loading: false));
        _navigationManager.showSomethingWentWrontDialog(
          (error as RepositoryLocalizedError).message,
        );
      },
      onSuccess: (_) {
        _navigationManager.pop();
        emit(_getLoadingState(loading: false));
      },
    );
  }

  WarehouseDataState _getLoadingState({required bool loading}) {
    final state = this.state;

    switch (state) {
      case WarehouseDataStateInitial():
      case WarehouseDataStateNewWarehouse():
        return WarehouseDataStateNewWarehouse(loading: loading);
      case WarehouseDataStateUpdateWarehouse():
        return WarehouseDataStateUpdateWarehouse(
          name: state.name,
          address: state.address,
          loading: loading,
        );
    }
  }
}