import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  late final StreamSubscription<auth.User?>? _authUserSubscription;
  late final StreamSubscription<User?>? _userSubscription;

  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthEvent>((event, emit) => _mapAuthEventToState(event, emit));

    _authUserSubscription = _authRepository.user.listen(
      (authUser) {
        debugPrint('AuthBloc: authUser: $authUser');
        if (authUser != null) {
          // _userSubscription?.cancel();
          _userRepository.getUser(authUser.uid).listen(
            (user) {
              add(AuthEvent.authChanged(authUser: authUser, user: user));
            },
          );
        } else {
          add(AuthEvent.authChanged(authUser: authUser));
        }
      },
    );
  }

  void _mapAuthEventToState(AuthEvent event, Emitter<AuthState> emit) {
    event.map(
      authChanged: (auth) {
        debugPrint('AuthBloc: authChanged: $auth');
        emit(
          auth.authUser != null
              ? AuthState.authenticated(
                  authUser: auth.authUser!,
                  user: auth.user!,
                )
              : const AuthState.unauthenticated(),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _authUserSubscription?.cancel();
    _userSubscription?.cancel();
    return super.close();
  }
}
