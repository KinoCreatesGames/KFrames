package ktitle;

import rm.core.Sprite;
import pixi.extras.TilingSprite;
import kframes.KFrameSprite;
import rm.scenes.Scene_Title;

class KCustomTitleScene extends Scene_Title {
  public var yula:KFrameSprite;
  public var background:Sprite;

  override public function create() {
    untyped Scene_Title.prototype.create.call(this);
  }
}