import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoesly/app_setup/errors/failure.dart';
import 'package:shoesly/app_setup/errors/firebase_auth_extension.dart';
import 'package:shoesly/core/constants/enums.dart';
import 'package:shoesly/features/auth/domain/models/user_model.dart';
import 'package:shoesly/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.firebaseAuth);
  final FirebaseAuth firebaseAuth;
  GoogleSignIn get _googleSignIn => GoogleSignIn(scopes: <String>['email']);

  @override
  Future<Either<Failure, UserModel>> loginWithCreds(
      {required String email, required String password}) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return Right(UserModel(email: response.user!.email!, userId: 'userId'));
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(e.getMessageFromErrorCode, FailureType.authentication),
      );
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginWithSocialAuth(
      {required SocialAuthType socialAuthType}) async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final response = await firebaseAuth.signInWithCredential(credential);

        return Right(
          UserModel(
            email: response.user!.email!,
            userId: response.user!.uid,
            emailVerified: response.user!.emailVerified,
          ),
        );
      } else {
        return Left(
          Failure(
            'Something went wrong',
            FailureType.authentication,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(e.getMessageFromErrorCode, FailureType.authentication),
      );
    } catch (e) {
      return Left(
        Failure(
          'Something went wrong',
          FailureType.authentication,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> signupWithCreds(
      {required String email, required String password}) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Right(UserModel(email: response.user!.email!, userId: 'userId'));
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(e.getMessageFromErrorCode, FailureType.authentication),
      );
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await firebaseAuth.signOut();
      await _googleSignIn.signOut();

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure(e.getMessageFromErrorCode, FailureType.authentication),
      );
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
