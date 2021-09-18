package kcutscenefinal;

import js.Browser;
import utils.Fn;
import core.MathExt.clampf;
import rm.core.Graphics;
import pixi.core.text.Text;
import rm.managers.SceneManager;
import kcredits.KCustomCreditsScene;
import kinterpreter.KInterpreter;
import rm.managers.AudioManager;
import pixi.core.graphics.Graphics as PGraphics;
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

@:native('KCustomFinal')
@:expose('KcustomFinal')
class KCustomFinal extends Scene_Base {
  // Containers
  public var container:PGraphics;

  // Scenes

  /**
   * Star background initial background for the scene
   */
  public var sceneBg:Sprite;

  /**
   * Top of the tower for the background
   */
  public var sceneBgTwo:Sprite;

  public var sceneBgThree:Sprite;
  public var finalText:Text;
  // Assets
  public var yula:KFrameSprite;
  public var haley:KFrameSprite;
  public var spaceMom:KFrameSprite;
  public var dad:KFrameSprite;
  public var msgBox:KMsgBox;
  // Interpreter
  public var interpreter:KInterpreter;
  // Flags
  public var startPartOne:Bool;
  public var finalFlag:Bool;
  public var finalTimer = 0;

  public function new() {
    super();
  }

  override public function initialize() {
    super.initialize();
  }

  override public function create() {
    super.create();
    this.startPartOne = false;
    this.finalTimer = this.secondsToFrames(10);
    AudioManager.stopBgm();
    // Initial fade in to the first part of the ending scene
    this.startFadeIn(240, false);
    this.createContainer();
    this.createFinalText();
    this.createBackgrounds();
    this.createCharacters();
    this.createMessageBox();
    this.adjustChildren();
  }

  public function createContainer() {
    container = new PGraphics();
    this.addChild(container);
  }

  public function createFinalText() {
    var text = [
      'Remember, Yula...',
      '',
      '',
      'Whenever you\'re lonely, whever you are...',
      'When you think you have no one, just look to the stars...',
      'I will always be watching over you my dear.'
    ].join('\n');
    finalText = new Text(text, {
      align: 'center',
      fill: 0xFFFFFF,
      dropShadowColor: 'rgba(0, 0, 0, 0.7)',
      dropShadowDistance: 7,
      dropShadowBlur: 20,
      dropShadow: true,
      strokeThickness: 5,
      dropShadowAngle: Math.PI / 2,
      lineHeight: 48,
      fontSize: 24,
    });
    untyped creditText.updateText();
    finalText.x = (centerX() - (finalText.width / 2));
    finalText.y += 824;
    // Make background black
    this.container.beginFill(0x000000, 1);
    this.container.drawRect(0, 0, Graphics.width, Graphics.height);
    this.container.endFill();
    this.container.alpha = 0;
    this.container.addChild(finalText);
  }

  public function createBackgrounds() {
    // Setup the backgrounds for the two scenes
    // Tower and star background
    sceneBg = new Sprite();
    sceneBgTwo = new Sprite();

    var starBg = ImageManager.loadPicture('Night-Sky_BG');
    starBg.addLoadListener((starBm) -> {
      sceneBg.bitmap = starBm;
    });

    var towerTop = ImageManager.loadPicture('Tower_Entryway_816x624');
    towerTop.addLoadListener((towerBm) -> {
      sceneBgTwo.bitmap = towerBm;
    });
  }

  public function createCharacters() {
    var hasKFrames = Fn.hasProperty(Browser.window, 'KCFrames');
    if (hasKFrames) {
      yula = KFrame.createSprite('Yula_Walk-Idle_51x103', 51, 103);
      yula.addAnimation('walk', [0, 1, 2, 3, 4, 5, 6, 7]);
      yula.addAnimation('idle', [16, 17, 18, 19, 20, 21, 22, 23]);
      yula.playAnimation('idle', true);
      yula.setFPS(18);

      // Dad - For the second part of the scene
      dad = KFrame.createSprite('Dad_51x110', 51, 110);
      dad.addAnimation('idle', [0, 1, 2, 3, 4, 5, 6, 7]);
      dad.playAnimation('idle', true);
      dad.setFPS(18);
      dad.visible = false;

      // Space Mom - For Intro
      spaceMom = KFrame.createSprite('Mom_150x150', 150, 150);
      spaceMom.addAnimation('float', [0, 1, 2, 3, 4, 5, 6, 7]);
      spaceMom.playAnimation('float', true);
      spaceMom.setFPS(10);
      spaceMom.x = 0;
      spaceMom.y = 200;
      // spaceMom.scale.y = 2;
      // spaceMom.scale.x = 2;
      spaceMom.visible = false;

      // Haley - For second part with Dad
      haley = KFrame.createSprite('Haley_51x103', 51, 103);
      haley.addAnimation('walk', [0, 1, 2, 3, 4, 5, 6, 7]);
      haley.addAnimation('idle', [16, 17, 18, 19, 20, 21, 22, 23]);
      haley.playAnimation('idle', true);
      haley.setFPS(18);
      haley.visible = false;
      // haley.scale *= -1; //Flip Haley
      var floorY = 554;
      yula.y = floorY - yula.height;
      haley.y = floorY - haley.height;
      yula.x = Graphics.width / 2;
      haley.x = (yula.x - haley.width) - 20;
      this.addChild(yula);
      this.addChild(haley);
      this.addChild(spaceMom);
      this.addChild(dad);
    }
  }

