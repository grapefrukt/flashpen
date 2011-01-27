package com.grapefrukt.clients.playpen.events {
	import com.grapefrukt.clients.playpen.models.PageModel;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class PageEvent extends Event {
		
		public static const COMPLETE:String = "pageevent_complete";
		
		private var _page:PageModel;
		
		public function PageEvent(type:String, page:PageModel) { 
			super(type, bubbles, cancelable);
			_page = page;
		} 
		
		public override function clone():Event { 
			return new PageEvent(type, _page);
		} 
		
		public function get page():PageModel { return _page; }
		
	}
	
}