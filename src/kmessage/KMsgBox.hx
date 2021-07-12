package kmessage;

import pixi.core.renderers.webgl.Renderer;
import pixi.core.Pixi.ScaleModes;
import rm.core.Bitmap;
import rm.core.TilingSprite;
import core.Amaryllis.createEventEmitter;
import pixi.interaction.EventEmitter;
import pixi.core.text.Text;
import utils.Comment;
import pixi.core.graphics.Graphics;

typedef Color = Int;

enum abstract MsgEvents(String) from String to String {
  var CREATE_WIN:String = 'createWindow';
  var SEND_MSG:String = 'sendMsg';
  var END_MSG:String = 'endMsg';
  var CLOSE_WIN:String = 'closeWindow';
  var OPEN_WIN:String = 'openWindow';
  var HIDE_WIN:String = 'hideWindow';
  var SHOW_WIN:String = 'showWindow';
}

@:native('KMsgBox')
@:expose('KMsgBox')
class KMsgBox extends Graphics {
  /**
   * Background color; defaults to black(0x000000).
   */
  public var bgColor:Color;

  /**
   * Border color; defaults to white(0xFFFFFF).
   */
  public var borderColor:Color;

  /**
   * Alpha for the background.
   */
  public var bgAlpha:Float;

  /**
   * Defaults to 4.
   */
  public var borderSize:Int;

  public var windowWidth:Float;
  public var windowHeight:Float;

  /**
   * The text to display on screen.
   */
  public var text:String;

  /**
   * Core text object for showing any text in the window.
   */
  public var pText:Text;

  public var fontSize:Int;
  public var fontColor:Int;
  public var align:String;

  public var padding:Int;

  /**
   * Used to determine how many frames to wait before rendering text.
   */
  public var textTimer:Int;

  public var textTime:Int;

  /**
   * Radius of the corners of the message window.
   */
  public var cornerRadius:Float;

  public var starIndicator:Graphics;

  public inline static var STAR_RADIUS:Float = 10;

  public inline static var TEXT_FRAMETIME:Int = 5;

  public var tilingBackground:TilingSprite;

  public function new(x:Float = 0, y:Float = 0, width:Float = 100,
      height:Float = 100) {
    super();
    this.x = x;
    this.y = y;
    this.windowWidth = width;
    this.windowHeight = height;
    Comment.singleLine('Defaults to black');
    this.bgColor = 0x000000;
    Comment.singleLine('Defaults to white');
    this.borderColor = 0xFFFFFF;
    this.borderSize = 4;
    this.bgAlpha = 1;
    this.text = '';
    this.fontColor = 0xFFFFFF;
    this.fontSize = 16;
    this.align = 'left';
    this.cornerRadius = 10;
    this.textTime = TEXT_FRAMETIME; // Default value
    this.textTimer = this.textTime;

    this.pText = new Text(text, {
      fontSize: this.fontSize,
      fill: this.fontColor,
      align: this.align,
      wordWrap: true,
      wordWrapWidth: width,
    });
    padding = 4;
    this.pText.y = (this.borderSize + padding);
    this.pText.x = (this.borderSize + padding);
    this.pText.text = '';
    this.starIndicator = new Graphics();
    var starPadding = (this.padding + (STAR_RADIUS * 2) + this.borderSize);
    this.starIndicator.x = this.windowWidth - starPadding;
    this.starIndicator.y = this.windowHeight - starPadding;
    this.tilingBackground = new TilingSprite(new Bitmap(this.windowWidth,
      this.windowHeight));
    this.tilingBackground.x = this.borderSize;
    this.tilingBackground.y = this.borderSize;
    this.addChild(this.tilingBackground);
    this.addChild(this.starIndicator);
    this.addChild(this.pText);
    this.drawMessageBox();
    this.emit(CREATE_WIN, this);
  }

  public function sendMsg(msg:String) {
    this.text = msg;
    this.pText.text = '';
    this.starIndicator.visible = false;
    this.emit(SEND_MSG, this, msg);
  }

  public function drawMessageBox() {
    this.clear();
    this.drawBorder();
    this.drawBackground();
    this.drawTilingBackground();
    this.drawIndicatorStar();
  }

  public function drawBorder() {
    this.beginFill(borderColor, 1);
    this.drawRoundedRect(0, 0, windowWidth, windowHeight, cornerRadius);
    this.endFill();
    return this;
  }

  public function drawBackground() {
    this.beginFill(bgColor, this.bgAlpha);
    this.drawRoundedRect(borderSize, borderSize,
      windowWidth - (borderSize * 2), (windowHeight - borderSize * 2),
      cornerRadius);
    this.endFill();
    return this;
  }

