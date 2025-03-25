import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @trackYourApplications.
  ///
  /// In en, this message translates to:
  /// **'Track Your Applications'**
  String get trackYourApplications;

  /// No description provided for @monitorYourProgress.
  ///
  /// In en, this message translates to:
  /// **'Monitor Your Progress'**
  String get monitorYourProgress;

  /// No description provided for @effectively.
  ///
  /// In en, this message translates to:
  /// **'Effectively'**
  String get effectively;

  /// No description provided for @efficiently.
  ///
  /// In en, this message translates to:
  /// **'Efficiently'**
  String get efficiently;

  /// No description provided for @jobSearchAppGetsYou.
  ///
  /// In en, this message translates to:
  /// **'The Job Search App That Gets You'**
  String get jobSearchAppGetsYou;

  /// No description provided for @hired.
  ///
  /// In en, this message translates to:
  /// **'Hired'**
  String get hired;

  /// No description provided for @applyPositionsInDays.
  ///
  /// In en, this message translates to:
  /// **'Apply 100+ Positions in 7 Days'**
  String get applyPositionsInDays;

  /// No description provided for @visualizeYourProgress.
  ///
  /// In en, this message translates to:
  /// **'Visualize Your Progress'**
  String get visualizeYourProgress;

  /// No description provided for @clearly.
  ///
  /// In en, this message translates to:
  /// **'Clearly'**
  String get clearly;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Turbo'**
  String get appTitle;

  /// No description provided for @welcomeTitle1.
  ///
  /// In en, this message translates to:
  /// **'Search your job across the Globe'**
  String get welcomeTitle1;

  /// No description provided for @welcomeDesc1.
  ///
  /// In en, this message translates to:
  /// **'Reach companies looking for an employees. Here\'s a quick tour.'**
  String get welcomeDesc1;

  /// No description provided for @welcomeTitle2.
  ///
  /// In en, this message translates to:
  /// **'Request Tab'**
  String get welcomeTitle2;

  /// No description provided for @welcomeDesc2.
  ///
  /// In en, this message translates to:
  /// **'Get more offers from the start with a dynamic Job Requests. Your request will repeat on selected days.'**
  String get welcomeDesc2;

  /// No description provided for @welcomeTitle3.
  ///
  /// In en, this message translates to:
  /// **'Apply Tab'**
  String get welcomeTitle3;

  /// No description provided for @welcomeDesc3.
  ///
  /// In en, this message translates to:
  /// **'Capture positions right when they begin their publication. Your apply will appear prominently at the top of the recruiters list.'**
  String get welcomeDesc3;

  /// No description provided for @welcomeTitle4.
  ///
  /// In en, this message translates to:
  /// **'Apply results'**
  String get welcomeTitle4;

  /// No description provided for @welcomeDesc4.
  ///
  /// In en, this message translates to:
  /// **'Reach requests the moment they search with an proposal. We\'ll match your request with companies based on a direct signal of their intent - their search term.'**
  String get welcomeDesc4;

  /// No description provided for @welcomeTitle5.
  ///
  /// In en, this message translates to:
  /// **'Direct links to companies websites'**
  String get welcomeTitle5;

  /// No description provided for @welcomeDesc5.
  ///
  /// In en, this message translates to:
  /// **'Reach businesses directly when they actively researching market and getting information to help them decide wether to hire. Your request will appear to interested company without third-party.'**
  String get welcomeDesc5;

  /// No description provided for @welcomeTitle6.
  ///
  /// In en, this message translates to:
  /// **'We are here to help.'**
  String get welcomeTitle6;

  /// No description provided for @welcomeDesc6.
  ///
  /// In en, this message translates to:
  /// **'We\'ll help you to get more offers and apply for more jobs.'**
  String get welcomeDesc6;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get next;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get done;

  /// No description provided for @navRequest.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get navRequest;

  /// No description provided for @navApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get navApply;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @noAppliedJobs.
  ///
  /// In en, this message translates to:
  /// **'No applied jobs found yet'**
  String get noAppliedJobs;

  /// No description provided for @noPendingJobs.
  ///
  /// In en, this message translates to:
  /// **'No pending jobs found yet'**
  String get noPendingJobs;

  /// No description provided for @noRejectedJobs.
  ///
  /// In en, this message translates to:
  /// **'No rejected jobs found yet'**
  String get noRejectedJobs;

  /// No description provided for @noSuccessfulJobs.
  ///
  /// In en, this message translates to:
  /// **'No successful applications found yet'**
  String get noSuccessfulJobs;

  /// No description provided for @noJobs.
  ///
  /// In en, this message translates to:
  /// **'No jobs found yet'**
  String get noJobs;

  /// No description provided for @jobApplications.
  ///
  /// In en, this message translates to:
  /// **'Job Applications'**
  String get jobApplications;

  /// No description provided for @toApply.
  ///
  /// In en, this message translates to:
  /// **'To Apply'**
  String get toApply;

  /// No description provided for @applied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get applied;

  /// No description provided for @noJobListings.
  ///
  /// In en, this message translates to:
  /// **'No job listings found'**
  String get noJobListings;

  /// No description provided for @markAsNotApplied.
  ///
  /// In en, this message translates to:
  /// **'Mark as not applied'**
  String get markAsNotApplied;

  /// No description provided for @subscribeForUpdates.
  ///
  /// In en, this message translates to:
  /// **'Showing only part of the jobs. To see all jobs, subscribe to PRO'**
  String get subscribeForUpdates;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @noRequests.
  ///
  /// In en, this message translates to:
  /// **'No requests yet. Tap + to add one.'**
  String get noRequests;

  /// No description provided for @addNewRequest.
  ///
  /// In en, this message translates to:
  /// **'Add New Request'**
  String get addNewRequest;

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select a country'**
  String get selectCountry;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @pleaseSelectCountry.
  ///
  /// In en, this message translates to:
  /// **'Please select a country'**
  String get pleaseSelectCountry;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @enterLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter location'**
  String get enterLocation;

  /// No description provided for @pleaseEnterLocation.
  ///
  /// In en, this message translates to:
  /// **'Please enter location'**
  String get pleaseEnterLocation;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @enterPosition.
  ///
  /// In en, this message translates to:
  /// **'Enter position'**
  String get enterPosition;

  /// No description provided for @pleaseEnterPosition.
  ///
  /// In en, this message translates to:
  /// **'Please enter position'**
  String get pleaseEnterPosition;

  /// No description provided for @keywords.
  ///
  /// In en, this message translates to:
  /// **'Keywords'**
  String get keywords;

  /// No description provided for @enterKeywordsSeparated.
  ///
  /// In en, this message translates to:
  /// **'Enter keywords separated by commas'**
  String get enterKeywordsSeparated;

  /// No description provided for @newBadge.
  ///
  /// In en, this message translates to:
  /// **'new'**
  String get newBadge;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @countryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country: {country}'**
  String countryLabel(Object country);

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location: {location}'**
  String locationLabel(Object location);

  /// No description provided for @keywordsLabel.
  ///
  /// In en, this message translates to:
  /// **'Keywords: {keywords}'**
  String keywordsLabel(Object keywords);

  /// No description provided for @applicationProgress.
  ///
  /// In en, this message translates to:
  /// **'Application Progress'**
  String get applicationProgress;

  /// No description provided for @appliedJobs.
  ///
  /// In en, this message translates to:
  /// **'Applied Jobs'**
  String get appliedJobs;

  /// No description provided for @pendingJobs.
  ///
  /// In en, this message translates to:
  /// **'Pending Jobs'**
  String get pendingJobs;

  /// No description provided for @rejectedJobs.
  ///
  /// In en, this message translates to:
  /// **'Rejected Jobs'**
  String get rejectedJobs;

  /// No description provided for @successfulApplications.
  ///
  /// In en, this message translates to:
  /// **'Successful Applications'**
  String get successfulApplications;

  /// No description provided for @appliedStatus.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get appliedStatus;

  /// No description provided for @noAnswerStatus.
  ///
  /// In en, this message translates to:
  /// **'No Answer'**
  String get noAnswerStatus;

  /// No description provided for @rejectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejectedStatus;

  /// No description provided for @successfulStatus.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get successfulStatus;

  /// No description provided for @skillsAndTechnologies.
  ///
  /// In en, this message translates to:
  /// **'Skills & Technologies'**
  String get skillsAndTechnologies;

  /// No description provided for @aboutTheCompany.
  ///
  /// In en, this message translates to:
  /// **'About the Company'**
  String get aboutTheCompany;

  /// No description provided for @noCompanyDescription.
  ///
  /// In en, this message translates to:
  /// **'No company description available.'**
  String get noCompanyDescription;

  /// No description provided for @applyVia.
  ///
  /// In en, this message translates to:
  /// **'Apply via'**
  String get applyVia;

  /// No description provided for @markAsApplied.
  ///
  /// In en, this message translates to:
  /// **'Mark as Applied'**
  String get markAsApplied;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @errorLoadingJobPosting.
  ///
  /// In en, this message translates to:
  /// **'Unable to load job posting. Please try again later.'**
  String get errorLoadingJobPosting;

  /// No description provided for @errorRequestTimeout.
  ///
  /// In en, this message translates to:
  /// **'Unable to load job posting. The request timed out.'**
  String get errorRequestTimeout;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @premiumSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get access to all premium features'**
  String get premiumSubtitle;

  /// No description provided for @featureAllJobListings.
  ///
  /// In en, this message translates to:
  /// **'All job listings'**
  String get featureAllJobListings;

  /// No description provided for @planWeek.
  ///
  /// In en, this message translates to:
  /// **'1 Week'**
  String get planWeek;

  /// No description provided for @planYear.
  ///
  /// In en, this message translates to:
  /// **'1 Year'**
  String get planYear;

  /// No description provided for @bestValue.
  ///
  /// In en, this message translates to:
  /// **'Best Value'**
  String get bestValue;

  /// No description provided for @errorPurchaseNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'In-app purchases are not available on this device.'**
  String get errorPurchaseNotAvailable;

  /// No description provided for @errorWebPurchase.
  ///
  /// In en, this message translates to:
  /// **'In-app purchases are not available on web. Please use our mobile app.'**
  String get errorWebPurchase;

  /// No description provided for @errorFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load subscription options'**
  String get errorFailedToLoad;

  /// No description provided for @errorPurchasePending.
  ///
  /// In en, this message translates to:
  /// **'Please wait for the current purchase to complete'**
  String get errorPurchasePending;

  /// No description provided for @errorPurchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed: {error}'**
  String errorPurchaseFailed(Object error);

  /// No description provided for @useMobileApp.
  ///
  /// In en, this message translates to:
  /// **'Please use our mobile app to purchase.'**
  String get useMobileApp;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteAccountConfirmation;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello {firstName}!'**
  String hello(String firstName);

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signUp;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @lostCode.
  ///
  /// In en, this message translates to:
  /// **'Lost your code?'**
  String get lostCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **''**
  String get verify;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **''**
  String get signOut;

  /// No description provided for @signInWith.
  ///
  /// In en, this message translates to:
  /// **'Sign In with {provider}'**
  String signInWith(String provider);

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'No account?'**
  String get noAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get haveAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @confirmResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get confirmResetPassword;

  /// No description provided for @backTo.
  ///
  /// In en, this message translates to:
  /// **'Back to {previousStep}'**
  String backTo(String previousStep);

  /// No description provided for @copyKey.
  ///
  /// In en, this message translates to:
  /// **'Copy Key'**
  String get copyKey;

  /// No description provided for @confirmSignUp.
  ///
  /// In en, this message translates to:
  /// **'Confirm Sign-up'**
  String get confirmSignUp;

  /// No description provided for @confirmSignInMfa.
  ///
  /// In en, this message translates to:
  /// **'Confirm Sign-in'**
  String get confirmSignInMfa;

  /// No description provided for @confirmSignInNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Sign-in'**
  String get confirmSignInNewPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @verifyUser.
  ///
  /// In en, this message translates to:
  /// **'Verify User'**
  String get verifyUser;

  /// No description provided for @confirmVerifyUser.
  ///
  /// In en, this message translates to:
  /// **'Confirm Verify User'**
  String get confirmVerifyUser;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmAttribute.
  ///
  /// In en, this message translates to:
  /// **'Confirm {attribute}'**
  String confirmAttribute(String attribute);

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @passwordConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get passwordConfirmation;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @customChallenge.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Code'**
  String get customChallenge;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @birthdate.
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get birthdate;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @familyName.
  ///
  /// In en, this message translates to:
  /// **'Family Name'**
  String get familyName;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @givenName.
  ///
  /// In en, this message translates to:
  /// **'Fist Name'**
  String get givenName;

  /// No description provided for @middleName.
  ///
  /// In en, this message translates to:
  /// **'Middle Name'**
  String get middleName;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @preferredUsername.
  ///
  /// In en, this message translates to:
  /// **'Preferred Username'**
  String get preferredUsername;

  /// No description provided for @rememberDevice.
  ///
  /// In en, this message translates to:
  /// **'Remember Device?'**
  String get rememberDevice;

  /// No description provided for @selectSms.
  ///
  /// In en, this message translates to:
  /// **'Text Message (SMS)'**
  String get selectSms;

  /// No description provided for @selectTotp.
  ///
  /// In en, this message translates to:
  /// **'Authenticator App (TOTP)'**
  String get selectTotp;

  /// No description provided for @totpCodePrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter the code from your registered Authenticator app'**
  String get totpCodePrompt;

  /// No description provided for @usernameType.
  ///
  /// In en, this message translates to:
  /// **'Log in using:'**
  String get usernameType;

  /// No description provided for @promptFill.
  ///
  /// In en, this message translates to:
  /// **'Enter your {attribute}'**
  String promptFill(String attribute);

  /// No description provided for @promptRefill.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your {attribute}'**
  String promptRefill(String attribute);

  /// No description provided for @warnEmpty.
  ///
  /// In en, this message translates to:
  /// **'{attribute} field must not be blank.'**
  String warnEmpty(String attribute);

  /// No description provided for @warnInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid {attributeType} format.'**
  String warnInvalidFormat(String attributeType);

  /// No description provided for @usernameRequirements.
  ///
  /// In en, this message translates to:
  /// **'Username must only contain alphanumeric characters and symbols.'**
  String get usernameRequirements;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'{fieldTitle} (optional)'**
  String optional(String fieldTitle);

  /// No description provided for @passwordRequirementsPreamble.
  ///
  /// In en, this message translates to:
  /// **'Your password must include:'**
  String get passwordRequirementsPreamble;

  /// No description provided for @passwordRequirementsAtLeast.
  ///
  /// In en, this message translates to:
  /// **'at least {numCharacters, plural, =1{1{characterType} character} other{{numCharacters}{characterType} characters}}'**
  String passwordRequirementsAtLeast(int numCharacters, String characterType);

  /// No description provided for @passwordRequirementsCharacterType.
  ///
  /// In en, this message translates to:
  /// **'{characterType, select, requiresUppercase{uppercase} requiresLowercase{lowercase} requiresNumbers{number} requiresSymbols{symbol} other{}}'**
  String passwordRequirementsCharacterType(String characterType);

  /// No description provided for @codeSent.
  ///
  /// In en, this message translates to:
  /// **'A confirmation code has been sent to {destination}'**
  String codeSent(String destination);

  /// No description provided for @codeSentUnknown.
  ///
  /// In en, this message translates to:
  /// **'A confirmation code has been sent.'**
  String get codeSentUnknown;

  /// No description provided for @copySucceeded.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard!'**
  String get copySucceeded;

  /// No description provided for @copyFailed.
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard failed.'**
  String get copyFailed;

  /// No description provided for @confirmSignInCustomAuth.
  ///
  /// In en, this message translates to:
  /// **'Enter your sign in code\''**
  String get confirmSignInCustomAuth;

  /// No description provided for @continueSignInWithMfaSelection.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred Two-Factor Auth method'**
  String get continueSignInWithMfaSelection;

  /// No description provided for @continueSignInWithTotpSetup.
  ///
  /// In en, this message translates to:
  /// **'Enable Two-Factor Auth'**
  String get continueSignInWithTotpSetup;

  /// No description provided for @confirmSignInWithTotpMfaCode.
  ///
  /// In en, this message translates to:
  /// **'Enter your one-time passcode'**
  String get confirmSignInWithTotpMfaCode;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'it', 'ja', 'ko', 'pt', 'vi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'it': return AppLocalizationsIt();
    case 'ja': return AppLocalizationsJa();
    case 'ko': return AppLocalizationsKo();
    case 'pt': return AppLocalizationsPt();
    case 'vi': return AppLocalizationsVi();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
