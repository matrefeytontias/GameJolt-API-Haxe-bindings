package gameJoltAPI;

// Get server time and info
class GetTime
{
	static private var className:String = "gameJoltAPI.GetTime";
	static public var result:Dynamic;
	static public var lastRequestSuccess(get, never):Bool;
	static private function get_lastRequestSuccess() : Bool
	{
		return result == null ? false : result.success == "true";
	}
	
	static public function fetch(?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("get-time/", ["game_id"], [Std.string(Utils.game_id)], 1);
		Utils.request(url, className, onData, onError);
	}
}
