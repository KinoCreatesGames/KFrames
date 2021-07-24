package kinterpreter;

import rm.Globals;
import core.Amaryllis.createEventEmitter;
import pixi.interaction.EventEmitter;

typedef KParams = {};

@:native('KCustomIntepreter')
@:expose('KCustomInterpreter')
class Main {
  public static var Params:KParams = null;
  public static var listener:EventEmitter = createEventEmitter();

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) ->
      ~/<KInterpreter>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
  }

  /**
   * Creates a new interpreter with the Custom KInterpreter class.
   */
  public static function createInterpreter() {
    return new KInterpreter([]);
  }
}