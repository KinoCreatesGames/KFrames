package ktitle;

import core.MathExt.lerp;
import js.Syntax;
import utils.Fn;
import core.Types.JsFn;
import rm.windows.Window_TitleCommand;
import rm.managers.FontManager;
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

using core.MathExt;

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
  public var scrollingContainer:Sprite;
  public var titleTimer:Int;

  override public function create() {
    // Create Scene Title Functionality
    untyped _Scene_Title_create.call(this);
    this.setupParameters();
    this.createScrollingContainer();
    this.createCharacter();
    this.createBalconyRailing();
    this.adjustChildren();
  }

  public function setupParameters() {
    // 2.5 seconds
    this.titleTimer = 150;
  }

  public function adjustChildren() {
    this.addChild(this.customBackground);
    this.addChild(this.scrollingContainer);
    // Add all the elements that are at the bottom
    // of the screen so that we can slide stuff in.
    this.scrollingContainer.addChild(this.foregroundBalcony);
    this.scrollingContainer.addChild(this.yula);
    this.scrollingContainer.addChild(this.foregroundBalconyRailing);
    this.addChild(this._gameTitleSprite);
    this.addChild(this._windowLayer);
  }

  public function createScrollingContainer() {
    this.scrollingContainer = new Sprite();
    this.scrollingContainer.y = 600;
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
      this.customBackground.y -= 80;
      // slight scaling for hiding the bottom
      this.customBackground.scale.y = 1.2;
      this.customBackground.scale.x = 1.2;
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
    this.updateTitleState();
    this.updateCustomBackground();
  }

  public function updateTitleState() {
    if (this.titleTimer <= 0) {
      // Scroll in backdrop and start the game after some time.
      if (this.scrollingContainer.y >= 0) {
        // this.scrollingContainer.y- 1
        this.scrollingContainer.y = (lerp(this.scrollingContainer.y, -10,
          0.0025)).clampf(0, 600);
        if (this.scrollingContainer.y.withinRangef(0, 75)) {
          this.scrollingContainer.y = (lerp(this.scrollingContainer.y, -100,
            0.0025)).clampf(0, 600);
        }
      }
      if (this.scrollingContainer.y == 0) {
        this._commandWindow.visible = true;
        this._commandWindow.open();
      }
    } else {
      this.titleTimer--;
    }
  }

  public function updateCustomBackground() {
    var offsetFromCenterX = TouchInput.x - (Graphics.width / 2);
    var offsetFromCenterY = TouchInput.y - (Graphics.height / 2);
    var movementScaleX = offsetFromCenterX / 10;
    var movementScaleY = offsetFromCenterY / 10;
    this.customBackground.origin.x = movementScaleX;
    this.customBackground.origin.y = movementScaleY;
  }

  override public function createCommandWindow() {
    // untyped _Scene_Title_createCommandWindow.call(this);
    Syntax.plainCode(" const background = $dataSystem.titleCommandWindow.background;
    const rect = this.commandWindowRect();
    this._commandWindow = new Window_TitleCommand(rect);
    this._commandWindow.setBackgroundType(background);
    this._commandWindow.setHandler(\"newGame\", this.commandNewGame.bind(this)); 
    this._commandWindow.setHandler(\"options\", this.commandOptions.bind(this));");

    this._commandWindow.contents.fontFace = 'title-font';
    this._commandWindow.refresh();
    this._commandWindow.setBackgroundType(2);
    this._commandWindow.visible = false;
    this.addWindow(this._commandWindow);
  }

  override public function drawGameTitle() {
    var x = 20;
    var y = Graphics.height / 4;
    var maxWidth = Graphics.width - x * 2;
    var text = untyped $dataSystem.gameTitle;
    var bitmap = this._gameTitleSprite.bitmap;
    bitmap.fontFace = 'title-font';
    bitmap.outlineColor = 'black';
    bitmap.outlineWidth = 8;
    bitmap.fontSize = 72;
    bitmap.drawText(text, x, y, maxWidth, 48, 'center');
  }

  override public function terminate() {
    //
    untyped Scene_Base.prototype.terminate.call(this);
    SceneManager.snapForBackground();
  }
}