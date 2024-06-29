import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/app_setup/errors/failure.dart';
import 'package:shoesly/core/constants/enums.dart';
import 'package:shoesly/features/auth/controllers/firebase_auth_provider.dart';
import 'package:shoesly/features/auth/domain/models/user_model.dart';
import 'package:shoesly/features/auth/domain/repositories/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);

    return AuthRepositoryImpl(firebaseAuth);
  },
);

abstract class AuthRepository {
  ///[loginWithCreds] login user with provided creds
  Future<Either<Failure, UserModel>> loginWithCreds({
    required String email,
    required String password,
  });

  ///[signupWithCreds] register user with provided creds
  Future<Either<Failure, UserModel>> signupWithCreds({
    required String email,
    required String password,
  });

  /// [loginWithSocialAuth] login user with google account
  Future<Either<Failure, UserModel>> loginWithSocialAuth({
    required SocialAuthType socialAuthType,
  });

  /// [logout] login user with google account
  Future<Either<Failure, bool>> logout();
}
