import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../core/extensions/extensions.dart';

class CheckRemindMe extends StatefulWidget {
  const CheckRemindMe({super.key});

  @override
  State<CheckRemindMe> createState() => _CheckRemindMeState();
}

class _CheckRemindMeState extends State<CheckRemindMe> {
  // [isChecked] is used to check the state of the checkbox
  bool isChecked = false;

  @override
  void initState() {
    context.read<SignInCubit>().fetchCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<SignInCubit, SignInState>(
          buildWhen: (previous, current) => current is Remember,
          builder: (context, state) {
            final bool isRemember = state.maybeMap(
              orElse: () => false,
              remember: (state) => state.isRemember,
            );
            return Checkbox(
              activeColor: context.appColors.mainBlue,
              checkColor: context.appColors.mainWhite,
              fillColor: MaterialStateProperty.all(
                isRemember
                    ? context.appColors.mainBlue
                    : context.appColors.mainLightGrey,
              ), // 1
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
              ),
              side: BorderSide(
                color: isRemember
                    ? context.appColors.mainBlue
                    : context.appColors.mainLightGrey,
              ),
              value: isRemember,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
                context.read<SignInCubit>().onRememberChanged(value!);
              },
            );
          },
        ),
        Text('Remind me', style: context.font13Blacklight),
      ],
    );
  }
}
