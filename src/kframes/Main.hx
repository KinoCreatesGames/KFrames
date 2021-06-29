package kframes;

import rm.managers.ImageManager;
import rm.scenes.Scene_Base;

typedef KParams = {};

@:native('KCFrames')
@:expose('KCFrames')
class Main {
  public static var Params:KParams = null;
  public static var listener:EventEmitter = createEventEmitter();
  public static var KFrameSprite:Class<KFrameSprite> = kframes.KFrameSprite;

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) ->
      ~/<KCFrames>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
    Params = {};

    trace(Params, params);
  }

  public static function params() {
    return Params;
  }

  /**
   * Create a KFrameSprite for displaying a different sized sprite in
   * RPGMakerMV/MZ.
   * @param path 
   */
  public static function createSprite(path:String, ?frameWidth:Int = 48,
      ?frameHeight:Int = 48) {
    return new KFrameSprite(ImageManager.loadPicture(path), frameWidth,
      frameHeight);
  }

  public static function addToScene(kframeSprite:KFrameSprite) {
    var scene:Scene_Base = currentScene();
    scene.addChild(kframeSprite);
    return kframeSprite;
  }
}