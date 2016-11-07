package gameJoltAPI;

import haxe.Http;

// Send "batch requests", that is, requests that contain several sub-requests in them
/* Usage :
 * - First, start a batch request using Batch.start()
 * - Call up to 50 GameJolt API functions that you want to use, using their API normally
 * - Send the request with Batch.request(...)
 * - Each request's success and result can accessed using getRequestSuccess(k:Int) and getResponse(k:Int), with k being the order in which the functions have been called
 * - The batch is not resetted by itself, allowing me to call the same batch several times in a row ; reset it by calling Batch.start() again
 * - End a batch call with Batch.end()
 * Example :
  		Batch.start();
 		Users.fetch("matrefeytontias");
 		GetTime.fetch();
		Scores.tables();
		Batch.request();
		
		if(Batch.lastRequestSuccess)
		{
			if(Batch.getRequestSucess(0)) // Users.fetch
			{
				var r = Batch.getResponse(0);
			}
			// etc
		}
		
		Batch.request(); // send the same request again right away
		Batch.end();
*/
class Batch
{
	static private var className:String = "gameJoltAPI.Batch";
	static private var batchChunk:String;
	static public var result:Dynamic;
	static public var lastRequestSuccess(get, never):Bool;
	static private function get_lastRequestSuccess() : Bool
	{
		return result == null ? false : result.success == "true";
	}
	static public function getRequestSuccess(k:Int)
	{
		return lastRequestSuccess && (k < result.responses.length) && (result.responses[k].success == "true");
	}
	static public function getResponse(k:Int) : Null<Dynamic>
	{
		return k < result.responses.length ? result.responses[k] : null;
	}
	
	static public function start()
	{
		Utils.batching = true;
		Utils.batchString = "";
	}
	
	static public function request(post:Bool = true, ?parallel:Bool, ?break_on_error:Bool, ?onData:Bool -> Void, ?onError:String -> Void)
	{
		Utils.batching = false;
		var url = Utils.formCall("batch/", ["game_id", "parallel", "break_on_error"], [Std.string(Utils.game_id), Std.string(parallel), Std.string(break_on_error)], 3, false) + Utils.batchString;
		Utils.request(Utils.sign(url), className, post, onData, onError);
	}
	
	static public function end()
	{
		Utils.batching = false;
	}
}
