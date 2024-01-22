import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../blocs/blocs.dart';
import '../../core/extensions/extensions.dart';
import '../../features/auth/views/views.dart';

class MainView extends StatefulWidget {
  const MainView({
    super.key,
    required this.authUser,
    required this.user,
  });

  final User user;
  final auth.User authUser;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    _isEmailVerified = widget.authUser.emailVerified;
    if (!_isEmailVerified) {
      await widget.authUser.reload();
      _isEmailVerified = widget.authUser.emailVerified;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        state.maybeMap(
          loading: (_) => context.showLoaderDialog(), //
          failure: (error) {
            context.showToastMsg(error.errorMessage);
            context.hideLoaderDialog();
          },
          success: (_) {
            if (!_isEmailVerified) {
              context.showToastMsg('Please verify your email');
              context.read<SignUpCubit>().verifyEmail();
            }
            context.hideLoaderDialog();
          },
          orElse: () => {},
        );
      },
      child: _isEmailVerified
          ? HomeView(user: widget.user)
          : const VerifyEmailView(),
    );
  }
}
