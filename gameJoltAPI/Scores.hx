package gameJoltAPI;

// Manage score tables, scores and rankings
class Scores
{
	static private var className:String = "gameJoltAPI.Scores";
	static public var result:Dynamic;
	static public var lastRequestSuccess(get, never):Bool;
	static private function get_lastRequestSuccess() : Bool
	{
		return result == null ? false : result.success == "true";
	}
	
	static public function fetch(?username:String, ?user_token:String, ?limit:Int, ?table_id:Int, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("scores/", [ "game_id", "username", "user_token", "limit", "table_id", "format" ],
											[ Std.string(Utils.game_id), username, user_token, Std.string(limit), Std.string(table_id), "json" ], 6);
		Utils.request(url, className, onData, onError);
	}
	
	static public function add(score:String, sort:Int, ?username:String, ?user_token:String, ?guest:String, ?extra_data:String, ?table_id:Int, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("scores/add/", [ "game_id", "score", "sort", "username", "user_token", "guest", "extra_data", "table_id", "format" ],
											[ Std.string(Utils.game_id), score, Std.string(sort), username, user_token, guest, extra_data, Std.string(table_id), "json" ], 9);		
		Utils.request(url, className, onData, onError);
	}
	
	static public function getRank(sort:Int, ?table_id:Int, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("scores/get-rank/", ["game_id", "sort", "table_id"], [Std.string(Utils.game_id), Std.string(sort), Std.string(table_id)], 3);
		Utils.request(url, className, onData, onError);
	}
	
	static public function tables(?onData:Bool -> Void, ?onError:String -> Void)
	{
		var url = Utils.formCall("scores/tables/", [ "game_id", "format" ], [ Std.string(Utils.game_id), "json" ], 2);
		Utils.request(url, className, onData, onError);
	}
}