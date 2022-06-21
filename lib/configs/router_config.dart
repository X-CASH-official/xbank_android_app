import 'package:framework/utils/router_manager.dart';
import 'package:x_bank/activitys/login_activity.dart';
import 'package:x_bank/activitys/main_activity.dart';
import 'package:x_bank/activitys/register_activity.dart';
import 'package:x_bank/activitys/splash_activity.dart';
import 'package:x_bank/activitys/transfer_details_activity.dart';

enum ActivityName {
  SplashActivity,
  MainActivity,
  LoginActivity,
  RegisterActivity,
  TransferDetailsActivity
}

class RouterConfig {
  static Map<ActivityName, ActivityBuilder> activityRoutes = {
    ActivityName.SplashActivity:
        ActivityBuilder(builderFunction: (bundle) => SplashActivity()),
    ActivityName.MainActivity:
        ActivityBuilder(builderFunction: (bundle) => MainActivity(bundle)),
    ActivityName.LoginActivity:
        ActivityBuilder(builderFunction: (bundle) => LoginActivity(bundle)),
    ActivityName.RegisterActivity:
        ActivityBuilder(builderFunction: (bundle) => RegisterActivity(bundle)),
    ActivityName.TransferDetailsActivity: ActivityBuilder(
        builderFunction: (bundle) => TransferDetailsActivity(bundle)),
  };
}
