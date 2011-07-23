package com.surnia.socialStar.utils.assetDigitCharacterConverter
{
	import flash.display.Sprite;

	public class NumberAssetConverter
	{
		
		public static const SPRITE_DIGIT:String = "spriteDigit";
		public function NumberAssetConverter(){
			
		}
		
		/**
		 * 
		 * Converts the given number of assets.
		 * 
		 * @param value - the value of the number to be created as a display.
		 * @param numberAssets - the array of numbered assets, order it based
		 * on the digits.
		 * @return Sprite - the sprite containing the value. 
		 * 
		 */
		
		public static function convertNumberToAsset(value:int, numberAssets:Array, padding:int = 2):Sprite{
			var xPos:Number = 0;
			var valStr:String = String(value);
			var container:Sprite = new Sprite();
			container.name = SPRITE_DIGIT;
			if (value < 10){
				xPos += 10;
			}
			for (var x:int = 0; x<valStr.length; x++){
				for (var y:int = 0; y<numberAssets.length; y++){
					if (int(valStr.charAt(x)) == y){
						var imgSpr:Sprite = new numberAssets[y]();
						imgSpr.x = xPos;
						xPos += imgSpr.width + padding;
						container.addChild(imgSpr);
						break;
					}
				}
			}
			
			return container;
		}
		
	}
}