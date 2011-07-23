package com.monsterPatties.utils.timer 
{
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class TimerData 
	{
		/*----------------------------------------------------------------Constant---------------------------------------------------------*/
		
		/*----------------------------------------------------------------Properties---------------------------------------------------------*/
		private var _sec:uint;
		private var _min:uint;
		private var _hour:uint;
		/*----------------------------------------------------------------Constructor---------------------------------------------------------*/
		
		public function TimerData() 
		{
			
		}	
		
		/*----------------------------------------------------------------Methods---------------------------------------------------------*/
		
		/*----------------------------------------------------------------Setters---------------------------------------------------------*/
		public function set sec(value:uint):void 
		{
			_sec = value;
		}		
		
		public function set min(value:uint):void 
		{
			_min = value;
		}		
		
		public function set hour(value:uint):void 
		{
			_hour = value;
		}
		/*----------------------------------------------------------------Getters---------------------------------------------------------*/
		public function get sec():uint 
		{
			return _sec;
		}
		
		public function get min():uint 
		{
			return _min;
		}
		
		public function get hour():uint 
		{
			return _hour;
		}
		/*----------------------------------------------------------------EventHandlers---------------------------------------------------*/
		
	}

}