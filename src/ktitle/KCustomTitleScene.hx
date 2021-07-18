package ktitle;

import rm.scenes.Scene_Map;
import kmessage.KMsgBox;
import rm.managers.DataManager;
import rm.core.Input;
import core.MathExt.lerp;
import js.Syntax;
import kmessage.Main as KMsg;
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
typedef FnStep = {
  fn:Void -> Void,
  waitTime:Int,
}

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
  public var skipScroll:Bool;
  public var skipScrollComplete:Bool;
  public var clickNewGame:Bool;
  public var yulaExitScreen:Bool;
  // Wait time between each element of the scene
  public var waitTime:Int; // In Frames
  public var msgBox:KMsgBox;
  public var commandStepList:Array<FnStep>;
  public var currentCommand:FnStep;

  override public function create() {
    // Create Scene Title Functionality
    untyped _Scene_Title_create.call(this);
    this.setupParameters();
    this.createScrollingContainer();
    this.createMessageBox();
    this.createCharacter();
    this.createBalconyRailing();
    this.adjustChildren();
    this.setupCutscene();
  }

  public function setupParameters() {
    // 2.5 seconds
    this.titleTimer = 150;
    this.skipScroll = false;
    this.skipScrollComplete = false;
    this.yulaExitScreen = false;
  }

  public function setupCutscene() {
    var padding = 20;
    commandStepList = [];
    var defaultWait = 300;
    commandStepList.push({
      fn: () -> {
        // orient message box at Yula's position
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "Oh! it's the North stars! ...oh! ...I can't believe we can see the constellation of Orion here!";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait * 2
    });
    commandStepList.push({
      fn: () -> {
        var text = "Ah...stars are aweso...!";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait
    });
    commandStepList.push({
      fn: () -> {
        msgBox.x += 150;
        var text = "Yula! It's 2AM, Go to sleep!";
        msgBox.sendMsgC('dad', text);
      },
      waitTime: defaultWait
    });
    commandStepList.push({
      fn: () -> {
        yula.scale.x = 2;
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "Sorry daddy! I'm going to sleep!";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait
    });
    commandStepList.push({
      fn: () -> {
        yula.scale.x = -2;
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "Aww...if only my Dad shared the same excitement as me...";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait
    });
    commandStepList.push({
      fn: () -> {
        var text = "He hasn't enjoyed looking at the stars since mom...";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait
    });
    commandStepList.push({
      fn: () -> {
        var text = "Well whatever! Time to go to sleep before the old geezer gets angry!";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait + 180
    });
    commandStepList.push({
      fn: () -> {
        msgBox.hide();
        // Flip Sprite
        yula.scale.x = 2;
        // Move to the door run from here
        yulaExitScreen = true;
      },
      waitTime: 60
    });
    commandStepList.push({
      fn: () -> {
        this.fadeOutAll();
        SceneManager.goto(Scene_Map);
      },
      waitTime: 30
    });
  }

  public function adjustChildren() {
    this.addChild(this.customBackground);
    this.addChild(this.scrollingContainer);
    // Add all the elements that are at the bottom
    // of the screen so that we can slide stuff in.
    this.scrollingContainer.addChild(this.foregroundBalcony);
    this.scrollingContainer.addChild(this.yula);
    this.scrollingContainer.addChild(this.foregroundBalconyRailing);
    this.addChild(this.msgBox);
    this.addChild(this._gameTitleSprite);
    this.addChild(this._windowLayer);
  }

  public function createScrollingContainer() {
    this.scrollingContainer = new Sprite();
    this.scrollingContainer.y = 600;
  }

  public function createMessageBox() {
    msgBox = KMsg.createMessageBox(0, 0, 200, 150);
    msgBox.pText.style.wordWrapWidth -= 12;
    msgBox.setFontSize(18);
    msgBox.hide();
  }

  public function createCharacter() {
    yula = KFrame.createSprite('Yula_Walk-Idle_51x103', 51, 103);
    yula.addAnimation('walk', [0, 1, 2, 3, 4, 5, 6, 7]);
    yula.addAnimation('idle', [16, 17, 18, 19, 20, 21, 22, 23]);
    yula.playAnimation('idle', true);
    yula.setFPS(10);
    yula.x = 528;
    yula.y = 276;
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
    // untyped _Scene_Title_update.call(this);
    untyped Scene_Base.prototype.update.call(this);
    this.updateTitleState();
    this.updateCustomBackground();
    // Only gets processed after new game is clicked
    if (this.clickNewGame) {
      this.updateIntroScene();
    }
  }

  /**
   * Updates the intro cutscene 
   */
  public function updateIntroScene() {
    if (this.waitTime <= 0) {
      this.currentCommand = this.commandStepList.shift();
      if (this.currentCommand != null) {
        this.currentCommand.fn();
        this.waitTime = this.currentCommand.waitTime;
      }
    } else {
      this.waitTime--;
    }
  }

  public function updateTitleState() {
    // buttonClicked
    var buttonClicked = Input.isPressed('ok')
      || Input.isPressed('cancel')
      || TouchInput.isCancelled()
      || TouchInput.isPressed();
    if (buttonClicked && !this.skipScroll) {
      this.skipScroll = true;
      this.startFadeOut(30, false);
    }

    if (this.skipScroll && this._fadeDuration <= 0 && !this.skipScrollComplete) {
      // Set everything to the proper positions automatically
      this.scrollingContainer.y = 0;
      this.startFadeIn(30, false);
      this.skipScrollComplete = true;
      if (this.scrollingContainer.y == 0 && !this.clickNewGame) {
        this._commandWindow.visible = true;
        this._commandWindow.open();
      }
    } else {
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
        if (this.scrollingContainer.y == 0 && !this.clickNewGame) {
          this._commandWindow.visible = true;
          this._commandWindow.open();
        }
      } else {
        this.titleTimer--;
      }
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
    this._commandWindow.makeCommandList = function()  { this.addCommand(TextManager.newGame, \"newGame\");
this.addCommand(TextManager.options, \"options\");};
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

  override public function commandNewGame() {
    DataManager.setupNewGame();
    this._commandWindow.close();
    this.clickNewGame = true;
    this._gameTitleSprite.visible = false;
  }

  override public function terminate() {
    //
    untyped Scene_Base.prototype.terminate.call(this);
    SceneManager.snapForBackground();
  }
}