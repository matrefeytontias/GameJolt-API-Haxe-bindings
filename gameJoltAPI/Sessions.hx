package gameJoltAPI;

import haxe.Http;
import haxe.Json;

class Sessions
{
	static public var lastRequestSuccess:Bool;
	static public var result:Dynamic;
	
	static public function open(username:String, user_token:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("sessions/open/", [ "game_id", "username", "user_token", "format" ], [ Std.string(Utils.game_id), username, Std.string(user_token), "json" ], 4);
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	static public function ping(username:String, user_token:String, ?status:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("sessions/ping/", [ "game_id", "username", "user_token", "status", "format" ], [ Std.string(Utils.game_id), username, Std.string(user_token), "json" ], 5);
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	static public function close(username:String, user_token:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("sessions/close/", [ "game_id", "username", "user_token", "format" ], [ Std.string(Utils.game_id), username, Std.string(user_token), "json" ], 4);
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