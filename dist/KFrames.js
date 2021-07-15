/** ============================================================================
 *
 *  KFrames.js
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
@plugindesc > A plugin that allows you to have elements of varying sizes. <KCFrames>

@target MV MZ

@command callEvent
@text Call Event
@desc Allows you to call an event from any map with any event ID


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

  {
    String.__name__ = true
    Array.__name__ = true
  }
  js_Boot.__toStr = {}.toString
  KCFrames.listener = new PIXI.utils.EventEmitter()
  KCFrames.KFrameSprite = kframes_KFrameSprite
  KCFrames.main()
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
