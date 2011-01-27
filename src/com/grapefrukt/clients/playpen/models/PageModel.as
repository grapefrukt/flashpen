package com.grapefrukt.clients.playpen.models {
	import com.grapefrukt.clients.playpen.events.PageEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	
	[Event(name = "pageevent_complete", type = "com.grapefrukt.clients.playpen.events.PageEvent")]
	
	public class PageModel extends EventDispatcher {
		
		static public const IMAGE_W	:int 	= 48;
		static public const IMAGE_H	:int 	= 32;
		
		private var _name	:String;
		private var _image	:BitmapData;
		private var _map	:Vector.<uint>;
		private var _links	:Vector.<LinkModel>;
		private var _is_loaded:Boolean = false;
		
		public function PageModel(name:String) {
			_image = new BitmapData(IMAGE_W, IMAGE_H, false, 0);
			_map = new Vector.<uint>(IMAGE_W * IMAGE_H, true);
			_links = new Vector.<LinkModel>(16, true);
			_name = name;
		}
		
		public function getLink(x:int, y:int):LinkModel {
			if (x < 0 || x >= IMAGE_W) return null;
			if (y < 0 || y >= IMAGE_H) return null;
			
			var index:uint = _map[y * IMAGE_W + x];
			return index == 16 ? null : _links[index];
		}
		
		public function setLoaded():void {
			_is_loaded = true;
			dispatchEvent(new PageEvent(PageEvent.COMPLETE, this));
		}
		
		public function get isLoaded():Boolean { return _is_loaded; }
		public function get image():BitmapData { return _image; }
		public function get map():Vector.<uint> { return _map; }
		public function get links():Vector.<LinkModel> { return _links; }
		public function get name():String { return _name; }
		
		
		
	}

}