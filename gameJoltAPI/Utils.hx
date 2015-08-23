package gameJoltAPI;

import haxe.crypto.Md5;

@:allow(gameJoltAPI)
class Utils
{
	// ---------------------------------------------------------------------------------------
	// The game's ID must be set by the programmer before any call to the GameJolt API is made 
	// ---------------------------------------------------------------------------------------
	static private var has_game_id:Bool = false;
	@:isVar static public var game_id(get, set):Int;
	static public function get_game_id() : Null<Int>
	{
		if(has_game_id) return game_id;
		else 
		{
			trace("No game ID provided");
			return null;
		}
	}
	static public function set_game_id(v:Int) : Int
	{
		has_game_id = true;
		return (game_id = v);
	}
	
	// -------------------------------------------
	// This also applies to the game's private key 
	// -------------------------------------------
	static private var has_gamePrivKey:Bool = false;
	@:isVar static public var gamePrivKey(get, set):String;
	static public function get_gamePrivKey() : Null<String>
	{
		if(has_gamePrivKey) return gamePrivKey;
		else 
		{
			trace("No game private key provided");
			return null;
		}
	}
	static public function set_gamePrivKey(v:String) : String
	{
		has_gamePrivKey = true;
		return (gamePrivKey = v);
	}
	
	// --------------------------------------------------------------------------
	// Those are free-to-use variables in case their value needs to be remembered
	// They are not actually used anywhere in the library
	// --------------------------------------------------------------------------
	static public var user_id:Int;
	static public var user_token:String;
	static public var username:String;
	
	// ----------------------------------------------------
	// Below this point are private functions and variables
	// ----------------------------------------------------
	static private var BASE_URL = "http://gamejolt.com/api/game/v1/";
	
	// Signs the call with MD5
	static private function sign(call:String) : String
	{
		return call + "&signature=" + Md5.encode(call + gamePrivKey);
	}
	
	static private function formCall(base:String, keys:Array<String>, values:Array<String>, index:Int) : String
	{
		var url = BASE_URL + base;
		for(k in 0 ... index)
			url = addParameter(url, keys[k], values[k]);
		return sign(url);
	}
	
	static private function addParameter(call:String, param:String, value:String) : String
	{
		if(value != null)
			call += (call.indexOf('?') == -1 ? "?" : "&") + param + "=" + value;
		return call;
	}
}