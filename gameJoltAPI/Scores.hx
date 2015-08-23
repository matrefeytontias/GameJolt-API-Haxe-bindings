package gameJoltAPI;

import haxe.Http;
import haxe.Json;

class Scores
{
	static public var lastRequestSuccess:Bool;
	static public var result:Dynamic;
	
	static public function fetch(?username:String, ?user_token:String, ?limit:Int, ?table_id:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("scores/", [ "game_id", "username", "user_token", "limit", "table_id", "format" ],
											[ Std.string(Utils.game_id), username, user_token, Std.string(limit), table_id, "json" ], 6);
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	static public function add(score:String, sort:Int, ?username:String, ?user_token:String, ?guest:String, ?extra_data:String, ?table_id:String)
	{
		var request = new Http(null);
		var url = Utils.formCall("scores/add/", [ "game_id", "score", "sort", "username", "user_token", "guest", "extra_data", "table_id", "format" ],
											[ Std.string(Utils.game_id), score, Std.string(sort), username, user_token, guest, extra_data, table_id, "json" ], 9);
		request.url = url;
		request.onData = writeData;
		request.request();
	}
	
	static public function tables()
	{
		var request = new Http(null);
		var url = Utils.formCall("scores/tables/", [ "game_id", "format" ], [ Std.string(Utils.game_id), "json" ], 2);
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