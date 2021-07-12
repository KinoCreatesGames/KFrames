package ktitle;

import macros.FnMacros;
import rm.Globals;

typedef KParams = {};

/**
 * A plugin for creating custom title screens.
 */
@:native('KTitle')
@:expose('KTitle')
class Main {
  public static var Params:KParams = null;

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) -> {
      return ~/<KTitle>/ig.match(plugin.description);
    })[0];

    // Run Macro for executing and create the custom version
    // of the MV class from our regular class.
    FnMacros.jsPatch(true, Scene_Title, KCustomTitleScene);
  }
}