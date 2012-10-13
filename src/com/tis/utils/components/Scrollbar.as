﻿package com.tis.utils.components 
{
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	* ...
	* @author Yogesh Puri
	*/
	public class Scrollbar extends MovieClip
	{
		private var targetMC:MovieClip;	
		private var top:Number;
		private var bottom:Number;
		private var dragBot:Number;
		private var range:Number;
		private var ratio:Number;
		private var sPos:Number;
		private var sRect:Rectangle;
		private var ctrl:Number;//This is to adapt to the target's position
		private var isUp:Boolean;
		private var isDown:Boolean;
		private var isArrow:Boolean;
		private var arrowMove:Number;
		private var upScrollControlHeight:Number;
		private var downScrollControlHeight:Number;
		private var sBuffer:Number;
		private var dragHandleMC:MovieClip;
		private var track:MovieClip;
		private var upScrollControl:MovieClip;
		private var downScrollControl:MovieClip;

		public function Scrollbar(target:MovieClip):void {
			
			var sBar:MovieClip = new ScrollbarAssets();
			addChild(sBar);
			
			dragHandleMC = sBar.dragHandleMC;	
			track = sBar.track;
			upScrollControl = sBar.upScrollControl;
			downScrollControl = sBar.downScrollControl;
			
			dragHandleMC.addEventListener(MouseEvent.MOUSE_DOWN, dragScroll);
			dragHandleMC.addEventListener(MouseEvent.MOUSE_UP, stopScroll);
			
			init(target);
		}
		//
		public function init(target:MovieClip):void {	
			targetMC = target;
			sBuffer = 2;
			ratio = 2;
			if (targetMC.height <= track.height) {
				this.visible = false;
			}			

			//
			upScrollControlHeight = upScrollControl.height;
			downScrollControlHeight = downScrollControl.height;
			
			top = dragHandleMC.y;
			dragBot = (dragHandleMC.y + track.height) - dragHandleMC.height;
			bottom = track.height - (dragHandleMC.height/sBuffer);

			range = bottom - top;
			sRect = new Rectangle(0,top,0,dragBot);
			ctrl = targetMC.y;
			//set Mask
			isUp = false;
			isDown = false;
			arrowMove = 10;
			
			
			upScrollControl.addEventListener(Event.ENTER_FRAME, upScrollControlHandler);
			upScrollControl.addEventListener(MouseEvent.MOUSE_DOWN, upScroll);
			upScrollControl.addEventListener(MouseEvent.MOUSE_UP, stopScroll);
			//
			downScrollControl.addEventListener(Event.ENTER_FRAME, downScrollControlHandler);
			downScrollControl.addEventListener(MouseEvent.MOUSE_DOWN, downScroll);
			downScrollControl.addEventListener(MouseEvent.MOUSE_UP, stopScroll);
	
			setMask();
			this.x = targetMC.x+targetMC.width + 5;
			this.y = targetMC.y+5;
		}
		
		private function setMask() {
			var square:Sprite = new Sprite();
			square.graphics.beginFill(0x000000);
			square.graphics.drawRect(targetMC.x, targetMC.y, targetMC.width+5, (track.height+upScrollControlHeight+downScrollControlHeight));
			targetMC.parent.addChild(square);			
			targetMC.mask = square;	
		}
		
		public function upScroll(event:MouseEvent):void {
			isUp = true;
		}
		
		public function downScroll(event:MouseEvent):void {
			isDown = true;
		}
		
		public function upScrollControlHandler(event:Event):void {
			if (isUp) {
				if (dragHandleMC.y > top) {
					dragHandleMC.y-=arrowMove;
					if (dragHandleMC.y < top) {
						dragHandleMC.y = top;
					}
					startScroll();
				}
			}
		}
		
		//
		public function downScrollControlHandler(event:Event):void {
			if (isDown) {
				if (dragHandleMC.y < dragBot) {
					dragHandleMC.y+=arrowMove;
					if (dragHandleMC.y > dragBot) {
						dragHandleMC.y = dragBot;
					}
					startScroll();
				}
			}
		}
		//
		public function dragScroll(event:MouseEvent):void {			
			dragHandleMC.startDrag(false, sRect);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, moveScroll);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopScroll);
			this.addEventListener(MouseEvent.MOUSE_MOVE, moveScroll);
		}
		//

		public function stopScroll(event:MouseEvent):void {
			 
			isUp = false;
			isDown = false;
			dragHandleMC.stopDrag();

			stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveScroll);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopScroll);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, moveScroll);
		}
		//
		public function moveScroll(event:MouseEvent):void {
			startScroll();

		}
		public function startScroll():void {
			ratio = (targetMC.height - range)/range;
			sPos = (dragHandleMC.y * ratio) - ctrl;	
			targetMC.y = -sPos;
		}
		
	}
	
}