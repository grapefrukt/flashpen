package com.grapefrukt.clients.playpen.models {
	
	import com.grapefrukt.clients.playpen.events.PageEvent;
	import com.grapefrukt.clients.playpen.loader.PageLoader;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class PageCollection {
		
		private var _pages:Dictionary;
		
		public function PageCollection() {
			_pages = new Dictionary();
		}
		
		public function getPage(name:String):PageModel {
			if (!_pages[name]) {
				_pages[name] = new PageModel(this, name);
				_pages[name].addEventListener(PageEvent.STATE_CHANGE, handlePageStateChange);
				_pages[name].addEventListener(PageEvent.REQUEST_LOAD, handlePageRequestLoad);
			}
			
			return _pages[name];
		}
		
		private function handlePageRequestLoad(e:PageEvent):void {
			e.loader.load();
		}
		
		private function handlePageStateChange(e:PageEvent):void {
			
		}
		
	}

}