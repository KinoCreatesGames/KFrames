package kcredits;

import rm.core.Graphics;
import rm.Globals;
import pixi.core.text.Text;
import kframes.KFrameSprite;
import kframes.Main as KFrame;
import js.Browser;
import utils.Fn;
import rm.scenes.Scene_Base;

@:native('KCustomCreditsScene')
@:expose('KCustomCreditsScene')
class KCustomCreditsScene extends Scene_Base {
  public var character:KFrameSprite;
  public var titleText:Text;

  public function new() {
    super();
  }

  override public function initialize() {
    super.initialize();
  }

  override public function create() {
    super.create();
    createCharacter();
    createTitle();
  }

  public function createCharacter() {
    // Creates a character assuming KFrames Exists
    var hasKFrames = Fn.hasProperty(Browser.window, 'KCFrames');
    if (hasKFrames) {
      trace('KFrames Available');
      character = KFrame.createSprite('sprootshoot', 51, 103);
      character.addAnimation('walk', [0, 1, 2, 3, 4, 5, 6, 7]);
      character.addAnimation('idle', [16, 17, 18, 19, 20, 21, 22, 23]);
      character.playAnimation('idle', true);
      character.setFPS(18);
      KFrame.addToScene(character);
    }
  }

  public function createTitle() {
    titleText = new Text('Credits', {
      align: 'center',
      fill: 0xFFFFFF,
      fontSize: 24
    });
    titleText.x = (centerX() - (titleText.width / 2));
    this.addChild(titleText);
  }

  inline function centerX() {
    return Graphics.width / 2;
  }

  inline function centerY() {
    return Graphics.height / 2;
  }
}