import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extensions/extensions.dart';
import '../../blocs/blocs.dart';
import './views.dart';

class MainAuthView extends StatelessWidget {
  const MainAuthView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.map(
          unknown: (_) => _buildUnknownView(context),
          authenticated: (user) {
            return MainView(
              user: user.user,
              authUser: user.authUser,
            );
          },
          unauthenticated: (_) => const AuthView(),
        );
      },
    );
  }

  _buildUnknownView(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: context.appColors.mainBlue,
        ),
      ),
    );
  }
}
