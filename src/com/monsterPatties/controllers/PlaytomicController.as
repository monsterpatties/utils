package com.monsterPatties.controllers 
{
	import com.monsterPatties.config.GameConfig;
	import Playtomic.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PlaytomicController 
	{
		/*----------------------------------------------------------------Constant--------------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Properties------------------------------------------------------------------------*/
		
		
		private static var _instance:PlaytomicController;
		
		
		/*----------------------------------------------------------------Constrtuctor------------------------------------------------------------------------*/
		
		public function PlaytomicController( enforcer:SingletonEnforcer ) 
		{			
		}
		
		
		public static function getInstance():PlaytomicController 
		{
			if ( PlaytomicController._instance == null ) {
				PlaytomicController._instance = new PlaytomicController( new SingletonEnforcer() );
			}
			
			return PlaytomicController._instance;
		}
		
		public function init( swfid:int, guid:String, apikey:String, root:* ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.View(swfid, guid, apikey, root.loaderInfo.loaderURL);
			}
		}
		
		
		public function startGame():void 
		{
			if( GameConfig.isPlaytomic ){
				Log.Play();
				forceSend();
			}
		}
		
		public function endGame():void 
		{
			
		}
		
		/**
		 *  to force log
		 */
		
		public function forceSend():void 
		{
			if( GameConfig.isPlaytomic ){
				Log.ForceSend();
			}
		}
		
		/**
		 *  to freeze log
		 */
		
		public function freezeSend():void 
		{
			if( GameConfig.isPlaytomic ){
				Log.Freeze();
			}
		}
		
		/**
		 *  to un freeze log
		 */
		
		public function unFreezeSend():void 
		{
			if( GameConfig.isPlaytomic ){
				Log.UnFreeze();
			}
		}
		
		
		/**
		 * 
		 * call this when the player starts Level
		 * @param	level
		 */
		public function playLevel( level:int ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.LevelCounterMetric("play", level ,true );
				forceSend();
			}			
		}
		
		public function started( level:int ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.LevelCounterMetric("Started", level, true);
				forceSend();
			}
		}
		
		public function restarted( level:int ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.LevelCounterMetric("restarted", level, true);
				forceSend();
			}
		}
		
		public function ended( level:int ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.LevelCounterMetric("ended", level, true);
				forceSend();
			}
		}		
		
		public function gameIsLoaded():void 
		{
			if( GameConfig.isPlaytomic ){
				Log.CustomMetric( "MainMenu", "Pregame" ,true );
				forceSend();
			}			
		}
		
		public function trackPreloader():void 
		{
			if( GameConfig.isPlaytomic ){
				Log.CustomMetric( "Preloader", "Pregame" ,true );
				forceSend();
			}
		}
		
		public function trackSponsorSplash():void 
		{
			if( GameConfig.isPlaytomic ){
				Log.CustomMetric( "SponsorSplash", "Pregame" ,true );
				forceSend();
			}
		}
		
		public function trackDevSplash():void 
		{
			if( GameConfig.isPlaytomic ){
				Log.CustomMetric( "DevSplash", "Pregame" ,true );
				forceSend();
			}
		}
		
		public function trackMenu():void 
		{
			if( GameConfig.isPlaytomic ){
				Log.CustomMetric( "MainMenu", "Pregame" ,true );
				forceSend();
			}
		}
		
		 
		/**
		 * use this for tracker user behaviour 
		 * @param	what - gameObject that was click by users
		 * @param	screen - what screen or view did this event happen
		 */
		public function clickWhat( what:String, screen:String ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.CustomMetric( what, screen ,true );
				forceSend();
			}
		}
		
		//tracker
		/**
		 * this is used during every level or stage
		 * @param	whatToTrack - the event or value you want to track
		 * @param	level - level which you want to track
		 * @param	valThatTrack - what is the value of the event you tracking ex. time, health
		 */
		public function trackDuringGame( whatToTrack:String, level:int, valThatTrack:int ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.LevelAverageMetric( whatToTrack, level, valThatTrack , true );
				forceSend();
			}
		}
		
		public function timeCompleteTracker( level:int, sec:int ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.LevelAverageMetric("TimeComplete", level, sec ,true );
				forceSend();
			}
		}
		
		public function timeFailedTracker( level:int, sec:int ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.LevelAverageMetric("TimeFailed", level, sec ,true );
				forceSend();
			}
		}
		
		public function clickTracker( level:int, click:int ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.LevelRangedMetric( "Clicks", level, click, true); // unique only
				forceSend();
			}
		}
		
		/**
		 * 
		 * @param	whatToTrack - ex. number of shots in a golf game before the ball shoot in the hole
		 * @param	level - level to track
		 */
		public function tracker( whatToTrack:String, level:int, tries:int ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.LevelRangedMetric(whatToTrack, level, tries ,true );
				forceSend();
			}
		}
		
		
		/**
		 * 
		 * @param	whatToTrack - gameObject you want to track or image or buton
		 * @param	objHit - what object was hit when click
		 * @param	x - x position of this object
		 * @param	y - y position of this object
		 */
		public function checkForUserClickingEvent( whatToTrack:String, objHit:String, x:Number, y:Number ):void 
		{
			if( GameConfig.isPlaytomic ){
				Log.Heatmap( whatToTrack, objHit, x, y );
				forceSend();
			}
		}
		
		/**
		 * 
		 * @param	url - url link to be track
		 * @param	gameObjectThatTrack -  object that is click in the game
		 * @param	urlType - sponsor website link or your own website link
		 */
		
		public function trackLink( url:String, gameObjectThatTrack:String, urlType:String  ):void 
		{
			if( GameConfig.isPlaytomic ){
				//Link.Open("http://website.com/?gameref=my_game", "PlayMoreGames", "Sponsor", trackonly, "mytarget");
				Link.Open(url, gameObjectThatTrack, urlType, false );
				forceSend();
			}
		}
	}

}

class SingletonEnforcer{}