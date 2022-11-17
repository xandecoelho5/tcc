import 'package:e_markety_client/features/company/blocs/company/company_bloc.dart';
import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:e_markety_client/shared/environment/platform.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/utils/modular_utils.dart';
import '../../../../shared/utils/strings.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../../../admin/product/components/dropdown_with_label.dart';
import '../../../company/models/company.dart';
import '../components/email_password_component.dart';
import '../components/text_button_auth.dart';
import '../models/login_model.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.buildAppBar(showAction: false),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            bloc: Modular.get<AuthBloc>(),
            listener: (context, state) {
              if (state is AuthLogged) {
                if (state.user.isAdmin) {
                  Modular.to.pushNamedAndRemoveUntil(
                    Modular.get<AppPlatform>().defaultRoute,
                    (route) => false,
                  );
                } else {
                  Modular.to.pushNamedAndRemoveUntil(
                    '/home/',
                    (route) => false,
                  );
                }
              }
              if (state is AuthError) {
                ModularUtils.showError(state.message);
              }
            },
          ),
          if (Modular.get<AppPlatform>().isMobile)
            BlocListener<CompanyBloc, CompanyState>(
              bloc: Modular.get<CompanyBloc>()..add(CompanyGetAllEvent()),
              listener: (context, state) {
                if (state is CompanyErrorState) {
                  ModularUtils.showError(state.message);
                }
              },
            ),
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: _SignInForm(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextButtonAuth(
                textLabel: 'Não tem uma conta?',
                textButtonLabel: 'Cadastre-se',
                onPressed: () => Modular.to.navigate('/sign-up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  const _SignInForm({Key? key}) : super(key: key);

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _loginFormKey = GlobalKey<FormState>();

  LoginModel login = const LoginModel(login: '', password: '');

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
      bloc: Modular.get<CompanyBloc>(),
      builder: (context, state) {
        if (state is CompanyLoadedListState) {
          return DropdownWithLabel(
            label: 'Escolha um mercado para acessar',
            items: state.companies,
            data: state.companies.first,
            onSaved: _onCompanySaved,
            onValidate: _onValidateCompany,
            backgroundColor: Colors.white,
          );
        }

        if (state is CompanyLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LogoWidget(),
          const SizedBox(height: 24),
          EmailPasswordComponent(
            onEmailSaved: _onEmailSaved,
            onPasswordSaved: _onSenhaSaved,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     TextButton(
          //       onPressed: () {},
          //       child: const Text(
          //         'Esqueci minha senha',
          //         style: TextStyle(
          //           color: kBasicDarkColor,
          //           fontSize: 18,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 12),
          if (Modular.get<AppPlatform>().isMobile) _buildDropdown(),
          const SizedBox(height: 20),
          FilledButton(
            text: 'Entrar',
            color: Theme.of(context).colorScheme.secondary,
            onPressed: _signIn,
            height: 50,
          ),
        ],
      ),
    );
  }
}
