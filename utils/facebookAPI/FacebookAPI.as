package com.monsterPatties.utils.facebookAPI 
{	
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.Facebook;
	import com.monsterPatties.utils.assetLoader.AssetLoader;
	import com.monsterPatties.utils.assetLoader.events.AssetLoaderEvent;
	import com.monsterPatties.utils.facebookAPI.events.FacebookApiEvent;	
	import com.vikings.data.models.Friend;
	import com.vikings.data.models.UserFbData;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author jc
	 */
	public class FacebookAPI extends EventDispatcher
	{
		
		/*-----------------------------------------------------------------------Constant-------------------------------------------------*/
		
		/*------------------------------------------------------------------------Properties-------------------------------------------------*/
		private static var _instance:FacebookAPI;
		private var _appId:String;		
		
		//actual user
		private var _userFbData:UserFbData;
		
		private var _facebookEvent:FacebookApiEvent;
		
		//user friends data
		private var _friends:Array;
		
		private var _assetLoader:AssetLoader;
		private var _nextFriend:int;
		private const _max:int = 10;		
		private var _nextFriendImage:int = 0;
		
		/*-----------------------------------------------------------------------Constructor-------------------------------------------------*/
		
		public function FacebookAPI( enforcer:SingletonEnforcer ) 
		{
			trace( "initFacebook API........" );
		}
		
		public static function getInstance(  ):FacebookAPI 
		{			
			if ( FacebookAPI._instance == null ) {
				FacebookAPI._instance = new FacebookAPI( new SingletonEnforcer() );
			}
			
			return FacebookAPI._instance;
		}		
		
		/*----------------------------------------------------------------------------Methods-------------------------------------------------*/
		public function initFacebookAPI( appId:String ):void 
		{
			_appId = appId;			
			//Initialize Facebook library
			Facebook.init( _appId, onInit);
		}
		
		
		protected function onInit(result:Object, fail:Object):void {
			trace( "on init fb swifer................." );
			if (result) { //already logged in because of existing session				
				trace( "viking is init login..............." );				
			} else {				
				trace( "viking is init not login..............." );
			}
		}
		
		public function login():void 
		{
			trace("fbapiswifer try login.............");
			var opts:Object = {perms:"publish_stream, user_photos"};
			Facebook.login(onLogin, opts);
		}
		
		public function logout():void 
		{
			Facebook.logout(onLogout);
		}
		
		protected function onLogin(result:Object, fail:Object):void {
			if (result) { //successfully logged in
				trace( "successfully fbapi logged in..."  );
				//getData("/me");
				//getFriendsData();
				
				_facebookEvent = new FacebookApiEvent( FacebookApiEvent.LOGIN_COMPLETE );
				dispatchEvent( _facebookEvent );				
			} else {
				trace( "login fbapi failed...."  );				
			}
		}
		
		protected function onLogout(success:Boolean):void {			
			trace( "on logout fbapi....", success  );			
		}
		
		
		public function getData( method:String ):void 
		{
			var requestType:String = "GET";
			var params:Object = null;			
			
			if ( method == "/me" ) {				
				Facebook.api( method, onCallApi, params, requestType); //use POST to send data (as per Facebook documentation)
			}else if ( method == "/me/friends" ) {				
				Facebook.api( method, getFriendsId, params, requestType); //use POST to send data (as per Facebook documentation)
			}else{				
				Facebook.api( method, onExtractFriendData, params, requestType); //use POST to send data (as per Facebook documentation)
			}			
		}		
		
		
		public function postFeed( message:String , method:String = "/me/feed" ):void
		{
			var obj:Object = new Object();
			obj.message = message;
			var msg:* = JSON.encode( obj );
			
			var requestType:String ="POST";
			var params:Object = null;				
			try {
				params = JSON.decode( msg );
			} catch (e:Error) {
				trace("\n\nERROR DECODING JSON: " + e.message);
			}			
			
			Facebook.api( method, onCallApi, params, requestType); //use POST to send data (as per Facebook documentation)
		}
		
		protected function onCallApi(result:Object, fail:Object):void {
			if (result) {
				trace("\n\nRESULT:\n" + JSON.encode(result));
				trace( "Swifeer id", result.id );
				
				_userFbData = new UserFbData();
				_userFbData.id = result.id;
				_userFbData.name = result.first_name;
				
				_assetLoader = AssetLoader.getInstance();
				_assetLoader.loadImage( Facebook.getImageUrl( _userFbData.id ),true, _userFbData.id );
				_assetLoader.addEventListener( AssetLoaderEvent.ASSET_LOAD_COMPLETE, onLoadUserImage );
				
			} else {
				trace("\n\nFAIL:\n" + JSON.encode(fail)); 
			}
		}
		
		
		
		protected function onExtractFriendData(result:Object, fail:Object):void {
			if (result) {
				trace( "extract friends data success started!..................." );
				trace( "number, ", _nextFriend );
				trace("\n\nRESULT:\n" + JSON.encode(result));
				setFriendData( result );
			} else {
				trace( "extract friends data failed!..................." );				
			}
		}	
		
		protected function getFriendsId(result:Object, fail:Object):void {
			if (result) {
				
				if ( _friends == null ) {
					_friends = new Array();
				}
				
				var len:int = 0;				
				
				for each( var a:* in result ){
					trace( "see: ", a , "id", a.id, "name", a.name );
					var friend:Friend  = new Friend();
					friend.id = a.id;
					
					if( len < _max ){
						_friends.push( friend );
						len++;
					}else {
						trace( "reach max limit friend ids!!" );
						break;
					}
				}
				trace( "getting friends id successful!!!!!!!." );
				_facebookEvent = new FacebookApiEvent( FacebookApiEvent.EXTRACT_FRIENDS_ID_COMPLETE )
				dispatchEvent( _facebookEvent );
			} else {
				trace( "getting friends id failed!!!!!!!." );
			}
		}
		
		private function setFriendData( data:Object ):void 
		{
			var len:int = _friends.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _friends[ i ].id == data.id ) {
					_friends[ i ].name = data.first_name;
					_friends[ i ].gender = data.gender;	
					break;
				}				
			}
			_nextFriend++;
			if( _nextFriend < _max ){				
				getData( "/" + _friends[ _nextFriend ].id );
			}else {
				_facebookEvent = new FacebookApiEvent( FacebookApiEvent.EXTRACT_FRIENDS_DATA_COMPLETE );
				dispatchEvent( _facebookEvent );
			}
		}
		
		public function extractFriendsData():void 
		{			
			_nextFriend = 0;			
			getData( "/"+_friends[ _nextFriend ].id );			
		}
		
		
		public function setFriendImages():void 
		{	
			trace( "image #", _nextFriendImage );
			_assetLoader = AssetLoader.getInstance();
			_assetLoader.loadImage( Facebook.getImageUrl( _friends[ _nextFriendImage ].id ), true, _friends[ _nextFriendImage ].id );
			_assetLoader.addEventListener( AssetLoaderEvent.ASSET_LOAD_COMPLETE, onSetFriendImage );				
			
		}
		
		/*----------------------------------------------------------------------------Setters-------------------------------------------------*/
		
		public function get appId():String { return _appId; }	
		
		
		public function get userFbData():UserFbData { return _userFbData; }
		
		public function get friends():Array { return _friends.concat(); }
		/*-----------------------------------------------------------------------------Getters-------------------------------------------------*/		
		public function set appId(value:String):void 
		{
			_appId = value;
		}
		public function set userFbData(value:UserFbData):void 
		{
			_userFbData = value;
		}	
		
		public function set friends(value:Array):void 
		{
			_friends = value;
		}
		
		/*-----------------------------------------------------------------------------EvenntHandlers-------------------------------------------------*/
		private function onLoadUserImage(e:AssetLoaderEvent):void 
		{
			_userFbData.image = _assetLoader.getFbImage( _userFbData.id );
			
			_facebookEvent = new FacebookApiEvent( FacebookApiEvent.USER_DATA_COMPLETE );
			dispatchEvent( _facebookEvent );
		}
		
		private function onSetFriendImage(e:AssetLoaderEvent):void 
		{
			trace( "loaded friend image", _nextFriendImage, e.id );
			var len:int = _friends.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				if ( _friends[ i ].id == e.id ) {
					_friends[ i ].image = _assetLoader.getFbImage( _friends[ i ].id );
					trace( "added friend image....................", _nextFriendImage );
					_nextFriendImage++;
					break;
				}
			}
			
			
			if ( _nextFriendImage < _max ) {
				setFriendImages();				
			}else 
			{
				_facebookEvent = new FacebookApiEvent( FacebookApiEvent.EXTRACT_FRIENDS_IMAGE_COMPLETE );
				dispatchEvent( _facebookEvent );
			}
		}
	}

}

class SingletonEnforcer{}