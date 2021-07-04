package kmessage;

import pixi.core.text.Text;
import utils.Comment;
import pixi.core.graphics.Graphics;

typedef Color = Int;

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
    this.text = '';
    this.fontColor = 0xFFFFFF;
    this.fontSize = 12;
    this.align = 'left';
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
    this.addChild(this.pText);
    this.drawMessageBox();
  }

  public function sendMsg(msg:String) {
    this.text = msg;
    this.pText.text = this.text;
  }

  public function drawMessageBox() {
    this.clear();
    this.drawBorder();
    this.drawBackground();
  }

  public function drawBorder() {
    this.beginFill(borderColor);
    this.drawRect(0, 0, windowWidth, windowHeight);
    return this;
  }

  public function drawBackground() {
    this.beginFill(bgColor);
    this.drawRect(borderSize, borderSize, windowWidth - (borderSize * 2),
      (windowHeight - borderSize * 2));
    return this;
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
  }

  public function hide() {
    this.visible = false;
  }

  public function show() {
    this.visible = true;
  }
}