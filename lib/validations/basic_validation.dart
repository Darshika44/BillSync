String? validateEmail(String? value) {
  if (value?.trim() == null || value!.trim().isEmpty) {
    return 'Please enter your email';
  }
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
  if (!emailRegex.hasMatch(value.trim())) {
    return 'Please enter a valid email address';
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

String? validateSignupPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number';
  }

  if (!value.contains(RegExp(r'[!@#\$%^&*()_+{}|:;<>,.?~\-]'))) {
    return 'Password must contain at least one symbol';
  }
  return null;
}

String? validateForNormalFeild({required String? value, required String? props}) {
  if (value == null || value.isEmpty) {
    return 'Please enter your ${props?.toLowerCase()}';
  }
  if ((props == "First name" || props == "Last name") && !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
    return '$props can only contain alphabets and numbers';
  }
  return null;
}

String? validateForMobileField(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }
  if (value.length < 10) {
    return "Please enter valid mobile number";
  }
  return null;
}

String? validateLogoField({required String? value, required String? props}) {
  if (value == null || value.isEmpty) {
    return 'Please upload your $props';
  }
  return null;
}

String? validateForNameField({required String? value, required String? props}) {
  // final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
  final RegExp nameRegExp = props == 'Last Name' ? RegExp(r'^[a-zA-Z]+$') : RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)?$');

  if (value == null || value.isEmpty) {
    return 'Please enter your $props';
  }
  if (!nameRegExp.hasMatch(value)) {
    return 'Invalid $props';
  }
  return null;
}

String? validateForLastNameField({required String? value, required String? props}) {
  // final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');

  if (value == null || value.isEmpty) {
    return 'Please enter your $props';
  }
  if (!nameRegExp.hasMatch(value)) {
    return 'Invalid $props';
  }
  return null;
}

String? validateForLastNameForNotMandatory({required String value, required String? props}) {
  // final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');

  if (!nameRegExp.hasMatch(value) && value.isNotEmpty) {
    return 'Invalid $props';
  }
  return null;
}

String? validationForAlphaNumeric({required String? value, required String? props}) {
  final RegExp nameRegExp = RegExp(r'^(?!\s*$)[a-zA-Z0-9- ]{1,20}$');

  if (value == null || value.isEmpty) {
    return 'Please enter your $props';
  }
  if (!nameRegExp.hasMatch(value)) {
    return 'Invalid $props';
  }
  return null;
}

String? validateForOraganizationNameField({required String? value, required String? props}) {
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z0-9\s]+$');

  if (value == null || value.isEmpty) {
    return 'Please enter your $props';
  }
  if (!nameRegExp.hasMatch(value)) {
    return 'Invalid $props';
  }
  return null;
}

String getOnlyNumber(String value) {
  RegExp regExp = RegExp(r'\D+');
  String numbersOnly = value.replaceAll(regExp, '');
  return numbersOnly;
}

String removeExtraSpaces(String input) {
  List<String> words = input.split(' ').where((word) => word.isNotEmpty).toList();
  String output = words.join(' ');
  return output;
}

String? validateForMobileNumberFeild({required String? value, required String? props}) {
  if (value == null || value.isEmpty) {
    return 'Please enter your $props';
  } else if (value.length < 10) {
    return "Enter Valid $props";
  }
  return null;
}

String? validateEmailNotMandatory(String? value) {
  if (value == null || value.isNotEmpty) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(value!)) {
      return 'Please enter a valid email address';
    }
  }
  return null;
}

String? isYouTubeVideoURL(String url) {
  if (url.isEmpty) {
    return null;
  }
  final RegExp regExp = RegExp(
    r'^https?:\/\/(?:www\.)?youtube\.com\/watch\?v=([a-zA-Z0-9_-]+)',
    caseSensitive: false,
  );
  final RegExp regExp2 = RegExp(
    r'^https:\/\/(?:www\.)?youtu\.be\/([\w-]+)(?:\?.*)?$',
    caseSensitive: false,
  );

  final RegExp shortsUrlRegex = RegExp(
    r'^https:\/\/(?:www\.)?youtube\.com\/(?:shorts\/)?([\w-]+)(?:\?.*)?$',
    caseSensitive: false,
  );

  final RegExp shortsUrlRegex2 = RegExp(
    r'^https:\/\/(?:www\.)?youtube\.com\/(?:(?:shorts\/)|(?:watch\?v=))?([\w-]+)(?:\?.*)?$',
    caseSensitive: false,
  );

  if (!regExp.hasMatch(url) && !regExp2.hasMatch(url) && !shortsUrlRegex.hasMatch(url) && !shortsUrlRegex2.hasMatch(url)) {
    return 'Please enter a valid Youtube video link';
  }
  return null;
}

String? validateFordropDown({required String? value, required String? props, required String? textfieldvalue}) {
  if (value == null || value.isEmpty && textfieldvalue == null || textfieldvalue!.isEmpty) {
    return 'Please Select $props';
  }
  return null;
}

String? validateGSTNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter GST number';
  }
  if (value.length != 15) {
    return 'GST number must be 15 characters long';
  }
  final gstRegExp = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
  if (!gstRegExp.hasMatch(value)) {
    return 'Invalid GST number format';
  }
  return null;
}

String? validateForNumberField({
  required String? value,
  required String? props,
  Function? callback,
}) {
  final RegExp numberRegExp = RegExp(r'^[0-9]+$');

  if (value == null || value.isEmpty) {
    if (callback != null) callback();
    return 'Please enter your $props';
  }
  if (!numberRegExp.hasMatch(value)) {
    if (callback != null) callback();
    return 'Invalid $props';
  }
  return null;
}

String? validateForDateField({required String? value, required String? props, Function? callback}) {
  final RegExp dateRegExp = RegExp(r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$');

  if (value == null || value.isEmpty) {
    if (callback != null) callback();
    return 'Please enter your $props';
  }
  if (!dateRegExp.hasMatch(value)) {
    if (callback != null) callback();
    return 'Invalid $props format. Please use yyyy-mm-dd.';
  }
  return null;
}

String? validateNotEmpty({required String? value, required String? props, Function? callback}) {
  if (value == null || value.isEmpty) {
    if (callback != null) callback();
    return 'Please enter your $props';
  }
  return null;
}
