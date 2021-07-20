package kcutscenetwo;

import rm.managers.AudioManager;
import rm.managers.ImageManager;
import rm.core.Sprite;
import kmessage.KMsgBox;
import kframes.KFrameSprite;
import pixi.core.graphics.Graphics as PGraphics;
import kmessage.Main as KMsg;
import kframes.Main as KFrame;
import rm.scenes.Scene_Base;

using core.MathExt;
using Lambda;

/**
 * Custom title screen for
 * for Stargazers.
 */
typedef FnStep = {
  fn:Void -> Void,
  waitTime:Int,
}

@:native('KCustomCutsceneTwo')
@:expose('KCustomCutsceneTwo')
class KCustomCutsceneTwo extends Scene_Base {
  // Sprite & Background Information
  public var sceneBackground:Sprite;
  public var sceneBackgroundTwo:Sprite;
  public var sceneBackgroundThree:Sprite;
  public var sceneBackgroundThreeRail:Sprite;
  public var starBackground:Sprite;
  public var yula:KFrameSprite;
  public var spaceMom:KFrameSprite;
  public var amulet:KFrameSprite;
  public var msgBox:KMsgBox;
  // Interpreter Information
  public var commandStepList:Array<FnStep>;
  public var currentCommand:FnStep;
  public var waitTime:Int;
  public var startPartOne:Bool;
  public var startPartTwo:Bool;
  public var startPartThree:Bool;
  public var complete:Bool;
  public var momFade:Bool;
  public var startAmuletFall:Bool;

  // Defautl Wait Time of 3 seconds
  public static inline var DEFAULT_WAIT_TIME:Int = 180;

  public function new() {
    super();
  }

  override public function initialize() {
    super.initialize();
  }

  override public function create() {
    super.create();
    this.waitTime = 0;
    this.currentCommand = null;
    this.commandStepList = [];
    this.startPartOne = false;
    this.startPartTwo = false;
    this.startPartThree = false;
    this.complete = false;
    this.momFade = false;
    AudioManager.stopBgm(); // Stop BGM
    this.startFadeIn(240, false);
    this.createBackgrounds();
    this.createCharacters();
    this.createMessageBox();
    this.adjustChildren();
  }

  public function createBackgrounds() {
    sceneBackground = new Sprite();
    sceneBackgroundTwo = new Sprite();
    sceneBackgroundThree = new Sprite();
    sceneBackgroundThreeRail = new Sprite();
    starBackground = new Sprite();

    var firstBackground = ImageManager.loadPicture('House_Hallway_408x312');
    var secondBackground = ImageManager.loadPicture('House-Bedroom_408x312');
    var thirdBackground = ImageManager.loadPicture('House_Balcony_408x312');
    var rail = ImageManager.loadPicture('House_Balcony_Abv-Player_408x312');
    var nightSky = ImageManager.loadPicture('Night-Sky_BG');
    this.starBackground.visible = false;
    this.sceneBackgroundThree.visible = false;

    firstBackground.addLoadListener((sceneOneBitmap) -> {
      this.sceneBackground.bitmap = sceneOneBitmap;
      untyped this.scaleSprite(this.sceneBackground);
    });

    secondBackground.addLoadListener((sceneTwoBitmap) -> {
      this.sceneBackgroundTwo.bitmap = sceneTwoBitmap;
      untyped this.scaleSprite(this.sceneBackgroundTwo);
    });

    thirdBackground.addLoadListener((thirdBack) -> {
      this.sceneBackgroundThree.bitmap = thirdBack;
      untyped this.scaleSprite(this.sceneBackgroundThree);
    });

    nightSky.addLoadListener((night) -> {
      this.starBackground.bitmap = night;
      untyped this.scaleSprite(this.starBackground);
    });

    rail.addLoadListener((railing) -> {
      this.sceneBackgroundThreeRail.bitmap = railing;
      this.sceneBackgroundThreeRail.visible = false;
      untyped this.scaleSprite(this.sceneBackgroundThreeRail);
    });
  }

