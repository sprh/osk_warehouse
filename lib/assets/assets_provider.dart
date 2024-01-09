class AssetsProvider {
  AssetsProvider._();

  static const _svgPath = 'assets/svg';
  static const _svgIconPath = '$_svgPath/icons';
  static const _svgServiceIconPath = '$_svgPath/service_icons';
  static const _svgImagePath = '$_svgPath/images';

  // icons
  static const notification = '$_svgIconPath/notification.svg';
  static const setting = '$_svgIconPath/setting.svg';

  // images
  static const splash = '$_svgImagePath/splash_screen.svg';
  static const welcomeHeader = '$_svgImagePath/welcome_header.svg';
  static const loginPageHeader = '$_svgImagePath/login_page_header.svg';

  // service icons
  static const createRequest = '$_svgServiceIconPath/create_request.svg';
  static const products = '$_svgServiceIconPath/products.svg';
  static const report = '$_svgServiceIconPath/report.svg';
  static const request = '$_svgServiceIconPath/request.svg';
  static const warehouse = '$_svgServiceIconPath/warehouse.svg';
  static const worker = '$_svgServiceIconPath/worker.svg';
}
