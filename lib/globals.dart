import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  // debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  // debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  // debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

// class Globals {
//   static double screenHeight = 0;
//   static double screenWidth = 0;
//   static double designHeight = 844;
//   static double designWidth = 390;

// // otp page
//   static double otpBoxDimension = 0;
//   static double otpBoxTextSize = 0;
//   static double otpTitleSize = 0;
//   static double otpBackIconSize = 0;
//   static double otpmainPaddingSpace = 0;
//   static double otpverificationTextSize = 0;
//   static double otpverificationTextBottomPadding = 0;
//   static double otpEnterCodeTextSize = 0;
//   static double otpPinputTopBottomPadding = 0;

// // registration page
//   static double registrationTitleSize = 0;
//   static double registrationBackIconSize = 0;
//   static double registrationMainPaddingSpace = 0;
//   static double registrationTopTermsandPrivacyPadding = 0;
//   static double registrationLeftTermsandPrivacyPadding = 0;
//   static double registrationBottomTermsandPrivacyPadding = 0;
//   static double registrationTextFiledPadding = 0;
//   static double registrationAllInputsContainerWidth = 0;
//   static double registrationAllInputsContainerHeight = 0;
//   static double registrationTextFieldHeight = 0;
//   static double registrationTextFieldWidth = 0;
//   static double registrationTextFieldIconSize = 0;
//   static double registrationHintTextSize = 0;
//   static double registrationTermsAndPrivacyTextSize = 0;
//   static double registrationSubmitButtonHeight = 0;
//   static double registrationSubmitButtonWidth = 0;
//   static double registrationCheckBoxDimension = 0;
//   static double registrationSubmitButtonTextSize = 0;
//   static double registrationAccountExistTextSize = 0;
//   static double registrationLoginTopPadding = 0;
// }

