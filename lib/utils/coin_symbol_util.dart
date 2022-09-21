import 'package:framework/utils/shared_preferences_manager.dart';
import 'package:x_bank/configs/key_config.dart';

class CoinSymbolUtil {
  static const String coin_symbol_xcash = "XCASH";
  static const String coin_symbol_wxcash = "WXCASH";

  static Future<void> updateSelectCoinSymbol(String symbol) async {
    await SharedPreferencesManager()
        .putString(KeyConfig.coin_symbol_key, symbol);
  }

  static String getSelectCoinSymbol() {
    String? symbol =
        SharedPreferencesManager().getString(KeyConfig.coin_symbol_key);
    if (symbol == null) {
      symbol = coin_symbol_xcash;
    }
    return symbol;
  }
}
