// Conditional export: uses web stub on web, real implementation on mobile.
export 'auth_service_mobile.dart'
    if (dart.library.html) 'auth_service_web.dart';
