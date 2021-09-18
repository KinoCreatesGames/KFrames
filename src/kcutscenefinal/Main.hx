package kcutscenefinal;

import rm.Globals;
import rm.managers.SceneManager;

typedef KParams = {};

@:native('KCutsceneFinal')
@:expose('KCutsceneFinal')
class Main {
  public static var Params:KParams = null;

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) ->
      ~/<KCustomFinal>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
    Params = {}
  }

  public static function gotoCustomScene() {
    SceneManager.push(KCustomFinal);
  }
}