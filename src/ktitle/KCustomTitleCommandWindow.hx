package ktitle;

import rm.core.Rectangle;
import rm.windows.Window_Command;

class KCustomTitleCommandWindow extends Window_Command {
  override public function initialize(rect:Rectangle) {
    super.initialize(rect);
  }

  override public function standardFontFace() {
    return 'title-font';
  }
}