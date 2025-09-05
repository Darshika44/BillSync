class ServiceUrl {
  // static const baseUrl = "http://82.25.105.96:3233";
  static const baseUrl = "https://5sgztrwd-3001.inc1.devtunnels.ms";


  //auth
  static const singupUrl = "$baseUrl/v1/auth/registration";
  static const loginUrl = "$baseUrl/v1/auth/login";
  static const forgetPasswordUrl = "$baseUrl/v1/auth/send-resend-otp";
  static const otpVerifyUrl = "$baseUrl/v1/auth/verify-otp";
  static const changePasswordUrl = "$baseUrl/v1/auth/change-password";

  //dashboard urls
  static const getDashboardData = "$baseUrl/v1/vendor";

  // invoices
  static const getAllInvoicesUrl = "$baseUrl/v1/vendor/get-all-invoice";
  static const createInvoiceUrl = "$baseUrl/v1/vendor/create-invoice";
  static const downloadInvoiceUrl = "$baseUrl/v1/vendor/download-invoice";

  // inventory
  static const getAllInventoryUrl = "$baseUrl/v1/vendor/get-all-categories";
  static const getInventoryHistoryUrl = "$baseUrl/v1/vendor/get-history";
  static const addInventoryUrl = "$baseUrl/v1/vendor/add-inventory";

  //vendors`
  static const getAllVendorsListUrl = "$baseUrl/v1/admin/get-all-vendors";
  static const getVendorDetailstUrl = "$baseUrl/v1/admin/get-vendor";
  static const updateVendorStatusUrl = "$baseUrl/v1/admin/accept-reject";

  //profile
  static const getUserDetailsUrl = "$baseUrl/v1/auth/current-user";
  static const updateUserProfileUrl = "$baseUrl/v1/auth/update-profile";
  static const getTermsAndConditionsUrl = "$baseUrl/v1/setting/terms-condition";
  static const updateTermsAndConditionsUrl = "$baseUrl/v1/setting/terms-condition";
  static const createLogoUrl = "$baseUrl/v1/setting/create-logo";
  static const getLogoUrl = "$baseUrl/v1/setting/get-logo";
  static const updateLogoUrl = "$baseUrl/v1/setting/update-logo";

}
