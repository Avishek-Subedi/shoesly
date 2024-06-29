import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/app_setup/controller/app_state.dart';

import 'package:shoesly/features/auth/controllers/auth_status_provider.dart';

final appController =
    StateNotifierProvider<AppStateNotifier, AppState<User>>((ref) {
  return AppStateNotifier(ref)..appStarted();
});

class AppStateNotifier extends StateNotifier<AppState<User>> {
  AppStateNotifier(this._ref) : super(const AppState<User>.started());

  final Ref _ref;
  late final RemoveListener _authStatusListener;

  Future appStarted() async {
    _ref.listen(authStatusProvider, (previous, next) {
      _updateAuthState(
        next.user,
      );
    });
  }

  void _updateAuthState(User? user) async {
    if (user != null) {
      state = AppState<User>.authenticated(user);
    } else {
      state = const AppState.unAuthenticated();
    }
  }

  void updateAppState(AppState<User> appState) {
    state = appState;
  }

  @override
  void dispose() {
    _authStatusListener();
    super.dispose();
  }
}
