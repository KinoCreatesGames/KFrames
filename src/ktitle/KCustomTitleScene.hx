package ktitle;

import rm.core.TouchInput;
import kframes.KFrameSprite;
import rm.core.TilingSprite;
import rm.Globals;
import rm.core.Graphics;
import rm.core.Bitmap;
import rm.managers.SceneManager;
import rm.managers.ImageManager;
import rm.core.Sprite;
import kframes.Main as KFrame;
import rm.scenes.Scene_Title;

/**
 * Custom title screen for
 * for Stargazers.
 */
@:native('KCustomTitleScene')
@:expose('KcustomTitleScene')
@:keep
class KCustomTitleScene extends Scene_Title {
  public var yula:KFrameSprite;
  public var customBackground:TilingSprite;
  public var foregroundBalcony:Sprite;
  public var foregroundBalconyRailing:Sprite;

  override public function create() {
    // Create Scene Title Functionality
    untyped _Scene_Title_create.call(this);
    this.createCharacter();
    this.createBalconyRailing();
    this.adjustChildren();
  }

  public function adjustChildren() {
    this.addChild(this.customBackground);
    this.addChild(this.foregroundBalcony);
    this.addChild(this.yula);
    this.addChild(this.foregroundBalconyRailing);
    this.addChild(this._gameTitleSprite);
    this.addChild(this._windowLayer);
  }

  public function createCharacter() {
    yula = KFrame.createSprite('Yula_Walk-Idle_51x103', 51, 103);
    yula.addAnimation('walk', [0, 1, 2, 3, 4, 5, 6, 7]);
    yula.addAnimation('idle', [16, 17, 18, 19, 20, 21, 22, 23]);
    yula.playAnimation('idle', true);
    yula.setFPS(18);
    yula.x = 528;
    yula.y = 272;
    yula.scale.y = 2;
    yula.scale.x = -2;
    // this.addChild(yula);
  }

  public function createBalconyRailing() {
    var bitmap = ImageManager.loadPicture('House_Balcony_Abv-Player_408x312');
    this.foregroundBalconyRailing = new Sprite();
    bitmap.addLoadListener((loadedBitmap) -> {
      this.foregroundBalconyRailing.bitmap = loadedBitmap;
      // this.foregroundBalcony.x = Graphics.width - loadedBitmap.width;
      // this.foregroundBalcony.y = Graphics.height - loadedBitmap.height;
      untyped this.scaleSprite(this.foregroundBalconyRailing);
      // this.addChild(this.foregroundBalconyRailing);
    });
  }

  override public function createBackground() {
    var bitmap = ImageManager.loadPicture('Night-Sky_BG');
    customBackground = new TilingSprite(new Bitmap(Graphics.width,
      Graphics.height));
    bitmap.addLoadListener((loadedBitmap) -> {
      this.customBackground.bitmap = loadedBitmap;
      this.customBackground.move(0, 0, loadedBitmap.width, loadedBitmap.height);
      this.customBackground.y -= 40;
      // this.addChild(this.customBackground);
    });
  }

  override public function createForeground() {
    var bitmap = ImageManager.loadPicture('House_Balcony_408x312');
    this.foregroundBalcony = new Sprite();
    this._gameTitleSprite = new Sprite(new Bitmap(Graphics.width,
      Graphics.height));
    bitmap.addLoadListener((loadedBitmap) -> {
      this.foregroundBalcony.bitmap = loadedBitmap;
      untyped this.scaleSprite(this.foregroundBalcony);

      // this.addChild(this._gameTitleSprite);
    });
    if (Globals.DataSystem.optDrawTitle) {
      this.drawGameTitle();
    }
  }

  override public function adjustBackground() {
    // Empty because we don't need it.
  }

  override function update() {
    untyped _Scene_Title_update.call(this);
    this.updateCustomBackground();
  }

  public function updateCustomBackground() {
    var offsetFromCenterX = TouchInput.x - (Graphics.width / 2);
    var offsetFromCenterY = TouchInput.y - (Graphics.height / 2);
    var movementScaleX = offsetFromCenterX / 10;
    var movementScaleY = offsetFromCenterY / 10;
    this.customBackground.origin.x = movementScaleX;
    this.customBackground.origin.y = movementScaleY;
  }

  override public function terminate() {
    //
    untyped Scene_Base.prototype.terminate.call(this);
    SceneManager.snapForBackground();
  }
}