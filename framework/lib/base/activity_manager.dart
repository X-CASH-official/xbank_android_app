/**
 * @author snakeway
 * @description:
 * @date :2021/3/23
 */
import 'base_activity.dart';

class ActivityManager {
  final List<BaseActivityState> _activityList = [];

  static ActivityManager? _activityManager;

  ActivityManager._internal();

  factory ActivityManager() => _activityManager ??= ActivityManager._internal();

  List<BaseActivityState> get activityList => _activityList;

  void addActivity(BaseActivityState baseActivityState) {
    _activityList.add(baseActivityState);
  }

  void removeActivity(BaseActivityState baseActivityState) {
    _activityList.remove(baseActivityState);
  }

  bool isTopActivity(BaseActivityState baseActivityState) {
    bool result = false;
    if (_activityList.length > 0 &&
        baseActivityState == _activityList[_activityList.length - 1]) {
      result = true;
    }
    return result;
  }

  BaseActivityState? getTopActivityState() {
    List<BaseActivityState> activityList = ActivityManager().activityList;
    if (activityList.length != 0) {
      return activityList[activityList.length - 1];
    }
    return null;
  }

  T? getTargetActivity<T extends BaseActivityState>() {
    List<BaseActivityState> baseActivityStates = ActivityManager().activityList;
    T? targetActivity;
    baseActivityStates.forEach((baseActivityState) {
      if (baseActivityState is T) {
        targetActivity = baseActivityState;
      }
    });
    return targetActivity;
  }
}
