package gameJoltAPI;

// Manage trophies and achievements
class Trophies
{
	static private var className:String = "gameJoltAPI.Trophies";
	static public var result:Dynamic;
	static public var lastRequestSuccess(get, never):Bool;
	static private function get_lastRequestSuccess() : Bool
	{
		return result == null ? false : result.success == "true";
	}
	
	static public function fetch(username:String, user_token:String, ?achieved:Bool, ?trophy_id:Array<Int>)
	{
		var url:String;
		if(trophy_id != null && trophy_id.length > 1)
		{
			var arg = "";
			for(k in trophy_id)
				arg += Std.string(k) + ",";
			arg = arg.substr(0, arg.length - 1);
			url = Utils.formCall("trophies/", [ "game_id", "username", "user_token", "achieved", "trophy_id" ],
											  [ Std.string(Utils.game_id), username, user_token, achieved ? "true" : "false", arg ], 5);
		}
		else
			url = Utils.formCall("trophies/", [ "game_id", "username", "user_token", "achieved", "trophy_id" ],
											  [ Std.string(Utils.game_id), username, user_token, achieved ? "true" : "false", trophy_id != null ? Std.string(trophy_id[0]) : null ], 5);
		Utils.request(url, className);
	}
	
	static public function setAchieved(username:String, user_token:String, trophy_id:Int)
	{
		var url = Utils.formCall("trophies/add-achieved/", [ "game_id", "username", "user_token", "trophy_id" ],
														   [ Std.string(Utils.game_id), username, user_token, Std.string(trophy_id) ], 4);
		Utils.request(url, className);
	}
}