import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/extensions/extensions.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Already have an account?  ',
        style: context.font13Blacklight,
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () => onTap(),
            text: 'Sign in',
            style: context.font13BlueSemiBold,
          ),
        ],
      ),
    );
  }
}
