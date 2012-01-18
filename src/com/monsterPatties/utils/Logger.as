package com.surnia.socialStar.utils
{
	public class Logger
	{
		public static function tracer (classObj:Object, message:String):void{
			trace (String (classObj) + " : " + message);
		}
	}
}