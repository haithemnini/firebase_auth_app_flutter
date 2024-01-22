import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../core/extensions/extensions.dart';

class SignInBlocListener extends StatelessWidget {
  const SignInBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        debugPrint('state listeneing : $state');
        state.maybeMap(
          loading: (_) => context.showLoaderDialog(),
          success: (_) => context.hideLoaderDialog(),
          orElse: () => {},
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
