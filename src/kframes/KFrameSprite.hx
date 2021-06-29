package kframes;

import rm.core.Bitmap;

@:keep
class KFrameSprite extends rm.core.Sprite {
  public var frameWidth:Int;
  public var frameHeight:Int;
  public var frameIndex:Int;
  public var animations:Map<String, Array<Int>>;

  /**
   * Adjusts the speed at which to animate
   * This is in frames per second.
   */
  public var frameSpeed:Int;

  /**
   * Amount of time to wait before going to the next frame.
   * Updated every frame.
   */
  public var frameWait:Int;

  public var frameAmount:Int;

  /**
   * Current animation name.
   */
  public var currentAnimName:String;

  /**
   * Whether to loop the animation or not.
   */
  public var looping:Bool;

  public var isPlaying:Bool;

  /**
   * Creates a new sprite with the current bitmap.
   * In Addition to that defaults the frameHeight and frameWidth to 48.
   * @param bitmap 
   * @param width 
   * @param height 
   */
  public function new(bitmap:Bitmap, ?frameWidth:Int = 48,
      ?frameHeight:Int = 48) {
    super(bitmap);
    this.frameWidth = frameWidth;
    this.frameHeight = frameHeight;
    this.frameIndex = 0;
    this.looping = false;
    // Assuming 60 frames per second.
    this.setFPS(6);
    this.animations = new Map<String, Array<Int>>();
    if (this._frame != null) {
      this.setFrame(this._frame.x, this._frame.y, this.frameWidth,
        this.frameHeight);
    }
  }

  override public function update() {
    super.update();
    updateAnimationFrames();
  }

  public function updateAnimationFrames() {
    if (isPlaying) {
      if (frameWait <= 0) {
        this.frameWait = this.frameAmount;
        if (this.animations != null) {
          var frames = this.animations.get(currentAnimName);
          this.frameIndex++;

          if (this.frameIndex == frames.length && !looping) {
            isPlaying = false;
          }
          this.frameIndex = this.frameIndex % frames.length;

          var frameNumber = frames[this.frameIndex];
          this.setCurrentFrame(frameNumber);
        }
      } else {
        frameWait--;
      }
    }
  }

  public function setCurrentFrame(frameNumber:Int) {
    var columns = Math.floor(bitmap.width / frameWidth);
    var rows = Math.ceil(bitmap.height / frameHeight);
    var row = Math.floor(frameNumber / columns);
    var x = (frameWidth * ((frameNumber % columns) - 1)).clampf(0, 3000000);
    var y = (frameHeight * row);
    trace(columns, frameWidth, frameNumber, x, y);
    this.setFrame(x, y, frameWidth, frameHeight);
  }

  public function setFrameWidth(width:Int) {
    frameWidth = width;
    this.setFrame(this._frame.x, this._frame.y, frameWidth, this._frame.height);
    return this;
  }

  public function setFrameHeight(height:Int) {
    frameHeight = height;
    this.setFrame(this._frame.x, this._frame.y, this._frame.width, frameHeight);
    return this;
  }

  public function changeBitmap(bitmap:Bitmap) {
    this.bitmap = bitmap;
    return this;
  }

  public function addAnimation(animationName:String, frames:Array<Int>) {
    animations.set(animationName, frames);
    return this;
  }

  public function playAnimation(animationName:String, loop:Bool) {
    currentAnimName = animationName;
    isPlaying = true;
    looping = true;
    return this;
  }

  public function setFPS(fps:Int) {
    this.frameSpeed = fps;
    this.frameAmount = Math.ceil(60 / this.frameSpeed);
    this.frameWait = this.frameAmount;
    return this;
  }

  /**
   * Stops animating the sprite
   * @return 
   */
  public function stop() {
    isPlaying = false;
    looping = false;
  }
}