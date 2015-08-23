package gameJoltAPI;

import haxe.Http;
import haxe.Json;

class Users
{
	static public var lastRequestSuccess:Bool;
	static public var result:Dynamic;
	
    static public function fetch(?user_id:Array<Int>, ?username:String) : Void
	{
		var request = new Http(null);
		var url:String;
		if(user_id != null && user_id.length > 1)
		{
			var arg = "";
			for(k in user_id)
				arg += Std.string(k) + ",";
			arg = arg.substr(0, arg.length - 1);
			url = Utils.formCall("users/", [ "game_id", "user_id", "username", "format" ], [ Std.string(Utils.game_id), arg, username, "json" ], 4);
		}
		else
			url = Utils.formCall("users/", [ "game_id", "user_id", "username", "format" ],
										   [ Std.string(Utils.game_id), Std.string(user_id != null ? user_id[0] : null), username, "json" ], 4);
		
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	static public function auth(username:String, user_token:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("users/auth/", [ "game_id", "username", "user_token", "format" ], [ Std.string(Utils.game_id), username, user_token, "json" ], 4);
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