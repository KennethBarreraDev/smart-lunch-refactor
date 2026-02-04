import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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
    Locale('es')
  ];

  /// Label for homePageStack
  ///
  /// In en, this message translates to:
  /// **'balance'**
  String get homePageStack;

  /// Label for email input
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Label for password input
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Label for login error
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get login_error;

  /// Label for reset password button
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get reset_password;

  /// Label for terms and conditions button
  ///
  /// In en, this message translates to:
  /// **'Terms and\nconditions'**
  String get terms_and_conditions;

  /// Label for political privacy button
  ///
  /// In en, this message translates to:
  /// **'Political\nprivacity'**
  String get political_privacy;

  /// Label for contact button
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// Label for password recover section
  ///
  /// In en, this message translates to:
  /// **'Password recovery'**
  String get password_recover;

  /// Label for send button
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send_button;

  /// Label for go back button
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get go_back_button;

  /// Label for sale button
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get sale;

  /// Label for presale_button
  ///
  /// In en, this message translates to:
  /// **'Presale'**
  String get presale;

  /// No description provided for @today_purchases.
  ///
  /// In en, this message translates to:
  /// **'Today\'s shopping history'**
  String get today_purchases;

  /// Label for presales option
  ///
  /// In en, this message translates to:
  /// **'Presales'**
  String get presales;

  /// Label for home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Label for top up button
  ///
  /// In en, this message translates to:
  /// **'Top up'**
  String get top_up;

  /// Label for menu drawer option
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// Label for tutor role
  ///
  /// In en, this message translates to:
  /// **'Tutor'**
  String get tutor;

  /// Label for teacher role
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// Label for student role
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// Label for children option
  ///
  /// In en, this message translates to:
  /// **'children'**
  String get children;

  /// Label for history option
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// Label for settings option
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for log_out
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get log_out;

  /// Label for delivery date title
  ///
  /// In en, this message translates to:
  /// **'Delivery date'**
  String get delivery_date;

  /// Label for presale canceled message
  ///
  /// In en, this message translates to:
  /// **'Presale canceled succesfully!'**
  String get presale_canceled;

  /// Label for close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close_button;

  /// Label for cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_button;

  /// Label for register_button
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register_button;

  /// Label for confirm_button
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm_button;

  /// Label for select_button
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select_button;

  /// Label for add_card
  ///
  /// In en, this message translates to:
  /// **'Add card'**
  String get add_card;

  /// Label for cancel presale error message
  ///
  /// In en, this message translates to:
  /// **'Error cancelling\npresale'**
  String get cancel_presale_error;

  /// Label for product message
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product_message;

  /// Label for amount message
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount_message;

  /// Label for price message
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price_message;

  /// Label for select delivery date message
  ///
  /// In en, this message translates to:
  /// **'Select a delivery date'**
  String get select_delivery_date;

  /// Label for total price message
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total_price;

  /// Label for view_cart
  ///
  /// In en, this message translates to:
  /// **'Shopping cart'**
  String get view_cart;

  /// Label for order information
  ///
  /// In en, this message translates to:
  /// **'Order information'**
  String get order_information;

  /// No description provided for @order_message.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order_message;

  /// Label for deliver to
  ///
  /// In en, this message translates to:
  /// **'Deliver to'**
  String get deliver_to;

  /// Label for available_balance
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get available_balance;

  /// Label for sale information message
  ///
  /// In en, this message translates to:
  /// **'This purchase must be collected today; otherwise, it will expire.'**
  String get today_sale_information;

  /// Label for deliver in message
  ///
  /// In en, this message translates to:
  /// **'Deliver in'**
  String get deliver_in_time;

  /// Label for general details message
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// Label for daily_limit_warning
  ///
  /// In en, this message translates to:
  /// **'The student has a daily balance limit of'**
  String get daily_limit_warning;

  /// Label for wait message
  ///
  /// In en, this message translates to:
  /// **'Please wait!'**
  String get please_wait;

  /// Label for maximun products warning message
  ///
  /// In en, this message translates to:
  /// **'You can only select'**
  String get maximun_products_warning_p1;

  /// Label for maximun products warning message
  ///
  /// In en, this message translates to:
  /// **'items of this product'**
  String get maximun_products_warning_p2;

  /// Label for purchase_exceed_balance_message
  ///
  /// In en, this message translates to:
  /// **'This purchase exceeds your current balance'**
  String get purchase_exceed_balance_message;

  /// Label for must_select_pickup_date
  ///
  /// In en, this message translates to:
  /// **'You must select the pickup time'**
  String get must_select_pickup_date;

  /// Label for comments_message
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments_message;

  /// Label for select_payment_method
  ///
  /// In en, this message translates to:
  /// **'Select a payment method'**
  String get select_payment_method;

  /// Label for buy_now
  ///
  /// In en, this message translates to:
  /// **'Buy it now'**
  String get buy_now;

  /// Label for order_completed
  ///
  /// In en, this message translates to:
  /// **'Order completed!'**
  String get order_completed;

  /// No description provided for @purchase_successfully_mesage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your purchase'**
  String get purchase_successfully_mesage;

  /// Label for the_order
  ///
  /// In en, this message translates to:
  /// **'Order '**
  String get the_order;

  /// Label for will_be_ready_message
  ///
  /// In en, this message translates to:
  /// **' will be ready for '**
  String get will_be_ready_message;

  /// Label for on_message
  ///
  /// In en, this message translates to:
  /// **' on '**
  String get on_message;

  /// Label for folio_message
  ///
  /// In en, this message translates to:
  /// **'Folio'**
  String get folio_message;

  /// Label for date
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Label for total_items
  ///
  /// In en, this message translates to:
  /// **'Total items'**
  String get total_items;

  /// Label for subtotal
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// Label for purchase_date
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get purchase_date;

  /// Label for active_message
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active_message;

  /// Label for inactive_message
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive_message;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration: '**
  String get registration;

  /// Label for student_information
  ///
  /// In en, this message translates to:
  /// **'Student information'**
  String get student_information;

  /// Label for student_management
  ///
  /// In en, this message translates to:
  /// **'Management'**
  String get student_management;

  /// Label for user_name
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get user_name;

  /// Label for user_lastname
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get user_lastname;

  /// Label for phone_numer
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_numer;

  /// Label for save_button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save_button;

  /// Label for daily_limit
  ///
  /// In en, this message translates to:
  /// **'Daily limit'**
  String get daily_limit;

  /// Label for unlimited_message
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get unlimited_message;

  /// Label for allergies_message
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get allergies_message;

  /// Label for none_message
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none_message;

  /// Label for forbidden_products
  ///
  /// In en, this message translates to:
  /// **'Forbidden products'**
  String get forbidden_products;

  /// Label for products
  ///
  /// In en, this message translates to:
  /// **'products'**
  String get products;

  /// Label for limited_products
  ///
  /// In en, this message translates to:
  /// **'Limited products'**
  String get limited_products;

  /// Label for enter_amount
  ///
  /// In en, this message translates to:
  /// **'Enter the amount'**
  String get enter_amount;

  /// Label for common_allergies
  ///
  /// In en, this message translates to:
  /// **'Common allergies'**
  String get common_allergies;

  /// Label for other_allergies
  ///
  /// In en, this message translates to:
  /// **'Other allergies'**
  String get other_allergies;

  /// Label for allowed_message
  ///
  /// In en, this message translates to:
  /// **'allowed'**
  String get allowed_message;

  /// Label for forbidden_message
  ///
  /// In en, this message translates to:
  /// **'Forbidden'**
  String get forbidden_message;

  /// Label for limit_message
  ///
  /// In en, this message translates to:
  /// **'Limit'**
  String get limit_message;

  /// Label for allow_notifications
  ///
  /// In en, this message translates to:
  /// **'Allow notifications'**
  String get allow_notifications;

  /// Label for change_password
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get change_password;

  /// Label for family
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family_message;

  /// Label for account_message
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account_message;

  /// Label for current_password
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get current_password;

  /// Label for new_password
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get new_password;

  /// Label for confirm_password
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password;

  /// Label for update_password
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get update_password;

  /// Label for current_balance
  ///
  /// In en, this message translates to:
  /// **'Current balance'**
  String get current_balance;

  /// Label for another_amount
  ///
  /// In en, this message translates to:
  /// **'Another amount'**
  String get another_amount;

  /// Label for suggested_options
  ///
  /// In en, this message translates to:
  /// **'Suggested options'**
  String get suggested_options;

  /// Label for minimum_recharge_amount
  ///
  /// In en, this message translates to:
  /// **'The minimum recharge amount is'**
  String get minimum_recharge_amount;

  /// Label for amount_not_valid
  ///
  /// In en, this message translates to:
  /// **'The entered amount is not valid.'**
  String get amount_not_valid;

  /// Label for payment_method
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get payment_method;

  /// Label for card_message
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card_message;

  /// Label for card_owner
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get card_owner;

  /// Label for register_card
  ///
  /// In en, this message translates to:
  /// **'Register new card'**
  String get register_card;

  /// Label for update_card
  ///
  /// In en, this message translates to:
  /// **'Update card'**
  String get update_card;

  /// Label for successful_recharge
  ///
  /// In en, this message translates to:
  /// **'Successful recharge'**
  String get successful_recharge;

  /// Label for failed_recharge
  ///
  /// In en, this message translates to:
  /// **'Failed recharge'**
  String get failed_recharge;

  /// Label for transaction_id
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transaction_id;

  /// Label for openpay_id
  ///
  /// In en, this message translates to:
  /// **'Openpay ID'**
  String get openpay_id;

  /// Label for cards_message
  ///
  /// In en, this message translates to:
  /// **'cards'**
  String get cards_message;

  /// Label for crendential_message
  ///
  /// In en, this message translates to:
  /// **'Credential'**
  String get crendential_message;

  /// Label for view_today_purchases
  ///
  /// In en, this message translates to:
  /// **'View today\'s purchases'**
  String get view_today_purchases;

  /// Label for presale_description
  ///
  /// In en, this message translates to:
  /// **'Buy today and schedule your delivery\nfor another day'**
  String get presale_description;

  /// Label for sale_description
  ///
  /// In en, this message translates to:
  /// **'Buy and pick up your order today'**
  String get sale_description;

  /// Label for view_menu
  ///
  /// In en, this message translates to:
  /// **'View menu'**
  String get view_menu;

  /// Label for choose_card
  ///
  /// In en, this message translates to:
  /// **'Choose card'**
  String get choose_card;

  /// Label for digital_card
  ///
  /// In en, this message translates to:
  /// **'Digital card'**
  String get digital_card;

  /// Label for birth_date_message
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get birth_date_message;

  /// Label for qr_description
  ///
  /// In en, this message translates to:
  /// **'Use this QR code to receive your purchases at your cafeteria'**
  String get qr_description;

  /// Label for remove_card
  ///
  /// In en, this message translates to:
  /// **'Remove card'**
  String get remove_card;

  /// Label for remove_card_warning
  ///
  /// In en, this message translates to:
  /// **'Do you wish to remove the card ending in'**
  String get remove_card_warning;

  /// Label for credit_card
  ///
  /// In en, this message translates to:
  /// **'Credit cards'**
  String get credit_card;

  /// Label for debit_cards
  ///
  /// In en, this message translates to:
  /// **'Debit cards'**
  String get debit_cards;

  /// Label for card_number
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get card_number;

  /// Label for owner_full_name
  ///
  /// In en, this message translates to:
  /// **'Owner full name'**
  String get owner_full_name;

  /// Label for card_cvv
  ///
  /// In en, this message translates to:
  /// **'Card CVV'**
  String get card_cvv;

  /// No description provided for @updated_allergies_successfully.
  ///
  /// In en, this message translates to:
  /// **'Allergies updated successfully'**
  String get updated_allergies_successfully;

  /// Label for updated_allergies_error
  ///
  /// In en, this message translates to:
  /// **'Error updating allergies, please try again later.'**
  String get updated_allergies_error;

  /// Label for balance_body_updated_succesfully
  ///
  /// In en, this message translates to:
  /// **'Balance limit updated successfully'**
  String get balance_body_updated_succesfully;

  /// Label for balace_body_updated_error
  ///
  /// In en, this message translates to:
  /// **'Error updating the limit, please try again later'**
  String get balace_body_updated_error;

  /// Label for limited_products_succesfully
  ///
  /// In en, this message translates to:
  /// **'Limited products updated successfully.'**
  String get limited_products_succesfully;

  /// Label for limited_products_error
  ///
  /// In en, this message translates to:
  /// **'Error updating limited products, please try again later.'**
  String get limited_products_error;

  /// Label for forbidden_products_succesfully
  ///
  /// In en, this message translates to:
  /// **'Prohibited products updated successfully.'**
  String get forbidden_products_succesfully;

  /// Label for forbidden_products_error
  ///
  /// In en, this message translates to:
  /// **'Error updating forbidden products, please try again later.'**
  String get forbidden_products_error;

  /// Label for register_card_succesfull
  ///
  /// In en, this message translates to:
  /// **'Card successfully registered.'**
  String get register_card_succesfull;

  /// Label for verify_information
  ///
  /// In en, this message translates to:
  /// **'Please verify your information.'**
  String get verify_information;

  /// Label for error_registering_card
  ///
  /// In en, this message translates to:
  /// **'Error registering card, please try again later.'**
  String get error_registering_card;

  /// Label for selected_card_succesfully
  ///
  /// In en, this message translates to:
  /// **'Card selected successfully.'**
  String get selected_card_succesfully;

  /// No description provided for @error_selecting_card.
  ///
  /// In en, this message translates to:
  /// **'Error selecting, please try again later.'**
  String get error_selecting_card;

  /// Label for try_again_later
  ///
  /// In en, this message translates to:
  /// **'Error, please try again later'**
  String get try_again_later;

  /// Label for recharge_error
  ///
  /// In en, this message translates to:
  /// **'Error processing the recharge, please try again later.'**
  String get recharge_error;

  /// Label for delete_card_successfully
  ///
  /// In en, this message translates to:
  /// **'Card successfully removed'**
  String get delete_card_successfully;

  /// Label for removing_card_error
  ///
  /// In en, this message translates to:
  /// **'Error removing card, please try again later'**
  String get removing_card_error;

  /// Label for support_message
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support_message;

  /// No description provided for @succesfully_updated_card.
  ///
  /// In en, this message translates to:
  /// **'Card update successfully'**
  String get succesfully_updated_card;

  /// Label for updated_profile_succesfully
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get updated_profile_succesfully;

  /// Label for error_updating_profile
  ///
  /// In en, this message translates to:
  /// **'Error updating profile'**
  String get error_updating_profile;

  /// No description provided for @cvv_error.
  ///
  /// In en, this message translates to:
  /// **'CVV must be at least 3 digits long'**
  String get cvv_error;

  /// Label for user_message
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user_message;

  /// Label for current_debt
  ///
  /// In en, this message translates to:
  /// **'Current debt'**
  String get current_debt;

  /// Label for total_debt
  ///
  /// In en, this message translates to:
  /// **'Total debt'**
  String get total_debt;

  /// Label for pay_debt_explanation
  ///
  /// In en, this message translates to:
  /// **'To cover the debt, you must make a recharge of at least the total amount of the debt'**
  String get pay_debt_explanation;

  /// Label for sale_type
  ///
  /// In en, this message translates to:
  /// **'Sale type'**
  String get sale_type;

  /// Label for platfotm_message
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get platfotm_message;

  /// Label for time
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// Label for new_available_version
  ///
  /// In en, this message translates to:
  /// **'New version available'**
  String get new_available_version;

  /// Label for app_benefits
  ///
  /// In en, this message translates to:
  /// **'Please update the app to the latest version to continue enjoying the benefits.'**
  String get app_benefits;

  /// Label for update_message
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update_message;

  /// Label for missing_smart_id
  ///
  /// In en, this message translates to:
  /// **'You do not have a SMART ID. Please request one at your cafeteria'**
  String get missing_smart_id;

  /// Label for place_order
  ///
  /// In en, this message translates to:
  /// **'Place your order'**
  String get place_order;

  /// Label for password_not_match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get password_not_match;

  /// Label for check_email
  ///
  /// In en, this message translates to:
  /// **'Please, check your email'**
  String get check_email;

  /// Label for send_email_message
  ///
  /// In en, this message translates to:
  /// **'We have sent a recovery email to '**
  String get send_email_message;

  /// Label for click_link
  ///
  /// In en, this message translates to:
  /// **' click the link to reset your password'**
  String get click_link;

  /// Label for note
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// Label for check_spam_message
  ///
  /// In en, this message translates to:
  /// **'If you don\'t see the email, please check your spam folder'**
  String get check_spam_message;

  /// Label for password_updated
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get password_updated;

  /// Label for wrong_current_password
  ///
  /// In en, this message translates to:
  /// **'The entered password is incorrect'**
  String get wrong_current_password;

  /// Label for description_message
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description_message;

  /// Label for ingredients
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// Label for register_payment_method
  ///
  /// In en, this message translates to:
  /// **'Please register a payment method'**
  String get register_payment_method;

  /// Label for finish_purchase
  ///
  /// In en, this message translates to:
  /// **'Finish purchase'**
  String get finish_purchase;

  /// No description provided for @languaje_message.
  ///
  /// In en, this message translates to:
  /// **'Languaje'**
  String get languaje_message;

  /// Label for searh_product
  ///
  /// In en, this message translates to:
  /// **'Search product'**
  String get searh_product;

  /// Label for verifying_message
  ///
  /// In en, this message translates to:
  /// **'verifying'**
  String get verifying_message;

  /// Label for loading_message
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading_message;

  /// Label for succes_sale
  ///
  /// In en, this message translates to:
  /// **'order successfully placed'**
  String get succes_sale;

  /// Label for error_sale
  ///
  /// In en, this message translates to:
  /// **'error placing order'**
  String get error_sale;

  /// Label for continuePayment
  ///
  /// In en, this message translates to:
  /// **'Continue to payment'**
  String get continuePayment;

  /// Label for commisionFee
  ///
  /// In en, this message translates to:
  /// **'commission fee'**
  String get commisionFee;

  /// Label for orAlso
  ///
  /// In en, this message translates to:
  /// **'Or also'**
  String get orAlso;

  /// Label for pay_with
  ///
  /// In en, this message translates to:
  /// **'Pay with'**
  String get pay_with;

  /// Label for need_help_question
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get need_help_question;

  /// Label for pending_membership
  ///
  /// In en, this message translates to:
  /// **'Pending membership payment'**
  String get pending_membership;

  /// No description provided for @pending_membership_payment.
  ///
  /// In en, this message translates to:
  /// **'We have detected an expired or pending membership on your account. Please pay now to continue making purchases from the app.'**
  String get pending_membership_payment;

  /// Label for pay_now
  ///
  /// In en, this message translates to:
  /// **'Pay now'**
  String get pay_now;

  /// Label for membership_payment
  ///
  /// In en, this message translates to:
  /// **'Membership payment'**
  String get membership_payment;

  /// No description provided for @pay_membership_legend.
  ///
  /// In en, this message translates to:
  /// **'Make the payment to continue making purchases from the app and enjoy all the benefits.'**
  String get pay_membership_legend;

  /// Label for canceled_message
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled_message;

  /// Label for payment_by_guardian
  ///
  /// In en, this message translates to:
  /// **'(The payment must be made by your guardian)'**
  String get payment_by_guardian;

  /// Label for multisale
  ///
  /// In en, this message translates to:
  /// **'Multisale'**
  String get multisale;

  /// Label for select_student
  ///
  /// In en, this message translates to:
  /// **'Select a student'**
  String get select_student;

  /// Label for information_text
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information_text;

  /// Label for no_order
  ///
  /// In en, this message translates to:
  /// **'No orders'**
  String get no_order;

  /// Label for make_one_order
  ///
  /// In en, this message translates to:
  /// **'Place at least one order'**
  String get make_one_order;

  /// No description provided for @add_comment.
  ///
  /// In en, this message translates to:
  /// **'Add coment'**
  String get add_comment;

  /// Label for pay_with_balance
  ///
  /// In en, this message translates to:
  /// **'Pay with balance'**
  String get pay_with_balance;

  /// Label for membership_expiration
  ///
  /// In en, this message translates to:
  /// **'Expiration'**
  String get membership_expiration;

  /// Label for summary_sale_message
  ///
  /// In en, this message translates to:
  /// **'Sale details'**
  String get summary_sale_message;

  /// Label for delivery_date_message
  ///
  /// In en, this message translates to:
  /// **'Delivery date'**
  String get delivery_date_message;

  /// No description provided for @multisale_description.
  ///
  /// In en, this message translates to:
  /// **'Schedule your purchases for multiple days.'**
  String get multisale_description;

  /// No description provided for @disccount_message.
  ///
  /// In en, this message translates to:
  /// **'Disccount'**
  String get disccount_message;

  /// Label for membership_message
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get membership_message;

  /// Label for bank_fee
  ///
  /// In en, this message translates to:
  /// **'Bank fee'**
  String get bank_fee;

  /// Label for payment_completed
  ///
  /// In en, this message translates to:
  /// **'Payment completed'**
  String get payment_completed;

  /// Label for succes_membership_payment
  ///
  /// In en, this message translates to:
  /// **'Successful membership payment'**
  String get succes_membership_payment;

  /// Label for error_membership_payment
  ///
  /// In en, this message translates to:
  /// **'Error paying membership'**
  String get error_membership_payment;

  /// Label for cafeteria_text
  ///
  /// In en, this message translates to:
  /// **'Cafeteria'**
  String get cafeteria_text;
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
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
