typedef KParams = {};

@:native('KCFrames')
@:expose('KCFrames')
class Main {
	public static var Params:KParams = null;
	public static var listener:EventEmitter = createEventEmitter();

	public static function main() {
		var plugin = Globals.Plugins.filter((plugin) -> ~/<KCFrames>/ig.match(plugin.description))[0];
		var params = plugin.parameters;
		Params = {};
		trace(Params, params);
	}

	public static function params() {
		return Params;
	}
}
