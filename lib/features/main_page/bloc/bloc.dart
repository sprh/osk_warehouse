import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../user/current_user_holder/current_user_holder.dart';
import 'event.dart';
import 'state.dart';

abstract class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  static MainPageBloc of(BuildContext context) => BlocProvider.of(context);

  factory MainPageBloc(
    AccountScopeNavigationManager navigationManager,
    CurrentUserHolder currentUserHolder,
  ) =>
      _MainPageBloc(navigationManager, currentUserHolder);
}

class _MainPageBloc extends Bloc<MainPageEvent, MainPageState>
    implements MainPageBloc {
  final AccountScopeNavigationManager _navigationManager;
  final CurrentUserHolder _currentUserHolder;

  _MainPageBloc(
    this._navigationManager,
    this._currentUserHolder,
  ) : super(MainPageStateIdle()) {
    on<MainPageEvent>(_onEvent);
  }

  Future<void> _onEvent(
    MainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    switch (event) {
      case MainPageEventOpenWorkersList():
        _navigationManager.openWorkersList();
      case MainPageEventOpenWarehouseList():
        _navigationManager.openWarehouseList();
      case MainPageEventOpenProductsList():
        _navigationManager.openProductsList();
      case MainPageEventOpenRequestsList():
        _navigationManager.openRequestsList();
      case MainPageEventInitialize():
        await _initialize(emit);
    }
  }

  Future<void> _initialize(Emitter<MainPageState> emit) async {
    final currentUser = await _currentUserHolder.currentUser;
    final Set<MainPageBlocks> availableBlocks;

    if (currentUser.isSuperuser || currentUser.isAdmin) {
      availableBlocks = MainPageBlocks.values.toSet();
    } else if (currentUser.isReviewer) {
      availableBlocks = {
        MainPageBlocks.createRequest,
        MainPageBlocks.requests,
        MainPageBlocks.warehouses,
        MainPageBlocks.products,
        MainPageBlocks.workers,
      };
    } else {
      availableBlocks = {
        MainPageBlocks.createRequest,
        MainPageBlocks.requests,
        MainPageBlocks.products,
      };
    }

    final userName = '${currentUser.firstName} ${currentUser.lastName}';

    emit(
      MainPageStateData(
        availableBlocks: availableBlocks,
        userName: userName,
      ),
    );
  }
}
