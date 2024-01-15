import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/app/presentation/osk_app.dart';
import 'features/observers/osk_bloc_observer.dart';
import 'features/observers/osk_flutter_error_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = OskBlocObserver();
  FlutterErrorObserver.setupErrorHandlers();

  runApp(const OskApp());
}
