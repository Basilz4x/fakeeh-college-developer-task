import 'package:email_validator/email_validator.dart';
import 'package:fcms_helpdesk/core/exceptions/error_handler.dart';
import 'package:fcms_helpdesk/presentation/controllers/login_page_controller.dart';
import 'package:fcms_helpdesk/presentation/widgets/custom_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});
  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(loginPageControllerProvider.notifier);
      await notifier.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   ref.listen<AsyncValue<void>>(loginPageControllerProvider, (_, state) {
      state.whenOrNull(
        error: (error, stack) { // Changed stackTrace to stack for consistency
          final errorHandler = ref.read(errorHandlerProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorHandler.getErrorMessage(error)), // Use ErrorHandler
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        },
      );
    });

    final authState = ref.watch(loginPageControllerProvider);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomFormTextField(
            controller: _emailController,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Please enter your email';
              }
              if (!EmailValidator.validate(v.trim())) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomFormTextField(
            controller: _passwordController,
            labelText: 'Password',
            isPassword: true,
            validator:
                (v) =>
                    (v == null || v.length < 6)
                        ? 'Password must be at least 6 characters long'
                        : null,
          ),
          const SizedBox(height: 24),
          authState.isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: _submit,
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
