package kcredits;

import rm.core.TilingSprite;
import rm.core.Bitmap;
import rm.managers.ImageManager;
import rm.core.Sprite;
import pixi.core.math.Point;
import core.MathExt.lerp;
import rm.core.Graphics;
import pixi.core.graphics.Graphics as PGraphics;
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
  public var yula:KFrameSprite;
  public var haley:KFrameSprite;
  public var mother:KFrameSprite;
  public var titleText:Text;
  public var container:PGraphics;
  public var delay:Int;
  public var creditText:Text;
  public var finText:Text;
  public var background:TilingSprite;

  public function new() {
    super();
    this.delay = secondsToFrames(5);
  }

  override public function initialize() {
    super.initialize();
  }

  override public function create() {
    super.create();
    createBackground();
    createContainer();
    createCharacters();
    createTitle();
    createCredits();
    createFin();
  }

  public function createBackground() {
    var backgroundColor = new Sprite();
    backgroundColor.bitmap = new Bitmap(Graphics.width, Graphics.height);
    backgroundColor.bitmap.fillRect(0, 0, Graphics.width, Graphics.height,
      '#89c0f3');
    var backgroundImage = ImageManager.loadPicture('Tower_No-BG_816x624Scroll2');
    background = new TilingSprite(backgroundImage);
    backgroundImage.addLoadListener((bitmap) -> {
      background.bitmap = bitmap;
      background.move(0, 0, bitmap.width, bitmap.height);
    }); // this.addChild(backgroundColor);
    this.addChild(background);
  }

  public function createCharacters() {
    // Creates a character assuming KFrames Exists
    var hasKFrames = Fn.hasProperty(Browser.window, 'KCFrames');
    if (hasKFrames) {
      trace('KFrames Available');
      yula = KFrame.createSprite('Yula_Walk-Idle_51x103', 51, 103);
      yula.addAnimation('walk', [0, 1, 2, 3, 4, 5, 6, 7]);
      yula.addAnimation('idle', [16, 17, 18, 19, 20, 21, 22, 23]);
      yula.playAnimation('walk', true);
      yula.setFPS(18);

      haley = KFrame.createSprite('Haley_Walk-Idle_51x103', 51, 103);
      haley.addAnimation('walk', [0, 1, 2, 3, 4, 5, 6, 7]);
      haley.playAnimation('walk', true);
      haley.setFPS(18);
      // haley.scale *= -1; //Flip Haley
      var floorY = 554;
      yula.y = floorY - yula.height;
      haley.y = floorY - haley.height;
      yula.x = Graphics.width / 2;
      haley.x = (yula.x - haley.width) - 20;
      this.addChild(yula);
      this.addChild(haley);
    }
  }

  public function createContainer() {
    container = new PGraphics();
    this.addChild(container);
  }

  public function createTitle() {
    titleText = new Text('Credits', {
      align: 'center',
      fill: 0xFFFFFF,
      fontSize: 24
    });
    titleText.x = (centerX() - (titleText.width / 2));
    this.container.addChild(titleText);
  }

  public function createCredits() {
    var creditsText = [
      'Art', 'Amysaurus - @Amysaurus121 - Pixel Artist',
      'Nio Kasgami - @kasgami - Concept Artist', 'Audio',
      'JDSherbert - @JDSherbert_ - Musician & Audio Engineer', 'Voice Acting',
      'Amysaurus - @Amysaurus121', 'Kino - @EISKino', 'Programming',
      'Kino  - @EISKino - Tools Programmer', 'inc0der - Tools Programmer',
      'U.K.L - @U_K_L_- Gameplay Programmer'
    ].join('\n');
    creditText = new Text(creditsText, {
      align: 'center',
      fill: 0xFFFFFF,
      lineHeight: 48,
      fontSize: 24,
    });

    creditText.x = (centerX() - (creditText.width / 2));
    creditText.y += 40;
    this.container.addChild(creditText);
  }

  public function createFin() {
    finText = new Text('The End', {
      fill: 0xFFFFFF,
      fontSize: 32,
      align: 'center'
    });
    finText.x = (centerX() - (finText.width / 2));
    finText.y = (centerY() - (finText.height / 2));
    finText.alpha = 0;
    this.addChild(finText);
  }

  override public function update() {
    super.update();
    updateCreditScreen();
  }

  public function updateCreditScreen() {
    this.background.origin.x += 0.64;
    this.updateCreditScroll();
    this.updateCreditFin();
  }

  public function updateCreditScroll() {
    if (this.delay > 0) {
      this.delay--;
    }
    if (this.delay <= 0) {
      // Start Scroll
      // Might add lerping instead.
      this.container.y -= 1;
    }
  }

  public function updateCreditFin() {
    var screenPosition = this.creditText.toGlobal(new Point(this.creditText.x,
      this.creditText.y));
    var padding = 15;
    if (((padding + this.creditText.height) + screenPosition.y) < 0) {
      // Show Fin via fade In
      this.finText.alpha = lerp(this.finText.alpha, 1.1, 0.005);
    }
  }

  inline function centerX() {
    return Graphics.width / 2;
  }

  inline function centerY() {
    return Graphics.height / 2;
  }

  inline function secondsToFrames(seconds:Int) {
    return seconds * 60;
  }
}