class UrlContainer {
  static const String domainUrl = 'https://api-uat.pintel.biz';
  static const String baseUrl = '$domainUrl/api/backend/v1/';
  static const String downloadUrl = '$domainUrl/download/file';
  static const String uploadPath = 'uploads';
  // static const String ticketAttachmentUrl =
  //     '$domainUrl/download/preview_image?path=$uploadPath/ticket_attachments/';

  static RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
// {email: tip.ket@codeclans.asia, password: tip.ket@codeclans.asia}
  // Authentication
  static const String loginUrl = 'auth/login';
  static const String logoutUrl = 'auth/logout';
  static const String profileUrl = 'auth/profile';
  static const String updateProfileUrl='auth/update-profile';
  static const String updatePasswordUrl='auth/change-password';
  // static const String forgotPasswordUrl = 'auth/forgot-password';

  // Pages
  static const String dashboardUrl = 'mini-pos/dashboard';
  static const String productUrl='mini-pos/product';
  static const String cartUrl='mini-pos/cart';
  static const String customersUrl = 'customers';

  // upload file
  static const String uploadImageUrl='file/upload/7';

  // Download URLs
  static const String leadAttachmentUrl = '$downloadUrl/lead_attachment';
  static const String salesAttachmentUrl = '$downloadUrl/sales_attachment';
}
