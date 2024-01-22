import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../blocs/blocs.dart';
import '../../../../core/extensions/extensions.dart';
import '../../widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildListTileUser(context),
                  SizedBox(height: 48.h),
                  _createLogOutButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildListTileUser(BuildContext context) {
    return ListTile(
      leading: _buildCircleAvatar(context),
      title: Text('Welcome : ${user.fullName}'),
      subtitle: Text(user.email),
    );
  }

  CustomElevatedButton _createLogOutButton(BuildContext context) {
    return CustomElevatedButton(
      text: 'LogOut',
      icon: const Icon(Icons.logout_outlined, size: 20),
      onPressed: () => context.read<SignInCubit>().signOut(),
    );
  }

  CircleAvatar _buildCircleAvatar(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.appColors.mainBlue,
      radius: 20.r,
      child: user.photoUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(user.photoUrl!),
            )
          : Text(
              user.fullName.substring(0, 2).toUpperCase(),
              style: TextStyle(
                color: context.appColors.mainWhite,
              ),
            ),
    );
  }
}
