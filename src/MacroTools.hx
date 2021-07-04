import haxe.Json;
import sys.io.File;
import sys.FileSystem;
import haxe.macro.Expr;

typedef Dino = {Name:String, Description:String};

macro function createDinoData(filePath:String):Expr {
  if (FileSystem.exists(filePath)) {
    var content:Array<Dino> = Json.parse(File.getContent(filePath));
    return macro $v{content};
  }
  return null;
}