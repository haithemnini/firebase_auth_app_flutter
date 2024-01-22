import 'package:flutter/material.dart';
import '../../../../../core/extensions/extensions.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'By continuing, you agree to our',
                style: context.font13Blacklight,
              ),
              TextSpan(
                text: ' terms of service.',
                style: context.font13BlueRegular,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
