package gameJoltAPI;

import haxe.Http;
import haxe.Json;

class DataStore
{
	static public var lastRequestSuccess:Bool;
	static public var result:Dynamic;
    
	static public function fetch(key:String, ?username:String, ?user_token:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("data-store/", [ "game_id", "key", "username", "user_token", "format" ], [ Std.string(Utils.game_id), key, username, user_token, "json" ], 5);
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	static public function set(key:String, data:String, ?username:String, ?user_token:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("data-store/set/", [ "game_id", "key", "data", "username", "user_token", "format" ],
													[ Std.string(Utils.game_id), key, data, username, user_token, "json" ], 6);
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	static public function update(key:String, operation:String, value:String, ?username:String, ?user_token:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("data-store/update/", [ "game_id", "key", "operation", "value", "username", "user_token", "format" ],
													   [ Std.string(Utils.game_id), key, operation, value, username, user_token, "json" ], 7);
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	static public function remove(key:String, ?username:String, ?user_token:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("data-store/remove/", [ "game_id", "key", "username", "user_token", "format" ], [ Std.string(Utils.game_id), key, username, user_token, "json" ], 5);
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	static public function getKeys(?username:String, ?user_token:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("data-store/get-keys/", [ "game_id", "username", "user_token", "format" ], [ Std.string(Utils.game_id), username, user_token, "json" ], 4);
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