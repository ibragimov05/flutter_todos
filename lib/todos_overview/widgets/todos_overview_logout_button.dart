import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/app/bloc/app_bloc.dart';

class TodosOverviewLogoutButton extends StatelessWidget {
  const TodosOverviewLogoutButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
        icon: Icon(Icons.logout),
      );
}
