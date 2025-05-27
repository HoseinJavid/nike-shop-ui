import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

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
    Locale('en'),
    Locale('fa')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Nike'**
  String get appTitle;

  /// Welcome message for the user
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomeMessage;

  /// Text for the login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// Text for the logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// User name button
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get userNameButtom;

  /// Password button
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordButtom;

  /// Forget password button
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgetPasswordButtom;

  /// Description login screen
  ///
  /// In en, this message translates to:
  /// **'Enter your account information'**
  String get discriptioinLoginScreen;

  /// Home button
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeButtom;

  /// Shopping cart button
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get shoppongCardButtom;

  /// User information button
  ///
  /// In en, this message translates to:
  /// **'User Information'**
  String get userInformationButtom;

  /// Add to shopping cart button
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToShoppingCardBtm;

  /// Payment button
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get paymentBtn;

  /// Search text
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchText;

  /// Show all button
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get showAllItem;

  /// The latest text
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get theLatestText;

  /// The cheapest text
  ///
  /// In en, this message translates to:
  /// **'Cheapest'**
  String get theCheapestText;

  /// The most expensive text
  ///
  /// In en, this message translates to:
  /// **'Most Expensive'**
  String get theMostExpensiveText;

  /// Sorting button
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortingBtm;

  /// Sport shoes text
  ///
  /// In en, this message translates to:
  /// **'Sport Shoes'**
  String get sportShoesText;

  /// User comment text
  ///
  /// In en, this message translates to:
  /// **'User Comments'**
  String get userCommentText;

  /// Post comment text
  ///
  /// In en, this message translates to:
  /// **'Post Comment'**
  String get postCommentText;

  /// Remove from shopping cart
  ///
  /// In en, this message translates to:
  /// **'Remove from Cart'**
  String get removeFromShoppingCard;

  /// Detail shopping cart
  ///
  /// In en, this message translates to:
  /// **'Purchase Details'**
  String get detailShoppingCart;

  /// Total buy amount
  ///
  /// In en, this message translates to:
  /// **'Total Purchase Amount'**
  String get totalBuyAmount;

  /// Select recipient and payment method
  ///
  /// In en, this message translates to:
  /// **'Select Recipient and Payment Method'**
  String get selectRecipientAndPaymentMethod;

  /// Full name
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Postal code
  ///
  /// In en, this message translates to:
  /// **'Postal Code'**
  String get postalCode;

  /// Contact number
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contactNumber;

  /// Delivery address
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// Cash on delivery
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// Online payment
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get onlinePayment;

  /// Payment receipt
  ///
  /// In en, this message translates to:
  /// **'Payment Receipt'**
  String get paymentReceipt;

  /// Payment successful
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessful;

  /// Order status
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// Amount
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Order history
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistory;

  /// Return to home page
  ///
  /// In en, this message translates to:
  /// **'Return to Home Page'**
  String get returnToHomePage;

  /// Profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Wishlist
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlist;

  /// Shipping cost
  ///
  /// In en, this message translates to:
  /// **'Shipping Cost'**
  String get shippingCost;

  /// Payable amount
  ///
  /// In en, this message translates to:
  /// **'Payable Amount'**
  String get payableAmount;

  /// Network error
  ///
  /// In en, this message translates to:
  /// **'network error'**
  String get netWorkError;

  /// unknown error
  ///
  /// In en, this message translates to:
  /// **'unknown error'**
  String get unknownError;

  /// The currency
  ///
  /// In en, this message translates to:
  /// **'Toman'**
  String get theCurrency;

  /// The popular
  ///
  /// In en, this message translates to:
  /// **'popular'**
  String get thePopular;
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
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
