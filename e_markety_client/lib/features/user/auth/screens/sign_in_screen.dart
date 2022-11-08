import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/company/blocs/company/company_bloc.dart';
import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:e_markety_client/shared/environment/platform.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/utils/strings.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../../../admin/product/components/dropdown_with_label.dart';
import '../../../company/models/company.dart';
import '../components/email_password_component.dart';
import '../components/text_button_auth.dart';
import '../models/login_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  LoginModel login = const LoginModel(login: '', password: '', companyId: 0);

  Future<void> _signIn() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      Modular.get<AuthBloc>().add(AuthSignInEvent(login));
    }
  }

  void _onEmailSaved(String? value) => login = login.copyWith(login: value);

  void _onSenhaSaved(String? value) => login = login.copyWith(password: value);

  void _onCompanySaved(Company? value) =>
      login = login.copyWith(companyId: value?.id);

  String? _onValidateCompany(Company? v) =>
      v == null ? Strings.obrigatorio : null;

  BlocBuilder<CompanyBloc, CompanyState> _buildDropdown() {
    return BlocBuilder<CompanyBloc, CompanyState>(
      bloc: Modular.get<CompanyBloc>()..add(CompanyGetAllEvent()),
      builder: (context, state) {
        if (state is CompanyLoadedListState) {
          return DropdownWithLabel(
            label: 'Escolha o mercado',
            items: state.companies,
            data: state.companies.first,
            onSaved: _onCompanySaved,
            onValidate: _onValidateCompany,
            backgroundColor: Colors.white,
          );
        }

        if (state is CompanyErrorState) {
          Modular.get<ISnackBarService>().showError(context, state.message);
        }

        if (state is CompanyLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.buildAppBar(context),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: Modular.get<AuthBloc>(),
        listener: (context, state) {
          print(Modular.get<AppPlatform>().defaultRoute);
          if (state is AuthLogged) {
            Modular.to.navigate(Modular.get<AppPlatform>().defaultRoute);
          }
          if (state is AuthError) {
            Modular.get<ISnackBarService>().showError(context, state.message);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Form(
                  key: _loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.055,
                      ),
                      const LogoWidget(),
                      const SizedBox(height: 40),
                      _buildDropdown(),
                      const SizedBox(height: 20),
                      EmailPasswordComponent(
                        onEmailSaved: _onEmailSaved,
                        onPasswordSaved: _onSenhaSaved,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Esqueci minha senha',
                              style: TextStyle(
                                color: kBasicDarkColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        text: 'Entrar',
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: _signIn,
                      ),
                    ],
                  ),
                ),
                TextButtonAuth(
                  textLabel: 'Não tem uma conta?',
                  textButtonLabel: 'Cadastre-se',
                  onPressed: () => Modular.to.navigate('/sign-up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
