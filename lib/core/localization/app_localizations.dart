// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Medical Decision Network'**
  String get app_name;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register_dr.
  ///
  /// In en, this message translates to:
  /// **'Doctor Registration'**
  String get register_dr;

  /// No description provided for @specialties.
  ///
  /// In en, this message translates to:
  /// **'Clinical Specialties'**
  String get specialties;

  /// No description provided for @online_doctors.
  ///
  /// In en, this message translates to:
  /// **'Online Doctors Now'**
  String get online_doctors;

  /// No description provided for @view_profile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get view_profile;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Start Consultation'**
  String get chat;

  /// No description provided for @clinical_impact.
  ///
  /// In en, this message translates to:
  /// **'Clinical Impact Score'**
  String get clinical_impact;

  /// No description provided for @cases.
  ///
  /// In en, this message translates to:
  /// **'Cases Solved'**
  String get cases;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success Rate'**
  String get success;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Years of Experience'**
  String get experience;

  /// No description provided for @personal_info.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personal_info;

  /// No description provided for @qualifications.
  ///
  /// In en, this message translates to:
  /// **'Qualifications'**
  String get qualifications;

  /// No description provided for @consult_type.
  ///
  /// In en, this message translates to:
  /// **'Consultation Type'**
  String get consult_type;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete Registration'**
  String get complete;

  /// No description provided for @chat_only.
  ///
  /// In en, this message translates to:
  /// **'Chat Only'**
  String get chat_only;

  /// No description provided for @voice_only.
  ///
  /// In en, this message translates to:
  /// **'Voice Only'**
  String get voice_only;

  /// No description provided for @both.
  ///
  /// In en, this message translates to:
  /// **'Chat & Voice'**
  String get both;

  /// No description provided for @dr_name.
  ///
  /// In en, this message translates to:
  /// **'Doctor Name'**
  String get dr_name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @hospital.
  ///
  /// In en, this message translates to:
  /// **'Current Hospital'**
  String get hospital;

  /// No description provided for @board.
  ///
  /// In en, this message translates to:
  /// **'Specialization Board'**
  String get board;

  /// No description provided for @fees.
  ///
  /// In en, this message translates to:
  /// **'Consultation Fees (\$'**
  String get fees;

  /// No description provided for @step.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get step;

  /// No description provided for @of.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get of;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Field is required'**
  String get required;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalid_email;

  /// No description provided for @invalid_phone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalid_phone;

  /// No description provided for @exit_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit? All data will be lost.'**
  String get exit_confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @security_gate_title.
  String get security_gate_title;

  /// No description provided for @security_gate_desc.
  String get security_gate_desc;

  /// No description provided for @access_key.
  String get access_key;

  /// No description provided for @invalid_key.
  String get invalid_key;

  /// No description provided for @verify.
  String get verify;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
