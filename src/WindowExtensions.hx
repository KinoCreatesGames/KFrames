import rm.core.TouchInput;
import rm.windows.Window_Base;

class WindowExtensions {
  public static function isTouchedInsideFrame(win:Window_Base) {
    var x = win.canvasToLocalX(TouchInput.x);
    var y = win.canvasToLocalY(TouchInput.y);
    return x >= 0 && y >= 0 && x < win.width && y < win.height;
  }

  public static function isOpenOrVisible(win:Window_Base) {
    return win.isOpen() || win.visible;
  }
}