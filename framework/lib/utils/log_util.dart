/**
 * @author snakeway
 * @description:
 * @date :2021/3/23
 */
class LogUtil {
  static const String _TAG_DEF = "###LogUtil###";
  static String TAG = _TAG_DEF;
  static bool DEBUG = true;

  static void init({bool isDebug = false, String tag = _TAG_DEF}) {
    DEBUG = isDebug;
    TAG = tag;
  }

  static void e(Object object, {String? tag}) {
    if (DEBUG) {
      _printLog(tag, '  e  ', object);
    }
  }

  static void v(Object object, {String? tag}) {
    if (DEBUG) {
      _printLog(tag, '  v  ', object);
    }
  }

  static void _printLog(String? tag, String stag, Object object) {
    String da = object.toString();
    String _tag = (tag == null || tag.isEmpty) ? TAG : tag;
    while (da.isNotEmpty) {
      if (da.length > 2048) {
        print("$_tag $stag ${da.substring(0, 2048)}");
        da = da.substring(2048, da.length);
      } else {
        print("$_tag $stag $da");
        da = "";
      }
    }
  }
}
