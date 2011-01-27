package com.grapefrukt.clients.playpen.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Martin Jonasson (m@webbfarbror.se)
	 */
	public class PageLoaderEvent extends Event {
		
		public static const DATA	:String = "pageloaderevent_data";
		public static const ERROR	:String = "pageloaderevent_error";
		
		private var _data:String;
		
		public function PageLoaderEvent(type:String, data:String = '') { 
			super(type, bubbles, cancelable);
			_data = data;
			
		} 
		
		public override function clone():Event { 
			return new PageLoaderEvent(type, _data);
		} 
		
		public override function toString():String { 
			return formatToString("PageLoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get data():String { return _data; }
		
	}
	
}