  public function createCharacters() {
    yula = KFrame.createSprite('Yula_No-Necklace_51x103', 51, 103);
    yula.addAnimation('walk', [0, 1, 2, 3, 4, 5, 6, 7]);
    yula.addAnimation('idle', [16, 17, 18, 19, 20, 21, 22, 23]);
    yula.playAnimation('idle', true);
    yula.setFPS(10);
    yula.x = 528;
    yula.y = 276;
    yula.scale.y = 2;
    yula.scale.x = -2;

    // Space Mom
    spaceMom = KFrame.createSprite('Mom_150x150', 150, 150);
    spaceMom.addAnimation('float', [0, 1, 2, 3, 4, 5, 6, 7]);
    spaceMom.playAnimation('float', true);
    spaceMom.setFPS(10);
    spaceMom.x = 0;
    spaceMom.y = 200;
    spaceMom.scale.y = 2;
    spaceMom.scale.x = 2;
    spaceMom.visible = false;

    // Amulet
    amulet = KFrame.createSprite('Falling-Amulet_102x256');
    // 15 Frame animation
    amulet.addAnimation('falling',
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]);
    amulet.setFPS(10);
    amulet.x = yula.x - 60;
    amulet.y = spaceMom.y;
    amulet.visible = false;
  }

  public function createMessageBox() {
    msgBox = KMsg.createMessageBox(0, 0, 200, 150);
    msgBox.pText.style.wordWrapWidth -= 12;
    msgBox.setFontSize(18);
    msgBox.hide();
  }

  public function adjustChildren() {
    this.addChild(this.starBackground);
    this.addChild(this.sceneBackgroundThree);
    this.addChild(this.sceneBackgroundTwo);
    this.addChild(this.sceneBackground);
    this.addChild(this.yula);
    this.addChild(this.spaceMom);
    this.addChild(this.amulet);
    this.addChild(this.sceneBackgroundThreeRail);
    this.addChild(this.msgBox);
  }

  override public function update() {
    super.update();
    this.processScene();
    this.updateInterpreter();
    this.updateMomFade();
  }

  public function processScene() {
    // First Section
    var padding = 20;
    var defaultWait = DEFAULT_WAIT_TIME;
    var momWindowX:Float = 0;
    var momWindowY:Float = 0;

    if (this._fadeDuration <= 0 && !this.startPartOne) {
      this.startPartOne = true;
      // Push all commands
      this.addSceneOneCommands();
      this.addSceneTwoCommands();
      this.addSceneThreeCommands();
    }
    // } else
    //   if (this._fadeDuration <= 0 && this.startPartThree && !this.complete) {
    //   this.addSceneThreeCommands();
    // } else if (this._fadeDuration <= 0 && this.startPartTwo && !this.complete) {
    //   this.addSceneTwoCommands();
    // }
  }

  public function addSceneOneCommands() {
    var padding = 20;
    var defaultWait = DEFAULT_WAIT_TIME;
    var momWindowX:Float = 0;
    var momWindowY:Float = 0;
    this.commandStepList.push({
      fn: () -> {
        // Show message window
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(0, y);
        momWindowX = msgBox.x;
        momWindowY = msgBox.y;
        msgBox.show();
        msgBox.sendMsgC('spaceMom', 'Yula...');
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        // orient message box at Yula's position
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "Uh?";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        // orient message box at Yula's position
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "...Mom?";
        msgBox.sendMsgC('yula', text);
        AudioManager.playBgm({
          name: 'JDSherbert - Stargazer OST - Celestial Texture',
          pos: 0,
          pan: 0,
          volume: 50,
          pitch: 100
        });
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        msgBox.hide();
        // Play Mother Theme
        this.startFadeOut(180, false);
        this.startPartTwo = true;
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        this.sceneBackground.visible = false;
      },
      waitTime: 30
    });
  }

  public function addSceneTwoCommands() {
    var padding = 20;
    var defaultWait = DEFAULT_WAIT_TIME;
    var momWindowX:Float = 0;
    var momWindowY:Float = 0;
    this.commandStepList.push({
      fn: () -> {
        // Play Mother Theme
        this.startFadeIn(180, false);
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        // Show message window
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(0, y);
        momWindowX = msgBox.x;
        momWindowY = msgBox.y;
        msgBox.show();
        msgBox.sendMsgC('spaceMom', 'Yula...');
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        // orient message box at Yula's position
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "...!";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        msgBox.hide();
        // Play Mother Theme
        yula.playAnimation('walk', false);
        this.startFadeOut(180, false);
        this.startPartThree = true;
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        this.sceneBackgroundTwo.visible = false;
        // Prepare Scene Three
        this.sceneBackgroundThree.visible = true;
        this.starBackground.visible = true;
        this.sceneBackgroundThreeRail.visible = true;
        this.spaceMom.visible = true;
        yula.playAnimation('idle', true);
      },
      waitTime: 30
    });
  }

  public function addSceneThreeCommands() {
    var padding = 20;
    var defaultWait = DEFAULT_WAIT_TIME;
    var momWindowX:Float = 0;
    var momWindowY:Float = 0;
    this.commandStepList.push({
      fn: () -> {
        // Prepare Scene
        this.startFadeIn(180, false);
        spaceMom.tint = 0x000000;
        spaceMom.visible = true;
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        // Show message window
        var scaleX = spaceMom.scale.x;
        var scaleY = spaceMom.scale.y;
        var x = ((spaceMom.x + (spaceMom.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (spaceMom.y - padding) - this.msgBox.height;

        msgBox.move(x, y);
        msgBox.show();
        var text = "Yula...";
        msgBox.sendMsgC('spaceMom', text);
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        // orient message box at Yula's position
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "Wait...who are you? And... How do you know my name?";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait + 120
    });
    this.commandStepList.push({
      fn: () -> {
        // Show message window
        var scaleX = spaceMom.scale.x;
        var scaleY = spaceMom.scale.y;
        var x = ((spaceMom.x + (spaceMom.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (spaceMom.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "...Come to the star tower...";
        msgBox.sendMsgC('spaceMom', text);
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        // orient message box at Yula's position
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "Wait, what? Why?";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait + 120
    });
    this.commandStepList.push({
      fn: () -> {
        // Show message window
        var scaleX = spaceMom.scale.x;
        var scaleY = spaceMom.scale.y;
        var x = ((spaceMom.x + (spaceMom.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (spaceMom.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "There isn't much time left...";
        msgBox.sendMsgC('spaceMom', text);
        this.momFade = true;
        this.startAmuletFall = true;
        // play falling animation
        this.amulet.visible = true;
        this.amulet.playAnimation('falling', false);
      },
      waitTime: defaultWait
    });

    // Mom Disappears
    // Sprite falls to the ground for the pendant
    // =====
    this.commandStepList.push({
      fn: () -> {
        // orient message box at Yula's position
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "Wh...what was that";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait
    });
    this.commandStepList.push({
      fn: () -> {
        // orient message box at Yula's position
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "Uh...?";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait
    });
    // A Pendant Pick Up Here
    this.commandStepList.push({
      fn: () -> {
        // orient message box at Yula's position
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        this.amulet.visible = false;
        var text = "A pendant?";
        msgBox.sendMsgC('yula', text);
        // Hide amulet after the pendant is picked up
      },
      waitTime: defaultWait
    });

    this.commandStepList.push({
      fn: () -> {
        // orient message box at Yula's position
        var scaleX = yula.scale.x;
        var scaleY = yula.scale.y;
        var x = ((yula.x + (yula.width * scaleX) / 2))
          - (this.msgBox.windowWidth / 2);
        var y = (yula.y - padding) - this.msgBox.height;
        msgBox.move(x, y);
        msgBox.show();
        var text = "Who was that?";
        msgBox.sendMsgC('yula', text);
      },
      waitTime: defaultWait
    });
    commandStepList.push({
      fn: () -> {
        msgBox.hide();
        // Flip Sprite
        yula.scale.x = 2;
        // Move to the door run from here
      },
      waitTime: 60
    });
    commandStepList.push({
      fn: () -> {
        this.complete = true;
        this.fadeOutAll();
        this.popScene();
      },
      waitTime: 30
    });
  }

  public function updateInterpreter() {
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

  public function updateMomFade() {
    if (this.momFade) {
      this.spaceMom.opacity -= 2;
    }
  }
}