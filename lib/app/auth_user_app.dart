import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

import '../blocs/blocs.dart';
import '../core/extensions/extensions.dart';
import '../core/routing/routing.dart';
import '../core/theming/app_theming.dart';
import 'views/views.dart';

class AuthUser extends StatelessWidget {
  AuthUser({
    super.key,
    required AppRouter appRoute,
  }) : _appRouter = appRoute;

  final AppRouter _appRouter;

  /// This code initializes an instance of the [AuthRepository] class
  /// and waits for the first user object emitted by the [user] stream.
  final AuthRepository _authRepository = AuthRepository()..user.first;

  /// This code initializes an instance of the [UserRepository] class
  /// and waits for the first user object emitted by the [user] stream.
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    // Sets the system UI overlay based on the current [BuildContext].
    context.overlaySystemUiConfig();
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(390, 844),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => _authRepository,
          ),
          RepositoryProvider(
            create: (context) => _userRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider<SignInCubit>(
              create: (context) => SignInCubit(
                authRepository: context.read<AuthRepository>(),
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider<SignUpCubit>(
              create: (context) => SignUpCubit(
                authRepository: context.read<AuthRepository>(),
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider<ForgotPasswordCubit>(
              create: (context) => ForgotPasswordCubit(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'User Auth App',
            theme: AppTheming.theme,
            darkTheme: AppTheming.darkTheme,
            themeMode: ThemeMode.system,
            home: const MainAuthView(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: _appRouter.generateRoute,
          ),
        ),
      ),
    );
  }
}
