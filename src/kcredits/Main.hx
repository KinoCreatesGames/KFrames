package kcredits;

import rm.Globals;
import rm.managers.SceneManager;

/**
 * A plugin for creating  custom Credits Scene.
 */
typedef KParams = {};

@:native('KCredits')
@:expose('KCredits')
class Main {
  public static var Params:KParams = null;

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) ->
      ~/<KCredits>/ig.match(plugin.description))[0];

    var params = plugin.parameters;
    Params = {};
  }

  public static function gotoCustomCredits() {
    SceneManager.push(KCustomCreditsScene);
  }
}