package gameJoltAPI;

// Use cloud storage to store any form of data in the GameJolt servers
class DataStore
{
	static public var result:Dynamic;
	static public var lastRequestSuccess(get, never):Bool;
	static private function get_lastRequestSuccess() : Bool
	{
		return result == null ? false : result.success == "true";
	}
    
	static public function fetch(key:String, ?username:String, ?user_token:String, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("data-store/", [ "game_id", "key", "username", "user_token", "format" ], [ Std.string(Utils.game_id), key, username, user_token, "json" ], 5);
		Utils.request(url, result, onData, onError);
	}
	
	static public function set(key:String, data:String, ?username:String, ?user_token:String, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("data-store/set/", [ "game_id", "key", "data", "username", "user_token", "format" ],
													[ Std.string(Utils.game_id), key, data, username, user_token, "json" ], 6);
		Utils.request(url, result, onData, onError);
	}
	
	static public function update(key:String, operation:String, value:String, ?username:String, ?user_token:String, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("data-store/update/", [ "game_id", "key", "operation", "value", "username", "user_token", "format" ],
													   [ Std.string(Utils.game_id), key, operation, value, username, user_token, "json" ], 7);
		Utils.request(url, result, onData, onError);
	}
	
	static public function remove(key:String, ?username:String, ?user_token:String, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("data-store/remove/", [ "game_id", "key", "username", "user_token", "format" ], [ Std.string(Utils.game_id), key, username, user_token, "json" ], 5);
		Utils.request(url, result, onData, onError);
	}
	
	static public function getKeys(?username:String, ?user_token:String, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("data-store/get-keys/", [ "game_id", "username", "user_token", "format" ], [ Std.string(Utils.game_id), username, user_token, "json" ], 4);
		Utils.request(url, result, onData, onError);
	}
}