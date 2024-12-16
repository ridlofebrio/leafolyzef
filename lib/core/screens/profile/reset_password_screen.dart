import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/profile/profile_bloc.dart';
import 'package:leafolyze/blocs/profile/profile_event.dart';
import 'package:leafolyze/blocs/profile/profile_state.dart';
import 'package:leafolyze/core/widgets/notification/custom_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/utils/constants.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is PasswordUpdateSuccess) {
          CustomDialog.showPopupDialog(
            context: context,
            title: 'Success',
            message: 'Password updated successfully!',
            icon: Icons.check_circle,
            iconColor: Colors.green,
            onClose: () {
              context.go('/home');
            },
          );
        } else if (state is ProfileError) {
          CustomDialog.showPopupDialog(
            context: context,
            title: 'Error',
            message: 'Error: ${state.message}',
            icon: Icons.error,
            iconColor: Colors.red,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Set a New Password'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create a new password. Ensure it differs from previous ones for security.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: currentPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 50.0),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      final currentPassword = currentPasswordController.text;
                      final newPassword = newPasswordController.text;
                      final confirmPassword = confirmPasswordController.text;

                      // Validasi untuk memastikan password baru dan konfirmasi password baru cocok
                      if (newPassword != confirmPassword) {
                        CustomDialog.showPopupDialog(
                          context: context,
                          title: 'Error',
                          message: 'Passwords do not match!',
                          icon: Icons.error,
                          iconColor: Colors.red,
                        );
                        return;
                      }

                      // Memicu event untuk memperbarui password
                      context.read<ProfileBloc>().add(UpdatePassword(
                            currentPassword: currentPassword,
                            newPassword: newPassword,
                            newPasswordConfirmation: confirmPassword,
                          ));
                    },
                    child: const Text(
                      'Update Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                  );
                },
              ),
              if (State is ProfileLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
