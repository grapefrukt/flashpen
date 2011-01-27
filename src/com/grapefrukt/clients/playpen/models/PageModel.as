package com.grapefrukt.clients.playpen.models {
	import com.grapefrukt.clients.playpen.events.PageEvent;
	import com.grapefrukt.clients.playpen.events.PageLoaderEvent;
	import com.grapefrukt.clients.playpen.loader.PageLoader;
	import com.grapefrukt.clients.playpen.parser.PageParser;
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
		
		static public const STATE_UNLOADED	:String = 'page_state_unloaded';
		static public const STATE_LOADING	:String = 'page_state_loading';
		static public const STATE_LOADED	:String = 'page_state_loaded';
		static public const STATE_ERROR		:String = 'page_state_error';
		
		private var _collection	:PageCollection;
		private var _name		:String;
		private var _image		:BitmapData;
		private var _map		:Vector.<uint>;
		private var _links		:Vector.<LinkModel>;
		private var _state		:String = STATE_UNLOADED;
		
		public function PageModel(collection:PageCollection, name:String) {
			_collection = collection;
			_image = new BitmapData(IMAGE_W, IMAGE_H, false, 0);
			_map = new Vector.<uint>(IMAGE_W * IMAGE_H, true);
			_links = new Vector.<LinkModel>(16, true);
			_name = name;
		}
		
		public function load():void {
			if (_state == STATE_UNLOADED) {
				setState(STATE_LOADING);
				var _loader:PageLoader = new PageLoader(this, _collection);
				_loader.addEventListener(PageLoaderEvent.DATA, handleLoaded);
				_loader.addEventListener(PageLoaderEvent.ERROR, handleError);
				
				dispatchEvent(new PageEvent(PageEvent.REQUEST_LOAD, this, _loader));
			}
		}
		
		private function handleLoaded(e:PageLoaderEvent):void {
			PageParser.parse(_collection, this, e.data);
			setState(STATE_LOADED);
		}
		
		private function handleError(e:PageLoaderEvent):void {
			setState(STATE_ERROR);
		}
		
		public function getLink(x:int, y:int):LinkModel {
			if (x < 0 || x >= IMAGE_W) return null;
			if (y < 0 || y >= IMAGE_H) return null;
			
			var index:uint = _map[y * IMAGE_W + x];
			return index == 16 ? null : _links[index];
		}
		
		private function setState(state:String):void {
			if (_state == state) return;
			_state = state;
			dispatchEvent(new PageEvent(PageEvent.STATE_CHANGE, this));
		}
		
		public function get state():String { return _state; }
		public function get image():BitmapData { return _image; }
		public function get map():Vector.<uint> { return _map; }
		public function get links():Vector.<LinkModel> { return _links; }
		public function get name():String { return _name; }
		
		
		
	}

}