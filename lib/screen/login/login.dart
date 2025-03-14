import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:nike_ecommerce/screen/login/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // context.read<LoginBloc>().add(ChangeSecureFildPassEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                Image.asset(
                  "assets/img/nike_logo_wite.png",
                  width: 80,
                  height: 80,
                ),
                Text(AppLocalizations.of(context)!.welcomeMessage,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 4,
                ),
                Text(AppLocalizations.of(context)!.discriptioinLoginScreen,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.userNameButtom,
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginPassFildSecure) {
                      return TextFormField(
                        obscureText: true,
                        obscuringCharacter: '*',
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.passwordButtom,
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              context
                                  .read<LoginBloc>()
                                  .add(ChangeSecureFildPassEvent());
                            },
                          ),
                        ),
                      );
                    } else if (state is LoginPassFildNotSecure) {
                      return TextFormField(
                        obscureText: false,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.passwordButtom,
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              context
                                  .read<LoginBloc>()
                                  .add(ChangeSecureFildPassEvent());
                            },
                          ),
                        ),
                      );
                    } else if (state is LoginInitial) {
                      return TextFormField(
                        obscureText: true,
                        obscuringCharacter: '*',
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.passwordButtom,
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              context
                                  .read<LoginBloc>()
                                  .add(ChangeSecureFildPassEvent());
                            },
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {},
                      autofocus: true,
                      child: Text(AppLocalizations.of(context)!.loginButton)),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.forgetPasswordButtom,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
