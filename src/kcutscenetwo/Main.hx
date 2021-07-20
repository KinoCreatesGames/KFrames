package kcutscenetwo;

import rm.Globals;
import rm.managers.SceneManager;

typedef KParams = {};

@:native('KCutsceneTwo')
@:expose('KCutsceneTwo')
class Main {
  public static var Params:KParams = null;

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) ->
      ~/<KCustomSTwo>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
    Params = {}
  }

  public static function gotoCustomScene() {
    SceneManager.push(KCustomCutsceneTwo);
  }
}