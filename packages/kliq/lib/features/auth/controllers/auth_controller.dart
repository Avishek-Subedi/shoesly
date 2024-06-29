import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/app_setup/controller/base_state.dart';
import 'package:shoesly/app_setup/local_database/hive/hive_service.dart';
import 'package:shoesly/core/constants/enums.dart';
import 'package:shoesly/features/auth/domain/models/user_model.dart';
import 'package:shoesly/features/auth/domain/repositories/auth_repositories.dart';

// final loginControllerProvider = StateNotifierProvider.autoDispose<
//     AuthController<BaseState<dynamic>>, UserModel>(authController);

final loginControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
        authController);

final signUpControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
        authController);

final socialLoginIn =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
        authController);

final signupControllerProvider = StateNotifierProvider.autoDispose<
    AuthController<UserModel>, BaseState<dynamic>>(
  authController,
);
final socialLoginControllerProvider = StateNotifierProvider.autoDispose<
    AuthController<UserModel>, BaseState<dynamic>>(
  authController,
);
final logoutControllerProvider = StateNotifierProvider.autoDispose<
    AuthController<UserModel>, BaseState<dynamic>>(
  authController,
);
AuthController<T> authController<T>(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController<T>(ref, authRepository);
}

class AuthController<T> extends StateNotifier<BaseState> {
  ///
  AuthController(this.ref, this.authRepository)
      : super(const BaseState<void>.initial());

  final Ref ref;

  final AuthRepository authRepository;

  /// [loginWithCreds] login user with [email] and [password]
  Future<void> loginWithCreds({
    required String email,
    required String password,
  }) async {
    state = const BaseState<void>.loading();
    final response =
        await authRepository.loginWithCreds(email: email, password: password);
    state = response.fold(
      (error) => BaseState.error(error),
      (success) {
        HiveService("loginDetails")
            .putItems(itemKey: "email", item: success.email);

        return BaseState<UserModel>.success(data: success);
      },
    );
  }

  /// [signupWithCreds] signup user with [email] and [password]
  Future<void> signupWithCreds({
    required String email,
    required String password,
  }) async {
    state = const BaseState<void>.loading();
    final response =
        await authRepository.signupWithCreds(email: email, password: password);
    state = response.fold(
      (error) => BaseState.error(error),
      (success) => BaseState<UserModel>.success(data: success),
    );
  }

  /// [loginWithSocialAuth] login user with google account
  Future<void> loginWithSocialAuth({
    required SocialAuthType socialAuthType,
  }) async {
    state = const BaseState<void>.loading();
    final response = await authRepository.loginWithSocialAuth(
      socialAuthType: socialAuthType,
    );
    state = response.fold(
      (error) => BaseState.error(error),
      (success) => BaseState<UserModel>.success(data: success),
    );
  }

  /// [logout] logout user from the app
  Future<void> logout() async {
    state = const BaseState<void>.loading();
    final response = await authRepository.logout();
    state = response.fold((errror) {
      return BaseState<void>.error(errror);
    }, (response) {
      return const BaseState<void>.success();
    });
  }
}