  public function drawTilingBackground() {
    var starGraphic = new Graphics();
    starGraphic.beginFill(0x1A1A1A, 0.75);
    var starCount = Math.floor(this.windowWidth / STAR_RADIUS);
    var starRows = Math.floor(this.windowHeight / STAR_RADIUS);
    var starSpacing = 25;
    for (i in 0...starCount) {
      for (y in 0...starRows) {
        starGraphic.drawStar(i * starSpacing, y * starSpacing, 5, STAR_RADIUS,
          5, 0);
      }
    }

    starGraphic.endFill();
    var renderer:Renderer = untyped rm.core.Graphics.app.renderer;
    var texture = renderer.generateTexture(starGraphic, ScaleModes.DEFAULT, 1);
    var canvas = renderer.extract.canvas(texture);
    texture.destroy(true);
    this.tilingBackground.bitmap = new Bitmap(this.windowWidth
      - (borderSize * 2),
      this.windowHeight
      - (borderSize * 2));
    var bitmap = this.tilingBackground.bitmap;
    bitmap.context.drawImage(canvas, 0, 0);
    bitmap.baseTexture.update();
    // Always use move command
    this.tilingBackground.move(this.borderSize, this.borderSize, bitmap.width,
      bitmap.height);
  }

  public function drawIndicatorStar() {
    this.starIndicator.clear();
    this.starIndicator.beginFill(0xFFFFFF, 1);
    this.starIndicator.drawStar(0, 0, 5, STAR_RADIUS, 5, 0);
    this.starIndicator.endFill();
    var starPadding = (this.padding + (STAR_RADIUS * 2) + this.borderSize);
    this.starIndicator.x = this.windowWidth - starPadding;
    this.starIndicator.y = this.windowHeight - starPadding;
  }

  /**
   * By default graphics don't have an update.
   * Adding update for better text support.
   */
  public function update() {
    this.updateTilingBackground();
    this.updateTextToRender();
  }

  public function updateTilingBackground() {
    this.tilingBackground.origin.y -= 0.64;
    this.tilingBackground.origin.x += 0.64;
  }

  public function updateTextToRender() {
    if (this.textTimer <= 0) {
      this.textTimer = this.textTime;
      this.pText.text = this.text.substring(0, this.pText.text.length + 1);
    }

    if (this.text != pText.text) {
      this.textTimer--;
    } else {
      if (!this.starIndicator.visible) {
        this.emit(END_MSG);
      }
      this.starIndicator.visible = true;
    }
  }

  /**
   * Sets the background colur using an integer hexadecimal.
   * RGB
   * ie 0xFFFFFF
   * @param color 
   */
  public function setBgColor(color:Color) {
    this.bgColor = color;
    this.drawMessageBox();
    return this;
  }

  public function setFontSize(size:Int) {
    this.fontSize = size;
    this.pText.style.fontSize = size;
    return this;
  }

  public function setFontColor(color:Color) {
    this.fontColor = color;
    this.pText.style.fill = color;
    return this;
  }

  public function move(?x:Float, ?y:Float) {
    var moveX = x != null ? x : this.x;
    var moveY = y != null ? y : this.y;
    this.x = moveX;
    this.y = moveY;
    return this;
  }

  public function setXY(x:Float, y:Float) {
    this.x = x;
    this.y = y;
    return this;
  }

  public function setWindowWidth(width:Float) {
    this.windowWidth = width;
    this.pText.style.wordWrapWidth = (this.windowWidth
      - ((borderSize * 2) + padding));
    this.drawMessageBox();
    return this;
  }

  public function setWindowHeight(height:Float) {
    this.windowHeight = height;
    this.drawMessageBox();
    return this;
  }

  public function setDimensions(width:Float, height:Float) {
    this.windowWidth = width;
    this.windowHeight = height;
    this.pText.style.wordWrapWidth = (this.windowWidth
      - ((borderSize * 2) + padding));
    this.drawMessageBox();
    return this;
  }

  /**
   * Sets the border color using an Integer hexadecimal.
   * RGB.
   * ie 0xFFFFFF
   * @param color 
   */
  public function setBorderColor(color:Color) {
    this.borderColor = color;
    this.drawMessageBox();
    return this;
  }

  public override function clear():Graphics {
    return super.clear();
    return this;
  }

  public function hide() {
    this.visible = false;
    this.emit(HIDE_WIN, this);
    return this;
  }

  public function show() {
    this.visible = true;
    this.emit(SHOW_WIN, this);
    return this;
  }
}