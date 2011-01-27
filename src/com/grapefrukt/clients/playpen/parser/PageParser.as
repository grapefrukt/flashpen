package com.grapefrukt.clients.playpen.parser {
	import com.grapefrukt.clients.playpen.models.LinkModel;
	import com.grapefrukt.clients.playpen.models.PageModel;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class PageParser {
		
		static private const IMAGE_START_INDEX	:int 	= 0;
		static private const IMAGE_END_INDEX	:int 	= PageModel.IMAGE_W * PageModel.IMAGE_H + PageModel.IMAGE_H;
		
		static private const MAP_START_INDEX	:int 	= IMAGE_END_INDEX;
		static private const MAP_END_INDEX		:int 	= MAP_START_INDEX + PageModel.IMAGE_W * PageModel.IMAGE_H + PageModel.IMAGE_H;
		static private const UNLINKED_PIXEL		:String = ".";
		
		static private const LINK_START_INDEX	:int 	= MAP_END_INDEX;
		
		static private const LINK_COUNT			:int 	= 16;
		
		static private const COLORS:Vector.<uint> = Vector.<uint>([0x000000, 0x788084, 0xffffff, 0xac1000, 0xfc589c, 0x503000, 0xac8000, 0xe46018, 0xfcd884, 0x004058, 0x006800, 0x00a800, 0x1f1f1f, 0x0088fc, 0x38c0fc, 0xf4d0b4]);
		
		public static function parse(data:String, page:PageModel):void {
			data = data.replace(/(^(\n|\r))|((\n|\r)$)/s, '');
			data = data.replace(/\n\r/g, '\n');
			data = data.replace(/\r\n/g, '\n');
			data = data.replace(/\r/g, '\n');
			
			parseImage(	page, data.substring(	IMAGE_START_INDEX, 	IMAGE_END_INDEX));
			parseMap(	page, data.substring(	MAP_START_INDEX, 	MAP_END_INDEX));
			parseLinks(	page, data.substring(	LINK_START_INDEX));
		}

		static private function parseImage(page:PageModel, data:String):void {
			data = data.replace(/\n/g, '');
			
			for (var i:int = 0; i < data.length; i++) {
				var char:String = data.charAt(i);
				var index:int = parseInt(char, 16);
				page.image.setPixel(i % PageModel.IMAGE_W, int(i / PageModel.IMAGE_W), COLORS[index]);
			}
		}
		
		static private function parseMap(page:PageModel, data:String):void {
			data = data.replace(/\n/g, '');
			
			for (var i:int = 0; i < data.length; i++) {
				var char:String = data.charAt(i);
				if (char == UNLINKED_PIXEL) {
					page.map[i] = 16;
				} else {
					page.map[i] = parseInt(char, 16);
				}
			}
		}
		
		static private function parseLinks(page:PageModel, data:String):void {
			var result:Array = data.split('\n');
			for (var i:int = 0; i < LINK_COUNT; i++) {
				page.links[i] = new LinkModel(result[i * 2 + 1], result[i * 2 + 0]);
			}
		}
		
	}

}