// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medical_app/core/localization/app_localizations.dart';
import 'package:medical_app/core/constants/regex_constants.dart';
import 'package:medical_app/widgets/custom_button.dart';

class DoctorRegistrationScreen extends ConsumerStatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  ConsumerState<DoctorRegistrationScreen> createState() => _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends ConsumerState<DoctorRegistrationScreen> {
  int _currentStep = 1;
  final int _totalSteps = 4;
  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();
  final _step4Key = GlobalKey<FormState>();
  int _consultType = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _expController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _boardController = TextEditingController();
  final TextEditingController _feesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _expController.dispose();
    _hospitalController.dispose();
    _boardController.dispose();
    _feesController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    final appLocalizations = AppLocalizations.of(context);
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(appLocalizations.exit),
            content: Text(appLocalizations.exit_confirm),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(appLocalizations.cancel)),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(appLocalizations.exit)),
            ],
          ),
        ) ??
        false;
  }

  bool _validateCurrentStep() {
    if (_currentStep == 1) return _step1Key.currentState?.validate() ?? false;
    if (_currentStep == 2) return _step2Key.currentState?.validate() ?? false;
    if (_currentStep == 4) return _step4Key.currentState?.validate() ?? false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            title: Text(
                '${appLocalizations.step} $_currentStep ${appLocalizations.of} $_totalSteps')),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _currentStep / _totalSteps,
              minHeight: 6.h,
              color: Theme.of(context).primaryColor,
            ).animate().fadeIn(duration: 500.ms),
            Expanded(
                child: SingleChildScrollView(
                    padding: EdgeInsets.all(24.w),
                    child: _buildStepContent().animate().fadeIn(duration: 500.ms, delay: 200.ms))),
            _buildNavigation(appLocalizations),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1:
        return Form(key: _step1Key, child: _buildStep1());
      case 2:
        return Form(key: _step2Key, child: _buildStep2());
      case 3:
        return _buildStep3();
      case 4:
        return Form(key: _step4Key, child: _buildStep4());
      default:
        return Container();
    }
  }

  Widget _buildStep1() {
    final appLocalizations = AppLocalizations.of(context);
    return Column(children: [
      _field(_nameController, appLocalizations.dr_name, Icons.person),
      _field(_emailController, appLocalizations.email, Icons.email, isEmail: true),
      _field(_phoneController, appLocalizations.phone, Icons.phone, isPhone: true),
    ]);
  }

  Widget _buildStep2() {
    final appLocalizations = AppLocalizations.of(context);
    return Column(children: [
      _field(_expController, appLocalizations.experience, Icons.history_edu, isNum: true),
      _field(_boardController, appLocalizations.board, Icons.verified),
      _field(_hospitalController, appLocalizations.hospital, Icons.local_hospital),
    ]);
  }

  Widget _buildStep3() {
    final appLocalizations = AppLocalizations.of(context);
    return Column(children: [
      _radio(appLocalizations.chat_only, 0),
      _radio(appLocalizations.voice_only, 1),
      _radio(appLocalizations.both, 2),
    ]);
  }

  Widget _buildStep4() {
    final appLocalizations = AppLocalizations.of(context);
    return Column(children: [
      _field(_feesController, appLocalizations.fees, Icons.attach_money, isNum: true)
    ]);
  }

  Widget _field(TextEditingController c, String l, IconData i,
      {bool isNum = false, bool isEmail = false, bool isPhone = false}) {
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: TextFormField(
        controller: c,
        keyboardType: isNum || isPhone
            ? TextInputType.number
            : (isEmail ? TextInputType.emailAddress : TextInputType.text),
        validator: (v) {
          if (v == null || v.isEmpty) return appLocalizations.required;
          if (isEmail && !RegexConstants.emailRegex.hasMatch(v))
            return appLocalizations.invalid_email;
          if (isPhone && !RegexConstants.phoneRegex.hasMatch(v))
            return appLocalizations.invalid_phone;
          return null;
        },
        decoration: InputDecoration(
            labelText: l,
            prefixIcon: Icon(i),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r))),
      ),
    );
  }

  Widget _radio(String t, int v) => RadioListTile(
        title: Text(t),
        value: v,
        groupValue: _consultType,
        onChanged: (val) => setState(() => _consultType = val as int),
      );

  Widget _buildNavigation(AppLocalizations appLocalizations) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.r,
              offset: const Offset(0, -5))
        ]),
        child: Row(
          children: [
            if (_currentStep > 1)
              Expanded(
                  child: CustomButton(
                onPressed: () => setState(() => _currentStep--),
                text: appLocalizations.back,
                isPrimary: false,
              )),
            if (_currentStep > 1) SizedBox(width: 10.w),
            Expanded(
                child: CustomButton(
              onPressed: () {
                if (_validateCurrentStep()) {
                  if (_currentStep < _totalSteps)
                    setState(() => _currentStep++);
                  else
                    Navigator.pop(context);
                }
              },
              text: _currentStep == _totalSteps
                  ? appLocalizations.complete
                  : appLocalizations.next,
            )),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms, delay: 400.ms);
}