  public function createMessageBox() {
    msgBox = KMsg.createMessageBox(0, 0, 200, 150);
    msgBox.pText.style.wordWrapWidth -= 12;
    msgBox.setFontSize(18);
    msgBox.hide();
  }

  public function adjustChildren() {
    this.addChild(this.msgBox);
  }

  override public function update() {
    super.update();
    this.processScene();
    this.updateInterpreter();
  }

  public function processScene() {
    // Start of the scene breakdown after fade is complete
    if (this._fadeDuration <= 0 && !this.startPartOne) {
      this.startPartOne = true;
      this.addPtOne();
      this.addPtTwo();
      this.addPtThree();
    }
    this.processFinalFlag();
  }

  public function processFinalFlag() {
    if (this.finalFlag) {
      // Fade in the final
      this.container.alpha += clampf(this.container.alpha + 0.25, 0., 1);
      // Start Credits
      if (this.finalTimer <= 0) {
        this.interpreter.addCommand({
          fn: () -> {
            SceneManager.push(KCustomCreditsScene);
          }
        });
      } else {
        this.finalTimer -= 1;
      }
    }
  }

  /**
    * The screen fades into a background of stars.
    Yula’s mom’s theme plays.

    -     -

    Yula (confused): *looking around* “...Where am I?”

    -     -

    Yula’s mom appears in her true form.

    -     -

    Mom (smiling): “You’ve finally made it, my dear.”

    Yula (surprised): *jumps* “You! You’re the one from the balcony, and the tower!”

    Mom (sad): “Of course it’s me… don’t you recognize your own Mother?”

    Yula: “M-my mother? But, how? You’re not human...” 

    Mom (smiling): “That’s correct! I am a Pleiadian, my child… and so are you.”

    Yula (confused): “A… Pleiadian?”

    Mom: “A dweller of the stars, Yula. We are not from this world.” 

    Yula: “...”
    Yula: “If we’re not from this world, then… then how am I here?”

    Mom: “You’re here because of a wish, my dear.”

    Yula: *confused look*

    Mom: “Your father… Every night, he would gaze at the stars and make the same wish.”
    Mom:”As I listened for his voice each night, I realized I had the same wish myself.”
    Mom: “I knew, I couldn’t stay with your father, but I had enough time to give him something better.”

    Yula: “W-what was that?” 

    Mom: “He wished for a family... “
    Mom (smiling): “..so I gave him you.”

    Yula: “I see...” 
    Yula (sad): “But mom, why couldn’t you stay with us?” 

    Mom (sad): “... Pleiadians cannot live on earth without becoming ill. I couldn’t bring myself to tell you both, so I returned in secret.”

    Yula (crying): “Don’t you know how much he worried about you? How much I missed you...”

    Mom (sad): “I’m so sorry, Yula… I am...”
    Mom (happy): *shakes her head* “But everything is okay now! Once we make it to my nebula, we can start over. Together.”

    Yula: “I…”
    Yula (sad): “I’m sorry, mom. I can’t stay with you...”

    Mom:(surprised) “What?!”

    Yula: “I can’t abandon dad like that! I can’t abandon my friend!”

    Mom: “...”
    Mom (crying): “...I… I see.”

    Yula: “Mom..” 

    Mom (sad): “No, it’s alright, my child.”
    Mom: “Let’s get you home.”

    Yula (smiling): “Thank you, Mom!” 


    -     -

    Yula and her mom head towards the light.
    The screen slowly fades to white.

   */
  public function addPtOne() {}

  /**
    * Yula: “I love you, mom… I’ll miss you.” 

    -     -

    The screen fades back into the top of the tower.
    Yula is standing back in the center.

    -     -

    Haley & Dad: “Yula!”

    -     -

    Yula approaches Haley and her dad.

    -     -

    Yula (happy): “Sorry I took so long!” 

    Dad: “Yula… I...”

    Haley (crying): I thought you would never come back!”

    Yula: “What? No way! How could I leave my best friend?” 
    Yula: *looks at  her dad* “I’m sorry, dad… I missed you, and so does mom.” 

    Dad (surprised): “... It’s alright, sweetie. All that matters is that you’re back.” 

    Yula: *yawns*

    Dad (smiling): “How about we get you girls back home? I think we’ve all had a long night...”

    Haley & Yula (happy): “Let’s go!” 


    -     -

    Yula, Haley and Yula’s dad head towards the exit.
    Yula lingers behind and looks back.

    -     -

    Yula: “Goodbye, mom...” 

   */
  public function addPtTwo() {}

  /**
    * The three continue walking as the screen fades to black.
    -     -

    “Remember, Yula…

    Whenever you’re lonely, wherever you are...
    When you think you have no one, just look to the stars…

    I will always be watching over you, my dear.”

    -     -

    The credits sequence begins.

   */
  public function addPtThree() {
    // Set Flag to start word fade in for the final words
    this.interpreter.addCommand({
      fn: () -> {
        this.finalFlag = true;
      }
    });
  }

  public function updateInterpreter() {
    this.interpreter.update();
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