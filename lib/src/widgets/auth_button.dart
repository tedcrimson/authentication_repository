import 'package:authentication_repository/src/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'login_builder.dart';

class AuthButton<T extends AuthCubit> extends LoginBuilder<ButtonBuilder> {
  AuthButton({Key key, ButtonBuilder builder}) : super(key, builder);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (builder != null) {
          return builder(context, null, state, context.watch<T>().callAction);
        }
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: key,
                child: const Text('Next'),
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: state.status.isPure || state.status.isValid
                    ? context.watch<T>().callAction
                    : null,
              );
      },
    );
  }
}
