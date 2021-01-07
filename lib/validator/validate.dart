import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:wooapp/widgets/loading.dart';

class Validate {
  static const String EMAIL_REGEX =
      "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})";
  static const String EMAIL_MSG_EMPTY = "Please enter your valid email.";
  static const String EMAIL_MSG_INVALID =
      "You have entered an invalid email address.";

  static const String MOBILE_REGEX = "^[+]?[0-9]{7,15}";
  static const String MOBILENUMBER_MSG_EMPTY =
      "Please enter your mobile number.";
  static const String MOBILENUMBER_MSG_INVALID =
      "You have entered an invalid mobile number.";

  static const String EMAIL_OR_MOBILE_MSG_EMPTY =
      "Please enter your valid email / mobile number.";

  static const String PASSWORD_MSG_EMPTY = "Please enter your password.";
  static const String PASSWORD_MSG_INVALID =
      "Your password can't start or end with a blank space.";
  static const String PASSWORD_MSG_INVALID_LENGTH =
      "You must be provide at least 6 to 30 characters for password.";

  static const String CONFIRM_PASSWORD_MSG_EMPTY =
      "Please enter your confirm password.";
  static const String CONFIRM_PASSWORD_MSG_INVALID =
      "Password and confirm password does not match.";

  static const String OTP_MSG_EMPTY = "Please enter your OTP.";
  static const String OTP_MSG_INVALID = "You have entered an invalid OTP.";

  static const String FIRST_NAME_MSG_EMPTY = "Please enter your first name.";
  static const String FIRST_NAME_MSG_INVALID =
      "Your first name can't start or end with a blank space.";
  static const String FIRST_NAME_MSG_INVALID_LENGTH =
      "First name should be 3 to 20 Alphabetic Characters only.";

  static const String LAST_NAME_MSG_EMPTY = "Please enter your last name.";
  static const String LAST_NAME_MSG_INVALID =
      "Your last name can't start or end with a blank space.";
  static const String LAST_NAME_MSG_INVALID_LENGTH =
      "Last name should be 3 to 20 Alphabetic Characters only.";

}

bool validEmailAddress(String emailAddress) {
  String email = emailAddress.trim().toString();
  if (email.length == 0) {

    return false;
  }
  return validEmailPattern(emailAddress);
}

bool validEmailPattern(String emailAddress) {
  String email = emailAddress.trim().toString();
  RegExp regExp = new RegExp(Validate.EMAIL_REGEX);
  if (!regExp.hasMatch(emailAddress)) {
    snackBar(Validate.EMAIL_MSG_INVALID);
    return false;
  }
  return true;
}

bool validMobileNumber(String mobile) {
  String mobileNumber = mobile.trim().toString();
  if (mobileNumber.length == 0) {
    snackBar(Validate.MOBILENUMBER_MSG_EMPTY);
    return false;
  }
  return validMobilePattern(mobile);
}

bool validMobilePattern(String mobile) {
  String mobileNumber = mobile.trim().toString();
  RegExp regExp = new RegExp(Validate.MOBILENUMBER_MSG_INVALID);
  if (!regExp.hasMatch(mobile)) {
    snackBar(Validate.MOBILENUMBER_MSG_INVALID);
    return false;
  }
  return true;
}

bool isValidString(String data) {
  return data != null && !data.isEmpty;
}
double getValidDecimalInDouble(String value) {
  if (!isValidString(value)) {
    return 0.0;
  }
  double netValue = double.parse(value.replaceAll(',', ''));
  assert(netValue is double);
  return netValue;
}

String getValidDecimal(String value) {
  if (!isValidString(value)) {
    return "0.00";
  }
  double netValue = double.parse(value.replaceAll(',', ''));
  assert(netValue is double);
  return getValidDecimalFormat(netValue);
}

bool validFirstName(String editText) {
  String firstName = editText.trim().toString();
  if (firstName.length == 0) {
    snackBar(Validate.FIRST_NAME_MSG_EMPTY);
    return false;
  }
  if (firstName.length < 3 || firstName.length > 30) {
    snackBar(Validate.FIRST_NAME_MSG_INVALID_LENGTH);
    return false;
  }
  return true;
}

bool validOtp(String otp, int length) {
  if (otp.length == 0) {
    snackBar(Validate.OTP_MSG_EMPTY);
    return false;
  }
  if (otp.length < length) {
    snackBar(Validate.OTP_MSG_INVALID);
    return false;
  }
  return true;
}

bool validLastName(String editText) {
  String lastName = editText.trim().toString();
  if (lastName.length == 0) {
    snackBar(Validate.LAST_NAME_MSG_EMPTY);
    return false;
  }
  if (lastName.length < 3 || lastName.length > 30) {
    snackBar(Validate.LAST_NAME_MSG_INVALID_LENGTH);
    return false;
  }
  return true;
}

String getValidDecimalFormat(double value) {
  return value.toStringAsFixed(2);
}
String getValidString(String amount){
  if(isValidString(amount) && amount!= ""){
    amount = parse(amount).documentElement.text.substring(1).trim();
    printLog("amount",amount);
    return amount;
  }return null;
}