package kinterpreter;

import utils.Fn;
import rm.Globals;
import core.Amaryllis.createEventEmitter;
import pixi.interaction.EventEmitter;

typedef KParams = {
  var waitTime:Int;
};

@:native('KCustomIntepreter')
@:expose('KCustomInterpreter')
class Main {
  public static var Params:KParams = null;
  public static var listener:EventEmitter = createEventEmitter();

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) ->
      ~/<KInterpreter>/ig.match(plugin.description))[0];
    var params = plugin.parameters;

    Params = {
      waitTime: Fn.parseIntJs(params['Wait Time'])
    }
  }

  /**
   * Creates a new interpreter with the Custom KInterpreter class.
   */
  public static function createInterpreter() {
    return new KInterpreter([]);
  }
}