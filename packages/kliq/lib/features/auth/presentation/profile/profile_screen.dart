import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shoesly/app_setup/controller/base_state.dart';
import 'package:shoesly/app_setup/controller/theme_notifier.dart';
import 'package:shoesly/config/route/paths.dart';
import 'package:shoesly/features/auth/controllers/auth_controller.dart';
import 'package:shoesly/features/auth/controllers/auth_status_provider.dart';
import 'package:shoesly_components/shoesly_componenets.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(logoutControllerProvider.notifier);

    final user = ref.watch(authStatusProvider).user;

    ref.listen(logoutControllerProvider, (prev, next) {
      if (next is BaseError) {
        context.showSnackBar(message: next.failure.reason.toString());
      }
      if (next is BaseSuccess) {
        context.go(Paths.loginScreenRoute.path);
        context.showSnackBar(
            message: "successfully logged out", isError: false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme(context).primary,
        title: Text(
          'Profile',
          style: textTheme(context)
              .bodyLarge
              ?.copyWith(color: colorScheme(context).onPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(-10, -10),
                  blurRadius: 15,
                ),
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(10, 10),
                  blurRadius: 15,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileItem(
                  context,
                  label: 'Name',
                  value: user?.displayName ?? "N/A",
                ),
                const SizedBox(height: 16),
                _buildProfileItem(
                  context,
                  label: 'Email',
                  value: user?.email ?? "N/A",
                ),
                const SizedBox(height: 16),
                _buildProfileItem(
                  context,
                  label: 'Email Verified',
                  value: user?.emailVerified.toString() ?? "N/A",
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await auth.logout();
                      if (context.mounted) {
                        context.go(Paths.loginScreenRoute.path);
                      }
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor: Colors.grey.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context,
      {required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).secondary,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                color: colorScheme(context).secondary,
              ),
        ),
      ],
    );
  }
}
