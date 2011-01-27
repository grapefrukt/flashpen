package com.grapefrukt.clients.playpen.events {
	import com.grapefrukt.clients.playpen.loader.PageLoader;
	import com.grapefrukt.clients.playpen.models.PageModel;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class PageEvent extends Event {
		
		public static const STATE_CHANGE	:String = "pageevent_state_change";
		public static const REQUEST_LOAD	:String = "pageevent_request_load";
		
		private var _page:PageModel;
		private var _loader:PageLoader;
		
		public function PageEvent(type:String, page:PageModel, loader:PageLoader = null) { 
			super(type, bubbles, cancelable);
			_loader = loader;
			_page = page;
		} 
		
		public override function clone():Event { 
			return new PageEvent(type, _page, _loader);
		} 
		
		public function get page():PageModel { return _page; }
		public function get loader():PageLoader { return _loader; }		
		
	}
	
}