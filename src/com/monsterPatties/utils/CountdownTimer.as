package com.surnia.socialStar.utils
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;

	/**
	 * 
	 * Creates a countdown timer and output the time
	 * per tick as specified in the time of delay.
	 * 
	 * @author Hedrick David
	 * 
	 */	
	
	public class CountdownTimer extends Timer
	{
		//private var _timer:Timer;
		
		// default max time = 1min;
		public static const INTERVAL_ENDED:String = "intervalEnded";
		private var _maxTime:int = 60000;
		private var _countTime:int = _maxTime;
		private var _time:String  = "0:00";
		private var _timerOutput:TextField = null;
		private var _prefix:String = "";
		
		public function CountdownTimer(delay:Number, repeatCount:int = 0)
		{
			super(delay, repeatCount);
			addEventListener(TimerEvent.TIMER, timerHandler)
		}
		
		/**
		 * Sets the textField where the time will be displayed.
		 * 
		 * @param textField - the textfield where the time will be displayed.
		 * 
		 */		
		
		public function setTextFieldOutput(prefix:String, textField:TextField):void{
			_prefix = prefix;
			_timerOutput = textField;	
		}
		
		public function removeListeners():void{
			removeEventListener(TimerEvent.TIMER, timerHandler);
		}
		
		private function timerHandler(evt:TimerEvent):void{
			_countTime -= delay;
			_time = convertToDate(_countTime);
			if (_timerOutput && _timerOutput != null){
				_timerOutput.text = _prefix + " " + _time;
			}
			if (_countTime == 0){
				dispatchEvent(new Event(INTERVAL_ENDED));
				_countTime = _maxTime;
			}
			
		}
		
		public static function convertToMilliSeconds(seconds:int, mins:int = 0, hours:int = 0):int{
			var millisec:int = 1000;
			var hr:int = ((hours * 60) * 60) * millisec;
			var min:int = (mins * 60) * millisec;
			var sec:int = seconds * millisec;
			millisec = hr + min + sec;
			return millisec;
		}
		
		public static function convertToDate(milliseconds:int):String{
			var temp:int = 0;
			var hrs:int = int(milliseconds / 3600000);
			temp = milliseconds - (hrs * 60 * 60 * 1000) ;
			var mins:int = int(temp / 60000);
			temp = temp - (mins * 60 * 1000);
			var secs:int = temp / 1000;
			if (hrs != 0){
				return String (hrs + ":" + mins + ":"  + secs);
			} else if (mins != 0 && secs >= 10){
				return String (mins + ":" + secs);
			} else if (mins != 0 && secs < 10){
				return String (mins + ":0" + secs);
			} else if (secs >= 10){
				return String ("0:" + secs);
			} else {
				return String ("0:0" + secs);
			}
			return "";
		}
		
		public function resetMaxTime():void{
			_countTime = _maxTime;
		}
 		
		public function setMaxTime (seconds:int, mins:int = 0, hours:int = 0):void{
			_maxTime = convertToMilliSeconds(seconds, mins, hours);
			_countTime = _maxTime;
		}
		
		public function get timeValue():String{
			return _time;
		}
		
	}
}