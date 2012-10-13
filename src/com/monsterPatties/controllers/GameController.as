package com.monsterPatties.controllers 
{	
	import com.greensock.easing.Strong;
	import com.monsterPatties.config.GameConfig;	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameController extends EventDispatcher
	{
		/*---------------------------------------------------------------Constant-----------------------------------------------------------*/
		
		/*---------------------------------------------------------------Properties-----------------------------------------------------------*/
		private static var _instance:GameController;
		private var _root:Object;	
		private var _gameId:String;
		private var _leaderBoardId:String;
		private var _progressData:Object;
		private var _gameAchievements:Object;
		//private var _achievementsId:Array = [ "981b805a1ea15f56", "f723440855b3ee3e" ];
		/*---------------------------------------------------------------Constructor-----------------------------------------------------------*/
		public function GameController( enforcer:SingletonEnforcer ) 
		{
			init();
		}
		
		
		public static function getInstance():GameController
		{
			if ( GameController._instance == null ) {
				GameController._instance = new GameController( new SingletonEnforcer() );
			}
			
			return GameController._instance;
		}
		
		private function init():void 
		{
			_progressData = new Object();
			_progressData.score = 0;
			trace("[GameController] init...");			
		}
		/*---------------------------------------------------------------Methods-----------------------------------------------------------*/
		
		public function addMochibot( me:Sprite, mochibotId:String ):void 
		{
			MochiBot.track( me, mochibotId );
		}	
		
		public function connectMochi( root:Object, gameId:String, leaderBoardId:String ):void 
		{
			_root = root;
			_gameId = gameId;
			_leaderBoardId = leaderBoardId;
			MochiServices.connect(gameId, _root );	
			MochiSocial.addEventListener(MochiSocial.ERROR, LogInError );
			MochiSocial.addEventListener(MochiSocial.LOGGED_IN, loggedIn);
			MochiEvents.addEventListener( MochiEvents.GAME_ACHIEVEMENTS, onGameAchievements );
			MochiEvents.addEventListener( MochiEvents.ACHIEVEMENTS_OWNED, onUserAchievements );
			MochiEvents.addEventListener( MochiEvents.ACHIEVEMENT_NEW, onNewAchievement );
		}				
		
		public function submitScore( playerscore:int ):void 
		{			
			var o:Object = { n: [7, 11, 9, 13, 3, 11, 3, 8, 5, 9, 9, 1, 4, 1, 0, 9], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			//var boardID:String = o.f(0,"");
			//MochiScores.showLeaderboard( { boardID: boardID, score: playerscore } );		
			MochiScores.showLeaderboard( { boardID:_leaderBoardId, score: playerscore } );
		}
		
		public function showHighScores( leaderBoardId:String ):void 
		{			
			MochiScores.showLeaderboard( { boardID:leaderBoardId } );			
		}
		
		public function startGamePlay():void 
		{
			mochi.as3.MochiEvents.startPlay('easy');
		}
		
		public function endGamePlay():void 
		{
			mochi.as3.MochiEvents.endPlay();
		}
		
		public function unlockAchievement( achievementId:String ):void 
		{			
			MochiEvents.unlockAchievement( { id:achievementId } );			
		}
		
		public function saveProgress():void 
		{
			//sample
			//MochiSocial.saveUserProperties({ hitPoints: 120, levelsFinished: [1, 2, 4, 6] });
			
			MochiSocial.saveUserProperties({ score: 120 });
			MochiSocial.addEventListener(MochiSocial.PROPERTIES_SAVED, properties_saved);
			MochiSocial.addEventListener(MochiSocial.ERROR, handleError);
		}
		
		public function loadProgress( obj:Object ):void 
		{
			_progressData = obj;
		}
		
		public function trackEvent( eventName:String, val:int ):void 
		{
			MochiEvents.trackEvent( eventName, val );
			//MochiEvents.trackEvent( 'getGrenades', 5 );
		}
		
		
		public function showLoginWidget():void 
		{
			MochiSocial.showLoginWidget({ x:150, y: 150 });
		}
		
		
		public function hideLoginWidget():void 
		{
			MochiSocial.hideLoginWidget();
		}
		
		public function getFriendList():void 
		{
			MochiSocial.getFriendsList();
			MochiSocial.addEventListener( MochiSocial.FRIEND_LIST, dumpMyFriends );
		}
		
		public function postStream():void 
		{
			var obj:Object = new Object();
			//obj.channel
			//obj.item
			//obj.title
			/*
			channel:Array (optional)
			Stream to post message to (defaults to player's stream)
			item:String (optional)
			Optional coins item to award user for posting item to their stream
			title:String (optional)
			Title of the action window
			thumbURL:String (optional)
			Image displayed next to title
			message:String (optional)
			Default message posted to stream
			locked:Boolean (optional)
			Setting this to true prevents user from editing the stream post message.
			sandbox:Boolean (optional)
			When true, prevents actual request from being sent but pretends that communications were successful
			*/
			MochiSocial.addEventListener( MochiSocial.ACTION_COMPLETE, onStreamPost );
			MochiSocial.addEventListener( MochiSocial.ACTION_CANCELED, onCancel );
			MochiSocial.postToStream( obj );
		}
		
		
		public function inviteFriends():void 
		{
			var obj:Object = new Object();
			/*
			 * 	Parameters:
				friends:Array (optional)
				List of friend user ids to preselect
				item:String (optional)
				Optional coins item to award users giving and receiving invitation
				title:String (optional)
				Title of the invitation window
				thumbURL:String (optional)
				Image displayed next to title
				message:String (optional)
				Default message attached to invitation
				locked:Boolean (optional)
				Setting this to true prevents user from editing the invite message.
				sandbox:Boolean (optional)
				When true, prevents actual request from being sent but pretends that communications were successful
			 * 
			 * 
			 **/
			MochiSocial.addEventListener( MochiSocial.ACTION_COMPLETE, onInvite );
			MochiSocial.addEventListener( MochiSocial.ACTION_CANCELED, onCancelInvite );
			MochiSocial.inviteFriends( obj );
		}
		
		public function gotoSponsorUrl( url:String ):void 
		{
			// var request:URLRequest = new URLRequest("http://www.games1.com/?utm_medium=brandedgames_external&utm_campaign=santa-coming&utm_source=host&utm_content=ingame");			
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request);
		}
		
		public function gotoMySiteUsingLogo( btn:MovieClip ):void 
		{
			MochiServices.addLinkEvent('http://x.mochiads.com/link/dac25f133a231589', 'http://monsterpatties.net',btn );
			gotoSponsorUrl( "http://www.monsterpatties.net/" );			
		}
		
		public function gotoMyWalkThrough(  ):void 
		{			
			gotoSponsorUrl( "http://www.youtube.com/watch?v=d6CbkZ8_C_Q" );			
		}
		
		public function gotoMySiteUsingMoreGameBtn( btn:MovieClip ):void 
		{
			MochiServices.addLinkEvent('http://x.mochiads.com/link/dac25f133a231589', 'http://monsterpatties.net',btn );
			gotoSponsorUrl( "http://www.monsterpatties.net/" );			
		}
		
		//new 03/15/2012
		public function btnClickTracker( btn:*, trackerId:String   ):void 
		{
			MochiServices.addLinkEvent( "http://x.mochiads.com/link/" + trackerId, 'http://monsterpatties.net', btn );			
		}	
		
		/*---------------------------------------------------------------Getters-----------------------------------------------------------*/
		
		/*---------------------------------------------------------------Setters-----------------------------------------------------------*/
		
		/*---------------------------------------------------------------EventHandlers-----------------------------------------------------------*/
		public function onConnectError(status:String):void {
			// handle error here...
			trace( "kaboom mochi on io  error connection!!!");
		}
		
		private function loggedIn(e:Object):void 
		{	
			var len:int = GameConfig.MOCHI_LEADER_BOARD_ID.length;
			
			for (var i:int = 0; i < len; i++) 
			{
				MochiEvents.startSession( GameConfig.MOCHI_ACHIEVEMENTS_ID[ i ] );
			}			
			
			 // receive {name: name, uid: uid, profileImgURL: profileImgURL, hasCoins: True, userProperties: { hitPoints: 120 }}
			trace("Hello " + e.name);
			
			loadProgress( e.userProperties	 );
			getFriendList();
			//for loading progress
			// receive {name: name, uid: uid, profileImgURL: profileImgURL, hasCoins: True, userProperties: { hitPoints: 120 .. }}
			//var userProperties:Object = ev.userProperties			
		}
		
		private function LogInError(e:Event):void 
		{
			trace( "[mochi login error]" );
		}
		
		public function properties_saved(ev:Object):void {
			trace("Properties Saved!");
		}
		
		public function handleError(ev:Object):void {
			switch (ev.type) {
				case MochiSocial.PROPERTIES_SIZE:
					trace("Properties too large.");
					break;
				case MochiSocial.NO_USER:
					trace("No user logged in.");
					break;
			}
		}
		
		 private function dumpMyFriends(event:Object):void {
            for( var k:String in event.friends )
            {
                /*
                 * { 
                 *      "thumbURL": "http://avatars.mochigames.com/api/square/16", 
                 *      "network": "mochigames", 
                 *      "played": true, 
                 *      "uid": 16, 
                 *      "mutual": true, 
                 *      "name": "@bob"
                 * }
                 */
                
                trace("User has friend: ", event.friends[k].name );
            }
        }
		
		private function onStreamPost( e:Object ):void
		{
			// Thanks for posting to your stream!                                                                             
			onCancel(e);
		}

		private function onCancel( e:Object ):void
		{
			MochiSocial.removeEventListener( MochiSocial.ACTION_COMPLETE, onStreamPost );
			MochiSocial.removeEventListener( MochiSocial.ACTION_CANCELED, onCancel );
		}
		
		private function onInvite( e:Object ):void
		{
			// Thanks for inviting your friends!
			onCancel(e);
		}

		private function onCancelInvite( e:Object ):void
		{
			MochiSocial.removeEventListener( MochiSocial.ACTION_COMPLETE, onInvite );
			MochiSocial.removeEventListener( MochiSocial.ACTION_CANCELED, onCancel );
		}
		
		private function onGameAchievements( ach:Array ):void
		{
			for( var i:int = 0; i < ach.length; i++ )
			{
				_gameAchievements[ ach[i].id ] = ach[i];                                        
				_gameAchievements[ ach[i].id ].unlocked = false;
			}
		}

		private function onUserAchievements( ach:Array ):void
		{
			for( var i:int = 0; i < ach.length; i++ )
			{
				_gameAchievements[ ach[i].id ] = ach[i];                                        
				_gameAchievements[ ach[i].id ].unlocked = true;
			}                                        
		}

		private function onNewAchievement( ach:Object ):void
		{
			_gameAchievements[ ach.id ] = ach;                                        
			_gameAchievements[ ach.id ].unlocked = true;
		}
		
	}
}

class SingletonEnforcer{}