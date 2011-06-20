package com.monsterPatties.utils.sharedObjects 
{	
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SharedData 
	{
		/*-------------------------------------------------------------Constant----------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Properties----------------------------------------------------------------------*/
		private static var _instance:SharedData;		
		private var _sharedData:Array;
		/*-------------------------------------------------------------Constructor----------------------------------------------------------------------*/
		
		
		public function SharedData( enforcer:SingletonEnforcer ) 
		{
			preparedSharedDataId();
		}	
		
		public static function getInstance():SharedData
		{
			if ( SharedData._instance == null ) {
				SharedData._instance = new SharedData( new SingletonEnforcer() );				
			}
			
			return SharedData._instance;
		}
		
		/*-------------------------------------------------------------Methods----------------------------------------------------------------------*/		
		/**
		 * 
		 * @param	id - the id of sharedObject
		 * @param	val - the equivalent value of the sharedObject
		 * @param   val2 - extra values 
		 * @param   val3 - extra values 
		 */
		public function addSharedData( id:String , val:* , val2:* = null , val3:* = null ):void 
		{			
			var sharedData:SharedObject = SharedObject.getLocal( id );
			sharedData.data.val = val;
			sharedData.data.val2 = val2;
			sharedData.data.val3 = val3;
			sharedData.flush();
			
			_sharedData.push( id );
		}
		
		//public function removeSharedData( id:String ):void 
		//{
			//for (var i:int = 0; i < _sharedData.length; i++) 
			//{
				//if ( _sharedData[ i ] == id ) {
					//trace( "found shared data...." );
					//var sharedData:SharedObject = SharedObject.getLocal( id );					
					//sharedData.clear();
					//_sharedData.splice( i, 1 );
					//break;
				//}				
			//}
		//}		
		
		public function removeSharedData( id:String ):void 
		{			
			var sharedData:SharedObject = SharedObject.getLocal( id );					
			sharedData.clear();			
		}		
		
		public function searchSharedData( id:String , whichVal:int = 1 ):* 
		{	
			var found:* = null;
			if( _sharedData.length > 0 ){
				for (var i:int = 0; i < _sharedData.length; i++) 
				{
					if ( _sharedData[ i ] == id ) {
						trace( "found shared data...." );
						var sharedData:SharedObject = SharedObject.getLocal( id );					
						if( whichVal == 1 ){
							found = sharedData.data.val;
						}else if ( whichVal == 2 ) {
							found = sharedData.data.val2;
						}else if ( whichVal == 3 ) {
							found = sharedData.data.val3;
						}
						break;
					}
				}
			}
			
			return found;
		}
		
		public function getSharedData( id:String  ):* 
		{
			var sharedData:SharedObject = SharedObject.getLocal( id );											
			return sharedData.data.val;						
		}		
		
		private function preparedSharedDataId():void 
		{
			if ( _sharedData == null ) {
				_sharedData = new Array();
			}
		}
		
		/*-------------------------------------------------------------Setters----------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Getters----------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------EventHandlers----------------------------------------------------------------------*/
	}

}

class SingletonEnforcer{}