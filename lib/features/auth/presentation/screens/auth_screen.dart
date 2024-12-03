import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/features/auth/data/auth_service.dart';
import 'package:taskmanager/features/auth/presentation/providers/auth_provider.dart';
import 'package:taskmanager/shared/widgets/styled_text_field.dart';

class AuthScreen extends ConsumerWidget {
  AuthScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _username = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.read(authStateProvider.notifier);

    void _submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      authNotifier.setAuthenticating(true);

      try {
        if (authState.isLogin) {
          await AuthService(context)
              .loginWithEmailAndPassword(_email, _password);
        } else {
          await AuthService(context)
              .registerWithEmailAndPassword(_email, _password, _username);
        }
      } catch (error) {
        authNotifier.setError(error.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      } finally {
        authNotifier.setAuthenticating(false);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                width: 200,
                child: const Icon(
                  Icons.lock,
                  size: 200,
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                elevation: 2,
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StyledTextField(
                          label: 'Email',
                          hint: 'Enter your Email address',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || !value.contains('@')) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value!,
                        ),
                        const SizedBox(height: 10,),
                        if (!authState.isLogin)
                          StyledTextField(
                            label: 'Username',
                            hint: 'User Name',
                            prefixIcon: Icons.person,
                            validator: (value) {
                              if (value == null) {
                                return 'Enter at least 1 characters';
                              }
                              return null;
                            },
                            onSaved: (value) => _username = value!,
                          ),
                          const SizedBox(height: 10,),
                        StyledTextField(
                          label: 'Password',
                          hint: 'Enter your Password',
                           prefixIcon: Icons.lock,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value!,
                        ),
                        const SizedBox(height: 12),
                        if (authState.isAuthenticating)
                          const CircularProgressIndicator(),
                        if (!authState.isAuthenticating)
                          ElevatedButton(
                            onPressed: _submit,
                            child:
                                Text(authState.isLogin ? 'Login' : 'Sign Up'),
                          ),
                        if (!authState.isAuthenticating)
                          TextButton(
                            onPressed: authNotifier.toggleAuthMode,
                            child: Text(
                                authState.isLogin ? 'Create Account' : 'Login'),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
