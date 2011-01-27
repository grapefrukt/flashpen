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
			var p:PageModel = _pages[name];
			if (!p) {
				p = new PageModel(name);
				_pages[name] = p;
				PageLoader.load(p);
			} else {
				trace("cache hit!")
			}
			
			return p;
		}
		
	}

}