# GameJolt-API-Haxe-bindings
Library-independent Haxe bindings for the GameJolt API. Works with Haxe 3.3.0

This library follows the same structure as the official GameJolt Game API.

## Package overview

- package gameJoltAPI
    - class Batch
        - `function getRequestSucess(which:Int)`
        - `function getResponse(which:Int)`
        - `function start()`
        - `function request(post:Bool = true, ?parallel:Bool, ?break_on_error:Bool)`
        - `function end()`
    - class Users
        - `function fetch(?user_id:Array<Int>, ?username:String)`
        - `function auth(username:String, user_token:String)`
    - class Sessions
        - `function open(username:String, user_token:String)`
        - `function ping(username:String, user_token:String, ?status:String)`
        - `function check(username:String, user_token:String)`
        - `function close(username:String, user_token:String)`
    - class Trophies
        - `function fetch(username:String, user_token:String, ?achieved:Bool, ?trophy_id:Array<Int>)`
        - `function addAchieved(username:String, user_token:String, trophy_id:Int)`
    - class Scores
        - `function fetch(?username:String, ?user_token:String, ?limit:Int, ?table_id:Int)`
        - `function add(score:String, sort:Int, ?username:String, ?user_token:String, ?guest:String, ?extra_data:String, ?table_id:Int)`
        - `function getRank(sort:Int, ?table_id:Int)`
        - `function tables()`
    - class DataStore
        - `function fetch(key:String, ?username:String, ?user_token:String)`
        - `function set(key:String, data:String, ?username:String, ?user_token:String)`
        - `function update(key:String, operation:String, value:String, ?username:String, ?user_token:String)`
        - `function remove(key:String, ?username:String, ?user_token:String)`
        - `function getKeys(?username:String, ?user_token:String)`
    - class GetTime
        - `function fetch()`
    - class Utils
        - `var game_id`
        - `var gamePrivKey`
        - `var user_id`
        - `var user_token`
        - `var username`

Every single function except `Batch.getRequestSuccess, Batch.getReponse, Batch.start, Batch.end` takes two optional arguments `onData:Bool -> Void` and `onError:String -> Void` : those are callbacks that get called when an error occurs and after the data is received respectively.

The library works as follows :

- First of all, you, the developer, must set the variables `Utils.game_id : Int` and `Utils.gamePrivKey : String`. No call to the GameJolt API will work if you skip this step.
- Any call made using this library follows the documentation you can find [on the actual GameJolt API pages](http://gamejolt.com/api/doc/game). Version 1.1 adds support for the unreleased additional GameJolt API functions which can be found [here](https://github.com/gamejolt/doc-game-api/tree/master/v1.x).
- Every class has their own `result : Dynamic` and `lastRequestSuccess : Bool` variable. They are used to store a call's return value, once parsed through `Json.parse()` in the case of `result`. Thus, to access return values as described in the GameJolt API doc, you must use `result.response` as a base variable.

Example :

```Haxe
import gameJoltAPI.Users;
import gameJoltAPI.Utils;

class Main
{
    static public function main()
    {
		Utils.game_id = 12345;
		Utils.gamePrivKey = "12345678912345678912345678912345";
		Users.fetch("matrefeytontias", onData);
    }
    
    static private function onData(s:Bool)
    {
        if(s)
        {
            var d = Users.result.response.users[0];
            trace(d.id, d.type, d.last_logged_in);
        }
    }
}
```

## Differences from the original API

The main difference is that every parameter that could be given as a comma-separated list of numbers with the original API must here be `Array<Int>`, even if a single number is given. Examples include the `user_id` parameter of `Users.fetch`.
Additionally, this library implements its own way of dealing with Batch requests, which is documented in Batch.hx.

## Contact

If you have any question or suggestion, feel free to send a mail to mattias@refeyton.fr .