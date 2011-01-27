package com.grapefrukt.clients.playpen.loader {
	import com.grapefrukt.clients.playpen.models.PageModel;
	import com.grapefrukt.clients.playpen.parser.PageParser;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class PageLoader {
		
		private static const BASE_URL:String = 	 'http://playpen.farbs.org/index.php?title='
		private static const ACTION_URL:String = '&action=raw';
		private static const REDIRECT_REGEX:RegExp = /#REDIRECT \[\[(.*?)]]/g;
		private static const VALIDATE_REGEX:RegExp = /\<ppimage\>(.*?)\<\/ppimage\>/s;
		
		public static function load(page:PageModel, overrideName:String = ''):void {
			trace("loading", page.name, overrideName);
			
			var l:URLLoader = new URLLoader;
			var u:URLRequest = new URLRequest(BASE_URL + (overrideName || page.name) + ACTION_URL);
			
			l.addEventListener(Event.COMPLETE, function(e:Event):void {
				var redirect:* = REDIRECT_REGEX.exec(l.data);
				if (redirect) {
					load(page, redirect[1]);
					return;
				}
				
				trace("parsing", page.name);
				
				var result:* = VALIDATE_REGEX.exec(l.data);
				if (!result) return;
				
				PageParser.parse(result[1], page);
				page.setLoaded();
			});
			
			l.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event):void {
				
			});
			
			l.load(u);
		}
		
	}

}