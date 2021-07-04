package kdinodata;

import MacroTools.Dino;
import MacroTools.createDinoData;
import rm.Globals;
import haxe.DynamicAccess;
import core.Amaryllis.createEventEmitter;
import pixi.interaction.EventEmitter;

typedef KParams = {};

@:native('KCDino')
@:expose('KCDino')
class Main {
  public static var Params:KParams = null;
  public static var listener:EventEmitter = createEventEmitter();
  public static var Data:Array<Dino> = null;

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) ->
      ~/<KCDinoData>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
    Data = createDinoData('./assets/dinosaurs.json');
  }

  public static function randomFact() {
    var dino:Dino = Data[Math.floor(Math.random() * Data.length)];
    return '${dino.Name} : ${dino.Description}';
  }
}