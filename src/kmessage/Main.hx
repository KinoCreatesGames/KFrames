package kmessage;

import rm.Globals;

typedef KParams = {};

@:native('KMessage')
@:expose('KMessage')
class Main {
  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) ->
      ~/<KMsg>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
  }

  public static function createMessageBox(?x:Float, ?y:Float, ?width:Float,
      ?height:Float) {
    return new KMsgBox(x, y, width, height);
  }
}