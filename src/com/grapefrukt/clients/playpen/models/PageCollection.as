package com.grapefrukt.clients.playpen.models {
	
	import com.grapefrukt.clients.playpen.events.PageEvent;
	import com.grapefrukt.clients.playpen.loader.PageLoader;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	
	[Event(name = "pageevent_show", type = "com.grapefrukt.clients.playpen.events.PageEvent")]
	
	public class PageCollection extends EventDispatcher {
		
		private var _pages	:Dictionary;
		private var _home	:PageModel;
		private var _current:PageModel;
		private var _last	:PageModel;
		
		public function PageCollection(startPage:String) {
			_pages = new Dictionary();
			_home = _current = getPage(startPage);
		}
		
		public function getPage(name:String):PageModel {
			if (name == "") return null;
			
			if (!_pages[name]) {
				_pages[name] = new PageModel(this, name);
				_pages[name].addEventListener(PageEvent.STATE_CHANGE, handlePageStateChange);
				_pages[name].addEventListener(PageEvent.REQUEST_LOAD, handlePageRequestLoad);
				_pages[name].addEventListener(PageEvent.SHOW, 		  handlePageShow);
			}
			
			return _pages[name];
		}

		private function handlePageShow(e:PageEvent):void {
			_current = e.page;
			_current.load();
			preloadNearby(_current);
			dispatchEvent(e);
		}
		
		private function handlePageRequestLoad(e:PageEvent):void {
			e.loader.load();
		}
		
		private function handlePageStateChange(e:PageEvent):void {
			if (e.page == _current && _current.state == PageModel.STATE_LOADED) preloadNearby(_current);
			dispatchEvent(e);
		}
		
		private function preloadNearby(page:PageModel):void {
			for each (var link:LinkModel in page.links) {
				if (link && link.target) link.target.load();
			}
		}
		
		public function get current():PageModel { return _current; }
		public function get home():PageModel { return _home; }
		
	}

}