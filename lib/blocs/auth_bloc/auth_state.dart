part of 'auth_bloc.dart';

// enum AuthStatus { authenticated, unauthenticated, unknown }

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = _Unknown;
  const factory AuthState.authenticated({
    required auth.User authUser,
    required User user,
  }) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
}
