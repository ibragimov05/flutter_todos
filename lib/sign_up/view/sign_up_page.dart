import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'sign_up_form.dart';
import '../cubit/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() =>
      CupertinoPageRoute<void>(builder: (_) => const SignUpPage());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider<SignUpCubit>(
            create: (_) =>
                SignUpCubit(context.read<AuthenticationRepository>()),
            child: const SignUpForm(),
          ),
        ),
      );
}
