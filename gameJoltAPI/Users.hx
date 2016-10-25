package gameJoltAPI;

// Fetch information about users
class Users
{
	static private var className:String = "gameJoltAPI.Users";
	static public var result:Dynamic;
	static public var lastRequestSuccess(get, never):Bool;
	static private function get_lastRequestSuccess() : Bool
	{
		return result == null ? false : result.success == "true";
	}
	
    static public function fetch(?user_id:Array<Int>, ?username:String) : Void
	{
		var url:String;
		if(user_id != null && user_id.length > 1)
		{
			var arg = "";
			for(k in user_id)
				arg += Std.string(k) + ",";
			arg = arg.substr(0, arg.length - 1);
			url = Utils.formCall("users/", [ "game_id", "user_id", "username" ], [ Std.string(Utils.game_id), arg, username ], 3);
		}
		else
			url = Utils.formCall("users/", [ "game_id", "user_id", "username" ],
										   [ Std.string(Utils.game_id), Std.string(user_id != null ? user_id[0] : null), username ], 3);
		Utils.request(url, className);
	}
	
	static public function auth(username:String, user_token:String)
	{
		var url = Utils.formCall("users/auth/", [ "game_id", "username", "user_token" ], [ Std.string(Utils.game_id), username, user_token ], 3);
		Utils.request(url, className);
	}
}