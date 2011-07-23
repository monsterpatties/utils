package com.surnia.socialStar.utils.assetLoader 
{	
	import com.surnia.socialStar.utils.assetLoader.data.FbImage;
	import com.surnia.socialStar.utils.assetLoader.events.AssetLoaderEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class AssetLoader extends Sprite
	{
		/*-------------------------------------------------------------------------Constant-----------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Properties-----------------------------------------------------------------*/
		private var _loader:Loader;
		private var _loaderContext:LoaderContext;
		private var _urlRequest:URLRequest;
		public var loadedAsset:Array;
		private static var _instance:AssetLoader;
		private var _assetLoaderEvent:AssetLoaderEvent;
		
		private var _loadedFbImages:Array;
		private var _isFBImage:Boolean;
		private var _fbImageId:String;
		private var _live:Boolean;
		
		private var _imagesLen:int;
		/*-------------------------------------------------------------------------Constructor-----------------------------------------------------------------*/
		
		
		public function AssetLoader( enforcer:SingletonEnforcer ) 
		{
			init();
		}
		
		public static function getInstance():AssetLoader 
		{
			if ( AssetLoader._instance == null ) {
				AssetLoader._instance = new AssetLoader( new SingletonEnforcer() );
			}
			
			return AssetLoader._instance;
		}
		
		/*-------------------------------------------------------------------------Methods-----------------------------------------------------------------*/
		
		private function init():void 
		{
			
		}
		
		public function loadImage( url:String,live:Boolean, isFBImage:Boolean = false, fbImageid:String ="" ):void 
		{
			trace( "id in ", fbImageid );
			_fbImageId = fbImageid;
			_isFBImage = isFBImage;
			_live = live;
			initAssetHolder();
			
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			Security.allowDomain("http://monsterpatties.net");
			Security.allowDomain("http://localhost");
			Security.allowDomain("http://127.0.0.1");
			Security.allowDomain("http://b.static.ak.fbcdn.net");			
			Security.allowDomain("https://graph.facebook.com/");
			Security.allowDomain("http://monsterpatties.net/stargazer/credits.swf");
			Security.allowDomain("http://monsterpatties.net/stargazer/");
			Security.allowDomain("http://monsterpatties.net");
			
			if( _live ){
				_loaderContext = new LoaderContext();
				_loaderContext.checkPolicyFile = true;
				_loaderContext.securityDomain = SecurityDomain.currentDomain;
			}
			
			_loader = new Loader();
			//var accesstoken:String = "?accesstoken=198272473554034|2.AQCOQ5Z0ENph4Kni.3600.1311148800.1-1211416091|5892-QUvd_a1BX3xgBniO1dknQM";
			//_urlRequest = new URLRequest( url + accesstoken  );
			_urlRequest = new URLRequest( url );
			_loader.load( _urlRequest ,_loaderContext );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadAssetComplete );
			_loader.contentLoaderInfo.addEventListener( Event.INIT, onInitLoadAsset );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onLoadAssetProgress );
		}	
		
		public function initAssetHolder():void 
		{
			
			if( loadedAsset == null ){
				loadedAsset = new Array();				
			}
			
			if ( _loadedFbImages == null ) {
				_loadedFbImages = new Array();
			}
		}
		
		public function unload():void 
		{
			_loader.unload();
			_loader = new Loader();
		}
		
		public function getFbImage( id:String ):Bitmap 
		{			
			var image:Bitmap;
			
			for (var i:int = 0; i < _loadedFbImages.length; i++) 
			{
				if ( _loadedFbImages[ i ].id == id ) {
					trace( "found: getFbImage", id );
					var bmd:BitmapData = new BitmapData( _loadedFbImages[ i ].image.width, _loadedFbImages[ i ].image.height, true, 0x000000 );
					bmd.draw( _loadedFbImages[ i ].image );			
					var bm:Bitmap = new Bitmap( bmd );
					image = bm;
					break;
				}
				trace( "searching images id: ",i," : ", _loadedFbImages[ i ].id , "vs", id );
			}
			
			return image;
		}
		
		public function duplicateImage( image:Bitmap ):BitmapData 
		{
			var bmd:BitmapData = new BitmapData( image.width, image.height, true,0x000000  );
			bmd.draw( image );						
			return bmd;			
		}
		
		/*-------------------------------------------------------------------------Setters-----------------------------------------------------------------*/
		public function set imagesLen(value:int):void 
		{
			_imagesLen = value;
		}
		
		public function set loadedFbImages(value:Array):void 
		{
			_loadedFbImages = value;
		}
		/*-------------------------------------------------------------------------Getters-----------------------------------------------------------------*/
		public function get imagesLen():int 
		{
			return _imagesLen;
		}
		
		public function get loadedFbImages():Array 
		{
			return _loadedFbImages;
		}		
		/*-------------------------------------------------------------------------EventHandlers-----------------------------------------------------------*/
		private function onLoadAssetComplete(e:Event):void 
		{
			trace( "Assetloaded........" );			
			
			
			if ( _isFBImage ) {
				trace( "id out ", _fbImageId );
				var fbImage:FbImage = new FbImage();
				fbImage.image = _loader.content as Bitmap;
				fbImage.id = _fbImageId;
				_loadedFbImages.push( fbImage );				
				_assetLoaderEvent.id = fbImage.id;
				trace( "assetloader image id", fbImage.id , _fbImageId);			
			}else {
				loadedAsset.push( _loader.content );				
			}
			
			
			_assetLoaderEvent = new AssetLoaderEvent( AssetLoaderEvent.ASSET_LOAD_COMPLETE );
			dispatchEvent( _assetLoaderEvent );
			
		}
		
		private function onLoadAssetProgress(e:ProgressEvent):void 
		{
			var percent:Number = Math.floor( e.bytesLoaded / e.bytesTotal ) * 100;			
			trace("Downloaded " + e.bytesLoaded + " out of " + e.bytesTotal + " bytes");			
			_assetLoaderEvent = new AssetLoaderEvent( AssetLoaderEvent.ASSET_PROGRESS );
			_assetLoaderEvent.obj.percent = percent;
			dispatchEvent( _assetLoaderEvent );
		}
		
		private function onInitLoadAsset(e:Event):void 
		{
			trace( "init loading of asset" );
		}		
	}

}

class SingletonEnforcer{}