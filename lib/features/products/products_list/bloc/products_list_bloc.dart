import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../navigation/logic/navigation_manager.dart';

abstract class ProductsListBloc extends Bloc<dynamic, dynamic> {
  factory ProductsListBloc(
    NavigationManager navigationManager,
    String? warehouseId,
  ) =>
      _ProductsListBloc(
        navigationManager,
        warehouseId,
      );
}

class _ProductsListBloc extends Bloc<dynamic, dynamic>
    implements ProductsListBloc {
  final NavigationManager _navigationManager;
  final String? warehouseId;

  _ProductsListBloc(this._navigationManager, this.warehouseId) : super(null);
}
