/** ============================================================================
 *
 *  KTitleMV.js
 * 
 *  Build Date: 7/14/2021
 * 
 *  Made with LunaTea -- Haxe
 *
 * =============================================================================
*/
// Generated by Haxe 4.2.1+bf9ff69
/*:
@author  KinoCreates - Kino
@plugindesc > A plugin that creates a custom title scene <KTitle>.

@target MV MZ

@help
==== How To Use ====


MIT License
Copyright (c) 2021 KinoCreates
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE
*/

(function ($hx_exports, $global) {
  "use strict"
  var $estr = function () {
      return js_Boot.__string_rec(this, "");
    },
    $hxEnums = $hxEnums || {}
  class EReg {
    constructor(r, opt) {
      this.r = new RegExp(r, opt.split("u").join(""))
    }
    match(s) {
      if (this.r.global) {
        this.r.lastIndex = 0
      }
      this.r.m = this.r.exec(s)
      this.r.s = s
      return this.r.m != null;
    }
  }

  EReg.__name__ = true
  Math.__name__ = true
  class Reflect {
    static fields(o) {
      let a = []
      if (o != null) {
        let hasOwnProperty = Object.prototype.hasOwnProperty
        for (var f in o) {
          if (
            f != "__id__" &&
            f != "hx__closures__" &&
            hasOwnProperty.call(o, f)
          ) {
            a.push(f)
          }
        }
      }
      return a;
    }
  }

  Reflect.__name__ = true
  class Std {
    static string(s) {
      return js_Boot.__string_rec(s, "");
    }
  }

  Std.__name__ = true
  function core_MathExt_lerp(start, end, amount) {
    return start + (end - start) * amount;
  }
  class haxe_Exception extends Error {
    constructor(message, previous, native) {
      super(message);
      this.message = message
      this.__previousException = previous
      this.__nativeException = native != null ? native : this
    }
    get_native() {
      return this.__nativeException;
    }
    static thrown(value) {
      if (value instanceof haxe_Exception) {
        return value.get_native();
      } else if (value instanceof Error) {
        return value;
      } else {
        let e = new haxe_ValueException(value)
        return e;
      }
    }
  }

  haxe_Exception.__name__ = true
  class haxe_ValueException extends haxe_Exception {
    constructor(value, previous, native) {
      super(String(value), previous, native);
      this.value = value
    }
  }

  haxe_ValueException.__name__ = true
  class haxe_ds_StringMap {
    constructor() {
      this.h = Object.create(null)
    }
  }

  haxe_ds_StringMap.__name__ = true
  class haxe_iterators_ArrayIterator {
    constructor(array) {
      this.current = 0
      this.array = array
    }
    hasNext() {
      return this.current < this.array.length;
    }
    next() {
      return this.array[this.current++];
    }
  }

  haxe_iterators_ArrayIterator.__name__ = true
  class js_Boot {
    static __string_rec(o, s) {
      if (o == null) {
        return "null";
      }
      if (s.length >= 5) {
        return "<...>";
      }
      let t = typeof o
      if (t == "function" && (o.__name__ || o.__ename__)) {
        t = "object"
      }
      switch (t) {
        case "function":
          return "<function>";
        case "object":
          if (o.__enum__) {
            let e = $hxEnums[o.__enum__]
            let con = e.__constructs__[o._hx_index]
            let n = con._hx_name
            if (con.__params__) {
              s = s + "\t"
              return (
                n +
                "(" +
                (function ($this) {
                  var $r
                  let _g = []
                  {
                    let _g1 = 0
                    let _g2 = con.__params__
                    while (true) {
                      if (!(_g1 < _g2.length)) {
                        break
                      }
                      let p = _g2[_g1]
                      _g1 = _g1 + 1
                      _g.push(js_Boot.__string_rec(o[p], s))
                    }
                  }
                  $r = _g
                  return $r;
                })(this).join(",") +
                ")"
              )
            } else {
              return n;
            }
          }
          if (o instanceof Array) {
            let str = "["
            s += "\t";
            let _g = 0
            let _g1 = o.length
            while (_g < _g1) {
              let i = _g++
              str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i], s);
            }
            str += "]";
            return str;
          }
          let tostr
          try {
            tostr = o.toString
          } catch (_g) {
            return "???";
          }
          if (
            tostr != null &&
            tostr != Object.toString &&
            typeof tostr == "function"
          ) {
            let s2 = o.toString()
            if (s2 != "[object Object]") {
              return s2;
            }
          }
          let str = "{\n"
          s += "\t";
          let hasp = o.hasOwnProperty != null
          let k = null
          for (k in o) {
            if (hasp && !o.hasOwnProperty(k)) {
              continue
            }
            if (
              k == "prototype" ||
              k == "__class__" ||
              k == "__super__" ||
              k == "__interfaces__" ||
              k == "__properties__"
            ) {
              continue
            }
            if (str.length != 2) {
              str += ", \n";
            }
            str += s + k + " : " + js_Boot.__string_rec(o[k], s);
          }
          s = s.substring(1)
          str += "\n" + s + "}";
          return str;
        case "string":
          return o;
        default:
          return String(o);
      }
    }
  }

  js_Boot.__name__ = true
  class kframes_KFrameSprite extends Sprite {
    constructor(bitmap, frameWidth, frameHeight) {
      if (frameHeight == null) {
        frameHeight = 48
      }
      if (frameWidth == null) {
        frameWidth = 48
      }
      super(bitmap);
      this.frameWidth = frameWidth
      this.frameHeight = frameHeight
      this.frameIndex = 0
      this.looping = false
      this.setFPS(6)
      this.animations = new haxe_ds_StringMap()
      if (this._frame != null) {
        this.setFrame(
          this._frame.x,
          this._frame.y,
          this.frameWidth,
          this.frameHeight
        )
      }
    }
    update() {
      super.update()
      this.updateAnimationFrames()
    }
    updateAnimationFrames() {
      if (this.isPlaying) {
        if (this.frameWait <= 0) {
          this.frameWait = this.frameAmount
          if (this.animations != null) {
            let frames = this.animations.h[this.currentAnimName]
            if (this.frameIndex == frames.length && !this.looping) {
              this.isPlaying = false
            }
            this.frameIndex %= frames.length
            this.setCurrentFrame(frames[this.frameIndex])
            this.frameIndex++
          }
        } else {
          this.frameWait--
        }
      }
    }
    setCurrentFrame(frameNumber) {
      let columns = Math.floor(this.bitmap.width / this.frameWidth)
      this.setFrame(
        Math.min(
          Math.max(this.frameWidth * (frameNumber % columns), 0),
          3000000
        ),
        this.frameHeight * Math.floor(frameNumber / columns),
        this.frameWidth,
        this.frameHeight
      )
    }
    setFrameWidth(width) {
      this.frameWidth = width
      this.setFrame(
        this._frame.x,
        this._frame.y,
        this.frameWidth,
        this._frame.height
      )
      return this;
    }
    setFrameHeight(height) {
      this.frameHeight = height
      this.setFrame(
        this._frame.x,
        this._frame.y,
        this._frame.width,
        this.frameHeight
      )
      return this;
    }
    changeBitmap(bitmap) {
      this.bitmap = bitmap
      return this;
    }
    addAnimation(animationName, frames) {
      this.animations.h[animationName] = frames
      return this;
    }
    playAnimation(animationName, loop) {
      this.currentAnimName = animationName
      this.isPlaying = true
      this.looping = true
      return this;
    }
    setFPS(fps) {
      this.frameSpeed = fps
      this.frameAmount = Math.ceil(60 / this.frameSpeed)
      this.frameWait = this.frameAmount
      return this;
    }
    stop() {
      this.isPlaying = false
      this.looping = false
    }
  }

  kframes_KFrameSprite.__name__ = true
  class KCFrames {
    static main() {
      let _this = $plugins
      let _g = []
      let _g1 = 0
      while (_g1 < _this.length) {
        let v = _this[_g1]
        ++_g1
        if (new EReg("<KCFrames>", "ig").match(v.description)) {
          _g.push(v)
        }
      }
      KCFrames.Params = {}
    }
    static params() {
      return KCFrames.Params;
    }
    static createSprite(path, frameWidth, frameHeight) {
      if (frameHeight == null) {
        frameHeight = 48
      }
      if (frameWidth == null) {
        frameWidth = 48
      }
      return new kframes_KFrameSprite(
        ImageManager.loadPicture(path),
        frameWidth,
        frameHeight
      )
    }
    static addToScene(kframeSprite) {
      SceneManager._scene.addChild(kframeSprite)
      return kframeSprite;
    }
  }

  $hx_exports["KCFrames"] = KCFrames
  KCFrames.__name__ = true
  class KCustomTitleScene extends Scene_Title {
    constructor() {
      super();
    }
    create() {
      _Scene_Title_create.call(this)
      this.setupParameters()
      this.createScrollingContainer()
      this.createCharacter()
      this.createBalconyRailing()
      this.adjustChildren()
    }
    setupParameters() {
      this.titleTimer = 150
      this.skipScroll = false
      this.skipScrollComplete = false
    }
    adjustChildren() {
      this.addChild(this.customBackground)
      this.addChild(this.scrollingContainer)
      this.scrollingContainer.addChild(this.foregroundBalcony)
      this.scrollingContainer.addChild(this.yula)
      this.scrollingContainer.addChild(this.foregroundBalconyRailing)
      this.addChild(this._gameTitleSprite)
      this.addChild(this._windowLayer)
    }
    createScrollingContainer() {
      this.scrollingContainer = new Sprite()
      this.scrollingContainer.y = 600
    }
    createCharacter() {
      this.yula = KCFrames.createSprite("Yula_Walk-Idle_51x103", 51, 103)
      this.yula.addAnimation("walk", [0, 1, 2, 3, 4, 5, 6, 7])
      this.yula.addAnimation("idle", [16, 17, 18, 19, 20, 21, 22, 23])
      this.yula.playAnimation("idle", true)
      this.yula.setFPS(18)
      this.yula.x = 528
      this.yula.y = 276
      this.yula.scale.y = 2
      this.yula.scale.x = -2
    }
    createBalconyRailing() {
      let bitmap = ImageManager.loadPicture("House_Balcony_Abv-Player_408x312")
      this.foregroundBalconyRailing = new Sprite()
      let _gthis = this
      bitmap.addLoadListener(function (loadedBitmap) {
        _gthis.foregroundBalconyRailing.bitmap = loadedBitmap
        _gthis.scaleSprite(_gthis.foregroundBalconyRailing)
      })
    }
    createBackground() {
      let bitmap = ImageManager.loadPicture("Night-Sky_BG")
      this.customBackground = new TilingSprite(
        new Bitmap(Graphics.width, Graphics.height)
      )
      let _gthis = this
      bitmap.addLoadListener(function (loadedBitmap) {
        _gthis.customBackground.bitmap = loadedBitmap
        _gthis.customBackground.move(
          0,
          0,
          loadedBitmap.width,
          loadedBitmap.height
        )
        _gthis.customBackground.y -= 80
        _gthis.customBackground.scale.y = 1.2
        _gthis.customBackground.scale.x = 1.2
      })
    }
    createForeground() {
      let bitmap = ImageManager.loadPicture("House_Balcony_408x312")
      this.foregroundBalcony = new Sprite()
      this._gameTitleSprite = new Sprite(
        new Bitmap(Graphics.width, Graphics.height)
      )
      let _gthis = this
      bitmap.addLoadListener(function (loadedBitmap) {
        _gthis.foregroundBalcony.bitmap = loadedBitmap
        _gthis.scaleSprite(_gthis.foregroundBalcony)
      })
      if ($dataSystem.optDrawTitle) {
        this.drawGameTitle()
      }
    }
    adjustBackground() {}
    update() {
      _Scene_Title_update.call(this)
      this.updateTitleState()
      this.updateCustomBackground()
    }
    updateTitleState() {
      if (
        (Input.isPressed("ok") ||
          Input.isPressed("cancel") ||
          TouchInput.isCancelled() ||
          TouchInput.isPressed()) &&
        !this.skipScroll
      ) {
        this.skipScroll = true
        this.startFadeOut(30, false)
      }
      if (
        this.skipScroll &&
        this._fadeDuration <= 0 &&
        !this.skipScrollComplete
      ) {
        this.scrollingContainer.y = 0
        this.startFadeIn(30, false)
        this.skipScrollComplete = true
        if (this.scrollingContainer.y == 0) {
          this._commandWindow.visible = true
          this._commandWindow.open()
        }
      } else if (this.titleTimer <= 0) {
        if (this.scrollingContainer.y >= 0) {
          this.scrollingContainer.y = Math.min(
            Math.max(
              core_MathExt_lerp(this.scrollingContainer.y, -10, 0.0025),
              0
            ),
            600
          )
          let num = this.scrollingContainer.y
          if (num >= 0 && num <= 75) {
            this.scrollingContainer.y = Math.min(
              Math.max(
                core_MathExt_lerp(this.scrollingContainer.y, -100, 0.0025),
                0
              ),
              600
            )
          }
        }
        if (this.scrollingContainer.y == 0) {
          this._commandWindow.visible = true
          this._commandWindow.open()
        }
      } else {
        this.titleTimer--
      }
    }
    updateCustomBackground() {
      this.customBackground.origin.x = (TouchInput.x - Graphics.width / 2) / 10
      this.customBackground.origin.y =
        (TouchInput.y - Graphics.height / 2) / 10
    }
    createCommandWindow() {
      const background = $dataSystem.titleCommandWindow.background
      const rect = this.commandWindowRect()
      this._commandWindow = new Window_TitleCommand(rect)
      this._commandWindow.makeCommandList = function () {
        this.addCommand(TextManager.newGame, "newGame")
        this.addCommand(TextManager.options, "options")
      }
      this._commandWindow.setBackgroundType(background)
      this._commandWindow.setHandler("newGame", this.commandNewGame.bind(this))
      this._commandWindow.setHandler("options", this.commandOptions.bind(this))
      this._commandWindow.contents.fontFace = "title-font"
      this._commandWindow.refresh()
      this._commandWindow.setBackgroundType(2)
      this._commandWindow.visible = false
      this.addWindow(this._commandWindow)
    }
    drawGameTitle() {
      let x = 20
      let y = Graphics.height / 4
      let maxWidth = Graphics.width - x * 2
      let text = $dataSystem.gameTitle
      let bitmap = this._gameTitleSprite.bitmap
      bitmap.fontFace = "title-font"
      bitmap.outlineColor = "black"
      bitmap.outlineWidth = 8
      bitmap.fontSize = 72
      bitmap.drawText(text, x, y, maxWidth, 48, "center")
    }
    terminate() {
      Scene_Base.prototype.terminate.call(this)
      SceneManager.snapForBackground()
    }
  }

  $hx_exports["KcustomTitleScene"] = KCustomTitleScene
  KCustomTitleScene.__name__ = true
  class KTitle {
    static main() {
      let _g = []
      let _g1 = 0
      let _g2 = $plugins
      while (_g1 < _g2.length) {
        let v = _g2[_g1]
        ++_g1
        if (new EReg("<KTitle>", "ig").match(v.description)) {
          _g.push(v)
        }
      }
      let plugin = _g[0]
      let _Scene_Title_yula = Scene_Title.prototype.yula
      Scene_Title.prototype.yula = null
      let _Scene_Title_customBackground =
        Scene_Title.prototype.customBackground
      Scene_Title.prototype.customBackground = null
      let _Scene_Title_foregroundBalcony =
        Scene_Title.prototype.foregroundBalcony
      Scene_Title.prototype.foregroundBalcony = null
      let _Scene_Title_foregroundBalconyRailing =
        Scene_Title.prototype.foregroundBalconyRailing
      Scene_Title.prototype.foregroundBalconyRailing = null
      let _Scene_Title_scrollingContainer =
        Scene_Title.prototype.scrollingContainer
      Scene_Title.prototype.scrollingContainer = null
      let _Scene_Title_titleTimer = Scene_Title.prototype.titleTimer
      Scene_Title.prototype.titleTimer = null
      let _Scene_Title_skipScroll = Scene_Title.prototype.skipScroll
      Scene_Title.prototype.skipScroll = null
      let _Scene_Title_skipScrollComplete =
        Scene_Title.prototype.skipScrollComplete
      Scene_Title.prototype.skipScrollComplete = null
      let _Scene_Title_create = Scene_Title.prototype.create
      Scene_Title.prototype.create = function () {
        _Scene_Title_create.call(this)
        this.setupParameters()
        this.createScrollingContainer()
        this.createCharacter()
        this.createBalconyRailing()
        this.adjustChildren()
      }
      let _Scene_Title_setupParameters = Scene_Title.prototype.setupParameters
      Scene_Title.prototype.setupParameters = function () {
        this.titleTimer = 150
        this.skipScroll = false
        this.skipScrollComplete = false
      }
      let _Scene_Title_adjustChildren = Scene_Title.prototype.adjustChildren
      Scene_Title.prototype.adjustChildren = function () {
        this.addChild(this.customBackground)
        this.addChild(this.scrollingContainer)
        this.scrollingContainer.addChild(this.foregroundBalcony)
        this.scrollingContainer.addChild(this.yula)
        this.scrollingContainer.addChild(this.foregroundBalconyRailing)
        this.addChild(this._gameTitleSprite)
        this.addChild(this._windowLayer)
      }
      let _Scene_Title_createScrollingContainer =
        Scene_Title.prototype.createScrollingContainer
      Scene_Title.prototype.createScrollingContainer = function () {
        this.scrollingContainer = new Sprite()
        this.scrollingContainer.y = 600
      }
      let _Scene_Title_createCharacter = Scene_Title.prototype.createCharacter
      Scene_Title.prototype.createCharacter = function () {
        this.yula = KCFrames.createSprite("Yula_Walk-Idle_51x103", 51, 103)
        this.yula.addAnimation("walk", [0, 1, 2, 3, 4, 5, 6, 7])
        this.yula.addAnimation("idle", [16, 17, 18, 19, 20, 21, 22, 23])
        this.yula.playAnimation("idle", true)
        this.yula.setFPS(18)
        this.yula.x = 528
        this.yula.y = 276
        this.yula.scale.y = 2
        this.yula.scale.x = -2
      }
      let _Scene_Title_createBalconyRailing =
        Scene_Title.prototype.createBalconyRailing
      Scene_Title.prototype.createBalconyRailing = function () {
        let bitmap = ImageManager.loadPicture(
          "House_Balcony_Abv-Player_408x312"
        )
        this.foregroundBalconyRailing = new Sprite()
        let _gthis = this
        bitmap.addLoadListener(function (loadedBitmap) {
          _gthis.foregroundBalconyRailing.bitmap = loadedBitmap
          _gthis.scaleSprite(_gthis.foregroundBalconyRailing)
        })
      }
      let _Scene_Title_createBackground =
        Scene_Title.prototype.createBackground
      Scene_Title.prototype.createBackground = function () {
        let bitmap = ImageManager.loadPicture("Night-Sky_BG")
        this.customBackground = new TilingSprite(
          new Bitmap(Graphics.width, Graphics.height)
        )
        let _gthis = this
        bitmap.addLoadListener(function (loadedBitmap) {
          _gthis.customBackground.bitmap = loadedBitmap
          _gthis.customBackground.move(
            0,
            0,
            loadedBitmap.width,
            loadedBitmap.height
          )
          _gthis.customBackground.y -= 80
          _gthis.customBackground.scale.y = 1.2
          _gthis.customBackground.scale.x = 1.2
        })
      }
      let _Scene_Title_createForeground =
        Scene_Title.prototype.createForeground
      Scene_Title.prototype.createForeground = function () {
        let bitmap = ImageManager.loadPicture("House_Balcony_408x312")
        this.foregroundBalcony = new Sprite()
        this._gameTitleSprite = new Sprite(
          new Bitmap(Graphics.width, Graphics.height)
        )
        let _gthis = this
        bitmap.addLoadListener(function (loadedBitmap) {
          _gthis.foregroundBalcony.bitmap = loadedBitmap
          _gthis.scaleSprite(_gthis.foregroundBalcony)
        })
        if ($dataSystem.optDrawTitle) {
          this.drawGameTitle()
        }
      }
      let _Scene_Title_adjustBackground =
        Scene_Title.prototype.adjustBackground
      Scene_Title.prototype.adjustBackground = function () {}
      let _Scene_Title_update = Scene_Title.prototype.update
      Scene_Title.prototype.update = function () {
        _Scene_Title_update.call(this)
        this.updateTitleState()
        this.updateCustomBackground()
      }
      let _Scene_Title_updateTitleState =
        Scene_Title.prototype.updateTitleState
      Scene_Title.prototype.updateTitleState = function () {
        let buttonClicked =
          Input.isPressed("ok") ||
          Input.isPressed("cancel") ||
          TouchInput.isCancelled() ||
          TouchInput.isPressed()
        if (buttonClicked && !this.skipScroll) {
          this.skipScroll = true
          this.startFadeOut(30, false)
        }
        if (
          this.skipScroll &&
          this._fadeDuration <= 0 &&
          !this.skipScrollComplete
        ) {
          this.scrollingContainer.y = 0
          this.startFadeIn(30, false)
          this.skipScrollComplete = true
          if (this.scrollingContainer.y == 0) {
            this._commandWindow.visible = true
            this._commandWindow.open()
          }
        } else if (this.titleTimer <= 0) {
          if (this.scrollingContainer.y >= 0) {
            this.scrollingContainer.y = Math.min(
              Math.max(
                core_MathExt_lerp(this.scrollingContainer.y, -10, 0.0025),
                0
              ),
              600
            )
            let num = this.scrollingContainer.y
            if (num >= 0 && num <= 75) {
              this.scrollingContainer.y = Math.min(
                Math.max(
                  core_MathExt_lerp(this.scrollingContainer.y, -100, 0.0025),
                  0
                ),
                600
              )
            }
          }
          if (this.scrollingContainer.y == 0) {
            this._commandWindow.visible = true
            this._commandWindow.open()
          }
        } else {
          this.titleTimer--
        }
      }
      let _Scene_Title_updateCustomBackground =
        Scene_Title.prototype.updateCustomBackground
      Scene_Title.prototype.updateCustomBackground = function () {
        let offsetFromCenterX = TouchInput.x - Graphics.width / 2
        let offsetFromCenterY = TouchInput.y - Graphics.height / 2
        let movementScaleX = offsetFromCenterX / 10
        let movementScaleY = offsetFromCenterY / 10
        this.customBackground.origin.x = movementScaleX
        this.customBackground.origin.y = movementScaleY
      }
      let _Scene_Title_createCommandWindow =
        Scene_Title.prototype.createCommandWindow
      Scene_Title.prototype.createCommandWindow = function () {
        const background = $dataSystem.titleCommandWindow.background
        const rect = this.commandWindowRect()
        this._commandWindow = new Window_TitleCommand(rect)
        this._commandWindow.makeCommandList = function () {
          this.addCommand(TextManager.newGame, "newGame")
          this.addCommand(TextManager.options, "options")
        }
        this._commandWindow.setBackgroundType(background)
        this._commandWindow.setHandler(
          "newGame",
          this.commandNewGame.bind(this)
        )
        this._commandWindow.setHandler(
          "options",
          this.commandOptions.bind(this)
        )
        this._commandWindow.contents.fontFace = "title-font"
        this._commandWindow.refresh()
        this._commandWindow.setBackgroundType(2)
        this._commandWindow.visible = false
        this.addWindow(this._commandWindow)
      }
      let _Scene_Title_drawGameTitle = Scene_Title.prototype.drawGameTitle
      Scene_Title.prototype.drawGameTitle = function () {
        let x = 20
        let y = Graphics.height / 4
        let maxWidth = Graphics.width - x * 2
        let text = $dataSystem.gameTitle
        let bitmap = this._gameTitleSprite.bitmap
        bitmap.fontFace = "title-font"
        bitmap.outlineColor = "black"
        bitmap.outlineWidth = 8
        bitmap.fontSize = 72
        bitmap.drawText(text, x, y, maxWidth, 48, "center")
      }
      let _Scene_Title_terminate = Scene_Title.prototype.terminate
      Scene_Title.prototype.terminate = function () {
        Scene_Base.prototype.terminate.call(this)
        SceneManager.snapForBackground()
      }
    }
  }

  $hx_exports["KTitle"] = KTitle
  KTitle.__name__ = true

  class FontManager {
    static load(family, filename) {
      if (FontManager._states[family] != "loaded") {
        if (filename != null) {
          FontManager.startLoading(family, FontManager.makeUrl(filename))
        } else {
          FontManager._urls[family] = ""
          FontManager._states[family] = "loaded"
        }
      }
    }
    static isReady() {
      let access = FontManager._states
      let _g_keys = Reflect.fields(access)
      let _g_index = 0
      while (_g_index < _g_keys.length) {
        let family = access[_g_keys[_g_index++]]
        let state = FontManager._states[family]
        if (state == "loading") {
          return false;
        }
        if (state == "error") {
          FontManager.throwLoadError(family)
        }
      }
      return true;
    }
    static startLoading(family, url) {
      let sourceUrl = "url(" + url + ")"
      let font = new FontFace(family, sourceUrl)
      FontManager._urls[family] = sourceUrl
      FontManager._states[family] = "loading"
      font
        .load()
        .then(function (loadedFont) {
          window.document.fonts.add(font)
          FontManager._states[family] = "loaded"
          return 0;
        })
        .catch(function (_) {
          return (FontManager._states[family] = "error");
        })
    }
    static throwLoadError(family) {
      let url = FontManager._urls[family]
      let retry = function () {
        FontManager.startLoading(family, url)
      }
      throw haxe_Exception.thrown(["LoadError", url, retry])
    }
    static makeUrl(fileName) {
      return (
        "fonts/" + Std.string(encodeURIComponent(fileName).replace(/%2F/g, "/"))
      )
    }
    static load(family, filename) {
      if (FontManager._states[family] != "loaded") {
        if (filename != null) {
          FontManager.startLoading(family, FontManager.makeUrl(filename))
        } else {
          FontManager._urls[family] = ""
          FontManager._states[family] = "loaded"
        }
      }
    }
    static isReady() {
      let access = FontManager._states
      let _g_keys = Reflect.fields(access)
      let _g_index = 0
      while (_g_index < _g_keys.length) {
        let family = access[_g_keys[_g_index++]]
        let state = FontManager._states[family]
        if (state == "loading") {
          return false;
        }
        if (state == "error") {
          FontManager.throwLoadError(family)
        }
      }
      return true;
    }
    static startLoading(family, url) {
      let sourceUrl = "url(" + url + ")"
      let font = new FontFace(family, sourceUrl)
      FontManager._urls[family] = sourceUrl
      FontManager._states[family] = "loading"
      font
        .load()
        .then(function (loadedFont) {
          window.document.fonts.add(font)
          FontManager._states[family] = "loaded"
          return 0;
        })
        .catch(function (_) {
          return (FontManager._states[family] = "error");
        })
    }
    static throwLoadError(family) {
      let url = FontManager._urls[family]
      let retry = function () {
        FontManager.startLoading(family, url)
      }
      throw haxe_Exception.thrown(["LoadError", url, retry])
    }
    static makeUrl(fileName) {
      return (
        "fonts/" + Std.string(encodeURIComponent(fileName).replace(/%2F/g, "/"))
      )
    }
  }

  $hx_exports["FontManager"] = FontManager
  FontManager.__name__ = true
  {
    String.__name__ = true
    Array.__name__ = true
  }
  js_Boot.__toStr = {}.toString
  KCFrames.listener = new PIXI.utils.EventEmitter()
  KCFrames.KFrameSprite = kframes_KFrameSprite
  KTitle.main()
})(
  typeof exports != "undefined"
    ? exports
    : typeof window != "undefined"
    ? window
    : typeof self != "undefined"
    ? self
    : this,
  {}
)
