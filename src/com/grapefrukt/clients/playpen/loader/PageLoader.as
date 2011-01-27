package com.grapefrukt.clients.playpen.loader {
	import com.grapefrukt.clients.playpen.events.PageLoaderEvent;
	import com.grapefrukt.clients.playpen.models.PageCollection;
	import com.grapefrukt.clients.playpen.models.PageModel;
	import com.grapefrukt.clients.playpen.parser.PageParser;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	
	[Event(name = "pageloaderevent_error", type = "com.grapefrukt.clients.playpen.events.PageLoaderEvent")]
	[Event(name = "pageloaderevent_data", type = "com.grapefrukt.clients.playpen.events.PageLoaderEvent")]
	
	public class PageLoader extends EventDispatcher {
		
		private static const BASE_URL		:String = 'http://playpen.farbs.org/index.php?title='
		private static const ACTION_URL		:String = '&action=raw';
		private static const REDIRECT_REGEX	:RegExp = /#REDIRECT \[\[(.*?)]]/g;
		private static const VALIDATE_REGEX	:RegExp = /\<ppimage\>(.*?)\<\/ppimage\>/s;
		
		private var _page			:PageModel;
		private var _collection		:PageCollection;
		private var _overrideName	:String;
		private var _loader			:URLLoader;
		
		public function PageLoader(page:PageModel, collection:PageCollection, overrideName:String = '') {
			_page = page;
			_collection = collection;
			_overrideName = overrideName;
		}
		
		public function load():void {
			trace("loading", _page.name, _overrideName);
			
			_loader = new URLLoader;
			var u:URLRequest = new URLRequest(BASE_URL + (_overrideName || _page.name) + ACTION_URL);
			
			_loader.addEventListener(Event.COMPLETE, handleLoadComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, handleLoadError);
			
			_loader.load(u);
		}
		
		private function handleLoadError(e:IOErrorEvent):void {
			dispatchEvent(new PageLoaderEvent(PageLoaderEvent.ERROR));
		}
		
		private function handleLoadComplete(e:Event):void {
			var redirect:* = REDIRECT_REGEX.exec(_loader.data);
			
			if (redirect) {
				_overrideName = redirect[1];
				load();
				return;
			}
			
			var result:* = VALIDATE_REGEX.exec(_loader.data);
			if (!result) return;
			
			dispatchEvent(new PageLoaderEvent(PageLoaderEvent.DATA, result[1]));
		}
		
	}

}