package com.monsterPatties.utils.interfaces 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author jc
	 */
	public interface IWindow 
	{
		function addWindowBg( windowBg:MovieClip ):void;
		function removeWindowBg( ):void;
		function initWindow():void;
		function clearWindow():void;
		function get windowName():String;
	}
	
}