import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RequestsListBloc extends Bloc<dynamic, dynamic> {
  factory RequestsListBloc() => _RequestsListBloc();
}

class _RequestsListBloc extends Bloc<dynamic, dynamic>
    implements RequestsListBloc {
  _RequestsListBloc() : super(null);
}
