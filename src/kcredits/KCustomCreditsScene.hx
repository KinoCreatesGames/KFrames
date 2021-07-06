package kcredits;

import kframes.Main as KFrame;
import js.Browser;
import utils.Fn;
import rm.scenes.Scene_Base;

@:native('KCustomCreditsScene')
@:expose('KCustomCreditsScene')
class KCustomCreditsScene extends Scene_Base {
  public function new() {
    super();
  }

  override public function initialize() {
    super.initialize();
  }

  override public function create() {
    super.create();
    createCharacter();
  }

  public function createCharacter() {
    // Creates a character assuming KFrames Exists
    var hasKFrames = Fn.hasProperty(Browser.window, 'KCFrames');
    if (hasKFrames) {
      trace('KFrames Available');
      var character = KFrame.createSprite('sprootshoot', 51, 103);
      character.addAnimation('walk', [0, 1, 2, 3, 4, 5, 6, 7]);
      character.playAnimation('walk', true);
      character.setFPS(18);
      KFrame.addToScene(character);
    }
  }
}