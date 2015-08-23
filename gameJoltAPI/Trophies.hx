package gameJoltAPI;

import haxe.Http;
import haxe.Json;

class Trophies
{
	static public var lastRequestSuccess:Bool;
	static public var result:Dynamic;
	
	static public function fetch(username:String, user_token:String, ?achieved:Bool, ?trophy_id:Array<Int>)
	{
		var request = new Http(null);
		var url:String;
		if(trophy_id != null && trophy_id.length > 1)
		{
			var arg = "";
			for(k in trophy_id)
				arg += Std.string(k) + ",";
			arg = arg.substr(0, arg.length - 1);
			url = Utils.formCall("trophies/", [ "game_id", "username", "user_token", "achieved", "trophy_id", "format" ],
											  [ Std.string(Utils.game_id), username, user_token, achieved ? "true" : "false", arg, "json" ], 6);
		}
		else
			url = Utils.formCall("trophies/", [ "game_id", "username", "user_token", "achieved", "trophy_id", "format" ],
											  [ Std.string(Utils.game_id), username, user_token, achieved ? "true" : "false", trophy_id != null ? Std.string(trophy_id[0]) : null, "json" ], 6);
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	static public function addAchieved(username:String, user_token:String, trophy_id:Int)
	{
		var request = new Http(null);
		var url = Utils.formCall("trophies/add-achieved/", [ "game_id", "username", "user_token", "trophy_id", "format" ],
														   [ Std.string(Utils.game_id), username, user_token, Std.string(trophy_id), "json" ], 5);
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	// HTTP onData callback
	static private function writeData(data:String)
	{
		var obj = Json.parse(data);
		lastRequestSuccess = obj.response.success == "true";
		if(lastRequestSuccess)
			result = obj.response;
	}
}