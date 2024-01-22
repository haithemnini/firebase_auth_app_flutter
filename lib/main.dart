import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './app/auth_user_app.dart';
import './bloc_observer.dart';
import './core/di/get_it.dart';
import './core/routing/routing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([initConfig()]);
  Bloc.observer = AppBlocObserver();

  runApp(AuthUser(
    appRoute: AppRouter(),
  ));
}
