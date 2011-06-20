package com.monsterPatties.utils.webCam 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class WebCam extends Sprite
	{
		/*-----------------------------------------------------------Constant-------------------------------------------------------*/
		
		/*-----------------------------------------------------------Properties-------------------------------------------------------*/
		private var _camera:Camera;
		private var _video:Video;			
		/*-----------------------------------------------------------Constructor-------------------------------------------------------*/
		
		public function WebCam() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			addCamera();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);			
			removeCamera();
		}
		
		/*-----------------------------------------------------------Methods-------------------------------------------------------*/
		private function addCamera():void 
		{
			_camera = Camera.getCamera();
			
			if ( _camera == null ) {
				Security.showSettings(SecurityPanel.CAMERA);
			}else 
			{
				var bandwidth:int = 0; // Specifies the maximum amount of bandwidth that the current outgoing video feed can use, in bytes per second. To specify that Flash Player video can use as much bandwidth as needed to maintain the value of quality , pass 0 for bandwidth . The default value is 16384.
				var quality:int = 50; // this value is 0-100 with 1 being the lowest quality. Pass 0 if you want the quality to vary to keep better framerates
			
				_camera.setQuality(bandwidth, quality);
				_camera.setMode(320, 240, 15, true); // setMode(videoWidth, videoHeight, video fps, favor area)
				_camera.addEventListener( StatusEvent.STATUS, onCameraStatus );

				// Now attach the webcam stream to a video object.
				_video = new Video();
				_video.attachCamera(_camera);
				addChild(_video);
			}			
		}		
		
		private function removeCamera():void 
		{
			if ( _video != null ) {
				if ( this.contains( _video ) ) {
					this.removeChild( _video );
					_video = null;
				}
			}
		}
		
		/*-----------------------------------------------------------Setters-------------------------------------------------------*/
		
		/*-----------------------------------------------------------Getters-------------------------------------------------------*/
		
		/*-----------------------------------------------------------EventHandlers-------------------------------------------------*/
		private function onCameraStatus(e:StatusEvent):void 
		{
			trace( "camera status: ",e.code );
			if ( e.code == "Camera.Muted" ) {
				trace( "camera access denied!!..........." );
			}else if ( e.code == "Camera.Unmuted" ) {
				trace( "camera access granted!!!..........." );
			}
			
		}
	}

}