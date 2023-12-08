import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../generated/assets.gen.dart';
import '../../generated/translations.g.dart';
import '../../public_providers/app_user_cubit/app_user_cubit.dart';
import '../../routes/app_router.dart';
import '../../services/apis/api_client.dart';
import '../../services/app_dio.dart';
import '../../services/public_api.dart';
import '../../shared/helpers/dialog_helper.dart';
import '../../shared/utils/app_colors.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_dismiss_keyboard.dart';
import '../../shared/widgets/app_layout.dart';
import '../../shared/widgets/app_text.dart';
import '../../shared/widgets/app_text_field.dart';
import 'cubit/connect_to_server_screen_cubit.dart';

class ConnectToServerScreen extends StatelessWidget {
  ConnectToServerScreen({super.key});

  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppDismissKeyboard(
      onWillPop: false,
      child: BlocProvider(
        create: (context) => ConnectToServerScreenCubit(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<ConnectToServerScreenCubit,
                ConnectToServerScreenState>(
              listenWhen: (previous, current) =>
                  previous.isConfirmed != current.isConfirmed &&
                  current.isConfirmed,
              listener: (context, state) {
                showSuccessDialog(context,
                        title: tr(LocaleKeys.App_Success),
                        content:
                            tr(LocaleKeys.Auth_ConnectToServerSuccessfully))
                    .then((value) {
                  PublicApi.baseUrl = state.baseUrl!;
                  PublicApi.apis = APIClient(AppDio(), baseUrl: state.baseUrl!);
                  context
                      .read<ConnectToServerScreenCubit>()
                      .checkToken()
                      .then((user) {
                    if (user != null) {
                      context.read<AppUserCubit>().updateUser(state.user);
                      Get.toNamed(Routes.main);
                      return;
                    }
                    Get.toNamed(Routes.login);
                  });
                });
              },
            ),
            BlocListener<ConnectToServerScreenCubit,
                ConnectToServerScreenState>(
              listenWhen: (previous, current) =>
                  previous.errorMessage != current.errorMessage &&
                  current.errorMessage != null,
              listener: (context, state) {
                showErrorDialog(context,
                        title: tr(LocaleKeys.Auth_Error),
                        content: state.errorMessage)
                    .then((value) => context
                        .read<ConnectToServerScreenCubit>()
                        .resetErrorMessage());
              },
            ),
          ],
          child: BlocBuilder<ConnectToServerScreenCubit,
              ConnectToServerScreenState>(
            builder: (context, state) {
              return AppLayout(
                leading: const SizedBox.shrink(),
                resizeToAvoidBottomInset: true,
                title: "Connect to server".toUpperCase(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Wrap(
                      runSpacing: 16,
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.center,
                      children: [
                        Assets.icons.pcFetchApi
                            .svg(width: MediaQuery.of(context).size.width),
                        AppText(
                          "Because the product is in the development stage. To be able to use the services, please enter the server link address below.",
                          textAlign: TextAlign.justify,
                          color: AppColors.titleText,
                          fontSize: 16,
                        ),
                        AppTextField(
                          placeholder: "Enter your url...",
                          controller: _textController,
                          initValue: "http://10.0.2.2:8080",
                          onChanged: context
                              .read<ConnectToServerScreenCubit>()
                              .updateBaseUrl,
                        ),
                        AppButton(
                            width: MediaQuery.of(context).size.width,
                            title: "Confirm",
                            onPressed: () {
                              Get.toNamed(Routes.welcome);
                              // context
                              //     .read<ConnectToServerScreenCubit>()
                              //     .confirmBaseUrl)
                            })
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
