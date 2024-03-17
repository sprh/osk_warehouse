import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/actions/actions_flex.dart';
import '../../../../common/components/button/osk_button.dart';
import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../../../utils/kotlin_utils.dart';
import '../../../user/current_user_holder/current_user_holder.dart';
import '../../data/repository.dart';
import '../../models/warehouse.dart';
import 'warehouse_list_state.dart';

part 'warehouse_list_event.dart';

class WarehouseListBloc extends Bloc<WarehouseListEvent, WarehouseListState> {
  static WarehouseListBloc of(BuildContext context) => BlocProvider.of(context);

  factory WarehouseListBloc(
    AccountScopeNavigationManager navigationManager,
    WarehouseRepository repository,
    CurrentUserHolder currentUserHolder,
  ) =>
      _WarehouseListBloc(navigationManager, repository, currentUserHolder);
}

class _WarehouseListBloc extends Bloc<WarehouseListEvent, WarehouseListState>
    with RepositorySubscriber<List<Warehouse>>
    implements WarehouseListBloc {
  final AccountScopeNavigationManager _navigationManager;
  final WarehouseRepository _repository;
  final CurrentUserHolder _currentUserHolder;

  @override
  Repository<List<Warehouse>> get repository => _repository;

  _WarehouseListBloc(
    this._navigationManager,
    this._repository,
    this._currentUserHolder,
  ) : super(WarehouseListIdleState()) {
    on<WarehouseListEvent>(_onEvent);
  }

  Future<void> _onEvent(
    WarehouseListEvent event,
    Emitter<WarehouseListState> emit,
  ) async {
    switch (event) {
      case WarehouseListEventOnCreateWarehouseTap():
        _navigationManager.openWarehouseData();
      case WarehouseListEventOpenProductsList():
        _navigationManager.openProductsList(event.warehouseId);
      case WarehouseListEventInitialize():
        _repository.start();
        start();
        await _repository.refreshWarehouseList();
      case _WarehouseListUpdateStateEvent():
        final currentUser = await _currentUserHolder.currentUser;
        emit(
          WarehouseListDataState(
            items: event.warehouses,
            canEditData: currentUser.canManagerWarehouse,
          ),
        );
      case _WarehouseListUpdateLoadingStateEvent():
        if (state is WarehouseListDataState) {
          emit(
            (state as WarehouseListDataState).copyWith(loading: event.loading),
          );
        }
      case WarehouseListEventEditWarehouse():
        _navigationManager.openWarehouseData(event.id);
      case WarehouseListEventDeleteWarehouse():
        await _navigationManager.showModalDialog(
          title: 'Вы уверены, что хотите удалить склад?',
          actions: OskActionsFlex(
            direction: Axis.vertical,
            widgets: [
              OskButton.main(
                title: 'Удалить',
                onTap: () {
                  _onDeleteWarehouse(event.id, emit);
                  _navigationManager.popDialog();
                },
              ),
              OskButton.minor(
                title: 'Отмена',
                onTap: _navigationManager.popDialog,
              ),
            ],
          ),
        );
    }
  }

  @override
  void onData(List<Warehouse> value) => add(
        _WarehouseListUpdateStateEvent(value),
      );

  @override
  void onLoading(bool loading) => add(
        _WarehouseListUpdateLoadingStateEvent(loading),
      );

  @override
  void onRepositoryError(RepositoryLocalizedError error) =>
      _navigationManager.showSomethingWentWrontDialog(error.message);

  void _onDeleteWarehouse(String id, Emitter<WarehouseListState> emit) {
    onLoading(true);
    _repository.deleteWarehouse(id).callTrowable(
      onError: (error) {
        onLoading(false);
        _navigationManager.showSomethingWentWrontDialog(
          (error as RepositoryLocalizedError).message,
          onCloseTap: _navigationManager.pop,
        );
      },
    );
  }

  @override
  Future<void> close() {
    super.stop();
    return super.close();
  }
}
