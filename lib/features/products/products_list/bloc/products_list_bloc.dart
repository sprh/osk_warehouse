import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../navigation/logic/navigation_manager.dart';

abstract class ProductsListBloc extends Bloc<dynamic, dynamic> {
  factory ProductsListBloc(NavigationManager navigationManager) =>
      _ProductsListBloc(navigationManager);
}

class _ProductsListBloc extends Bloc<dynamic, dynamic>
    implements ProductsListBloc {
  final NavigationManager _navigationManager;

  _ProductsListBloc(this._navigationManager) : super(null);
}
