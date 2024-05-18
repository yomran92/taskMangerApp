import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/core/utils.dart';
import 'package:todoapp/core/utils/hive_keys.dart';
import 'package:todoapp/core/widget/custom_text.dart';

import '../../../../core/routing/route_paths.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/string_lbl.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/utils/helper_function.dart';
import '../../../../core/utils/hive_paramter.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../service_locator.dart';
import '../../data/remote/models/params/login_params.dart';
import '../blocs/account_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen();

  @override
  State<StatefulWidget> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final bloc = AccountBloc();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  final GlobalKey<FormFieldState<String>> _passwordKey =
      new GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _usernameKey =
      new GlobalKey<FormFieldState<String>>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.colorPrimary,
          title: CustomText(
            text: StringLbl.login,
            style: Styles.w700TextStyle()
                .copyWith(fontSize: 20.sp, color: Styles.colorTextWhite),
          ),
        ),
        body: SafeArea(
            child: FormBuilder(
          key: _formKey,
          child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    SizedBox(
                      height: 85.h,
                    ),
                    _buildUsername(),
                    CommonSizes.vSmallSpace,
                    _buildPassword(),
                    CommonSizes.vSmallSpace,
                    _buildBtnLogin(),
                    CommonSizes.vSmallSpace,
                  ],
                ),
              )),
        )),
      ),
    );
  }

  @override
  void initState() {
    _usernameController.text = 'kminchelle';
    _passwordController.text = '0lelplR';
    super.initState();
  }

  _buildUsername() {
    return CustomTextField(
      height: 56.h,
      // width: 217.w,
      justLatinLetters: true,
      textKey: _usernameKey,
      controller: _usernameController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        setState(() {});
        return "${StringLbl.validationMessage} ${StringLbl.userName}";
      },
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
      textAlign: TextAlign.left,
      focusNode: _usernameFocusNode,
      hintText: StringLbl.userName,
      minLines: 1,
      onChanged: (String value) {
        if (_usernameKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    );
  }

  _buildPassword() {
    return CustomTextField(
      height: 56.h,
      justLatinLetters: true,
      textKey: _passwordKey,
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        setState(() {});
        return "${StringLbl.validationMessage} ${StringLbl.password}";
      },
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
      textAlign: TextAlign.left,
      focusNode: _passwordFocusNode,
      hintText: StringLbl.password,
      minLines: 1,
      onChanged: (String value) {
        if (_passwordKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    );
  }

  _buildBtnLogin() {
    return BlocConsumer<AccountBloc, AccountState>(
        bloc: sl<AccountBloc>(),
        listener: (context, AccountState state) async {
          if (state is AccountLoading) {
          } else if (state is AccountError) {
            HelperFunction.showToast(state.message.toString());
          } else if (state is LogInLoaded) {
            final userBox = await sl<HiveParamter>().hive.box(HiveKeys.userBox);
            userBox.clear();
            userBox.add(state.logInEntity!.userModel);
            //save User
            sl<AppStateModel>().setUser(state.logInEntity!.userModel);

            Utils.popNavigateToFirst(context);
            Utils.pushReplacementNavigateTo(
              context,
              RoutePaths.TaskScreen,
            );
          }
        },
        builder: (context, state) {
          if (sl<AccountBloc>().state is AccountLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: CustomButton(
              text: StringLbl.login,

              style: Styles.w600TextStyle()
                  .copyWith(fontSize: 14.sp, color: Styles.colorTextWhite),
              raduis: 14.r,
              textAlign: TextAlign.center,
              color: Styles.colorPrimary,
              fillColor: Styles.colorPrimary,
              // width: 350.w,
              height: 52.h,
              alignmentDirectional: AlignmentDirectional.center,
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();

                if (!Validators.isNotEmptyString(_usernameController.text)) {
                  HelperFunction.showToast(
                      "${StringLbl.validationMessage} ${StringLbl.userName}");
                }
                if (!Validators.isNotEmptyString(_passwordController.text)) {
                  HelperFunction.showToast(
                      "${StringLbl.validationMessage} ${StringLbl.password}");
                } else {
                  HelperFunction.showToast("all validated");
                  sl<AccountBloc>().add(LogInEvent(
                      logInParams: LogInParams(
                          body: LogInParamsBody(
                              username: _usernameController.text,
                              password: _passwordController.text))));
                }
              },
            ),
          );
        });
  }
}
