package gameJoltAPI;

// Manage game sessions ; allows you to see in real time who is playing your game
class Sessions
{
	static private var className:String = "gameJoltAPI.Sessions";
	static public var result:Dynamic;
	static public var lastRequestSuccess(get, never):Bool;
	static private function get_lastRequestSuccess() : Bool
	{
		return result == null ? false : result.success == "true";
	}
	
	static public function open(username:String, user_token:String, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("sessions/open/", [ "game_id", "username", "user_token" ], [ Std.string(Utils.game_id), username, user_token ], 3);
		Utils.request(url, className, onData, onError);
	}
	
	static public function ping(username:String, user_token:String, ?status:String, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("sessions/ping/", [ "game_id", "username", "user_token", "status" ], [ Std.string(Utils.game_id), username, user_token ], 4);
		Utils.request(url, className, onData, onError);
	}
	
	static public function check(username:String, user_token:String, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("sessions/check/", [ "game_id", "username", "user_token" ], [ Std.string(Utils.game_id), username, user_token ], 3);
		Utils.request(url, className, onData, onError);
	}
	
	static public function close(username:String, user_token:String, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("sessions/close/", [ "game_id", "username", "user_token" ], [ Std.string(Utils.game_id), username, user_token ], 3);
		Utils.request(url, className, onData, onError);
	}
}