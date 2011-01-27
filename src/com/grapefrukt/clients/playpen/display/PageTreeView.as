package com.grapefrukt.clients.playpen.display {
	import com.grapefrukt.clients.playpen.events.PageEvent;
	import com.grapefrukt.clients.playpen.models.LinkModel;
	import com.grapefrukt.clients.playpen.models.PageCollection;
	import com.grapefrukt.clients.playpen.models.PageModel;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Martin Jonasson (m@webbfarbror.se)
	 */
	public class PageTreeView extends Sprite {
		
		private var _collection		:PageCollection;
		private var _nearby_pages	:Vector.<PageView>;
		private var _page			:PageView;
		
		public function PageTreeView(collection:PageCollection) {
			_collection = collection;
			_nearby_pages = new Vector.<PageView>();
			
			_collection.addEventListener(PageEvent.SHOW, handlePageShow)
			_collection.addEventListener(PageEvent.STATE_CHANGE, handlePageStateChange)
		}
		
		private function handlePageShow(e:PageEvent):void {
			if (_page) removeChild(_page);
			
			_page = new PageView(e.page);
			addChild(_page);
			
			if (e.page.state == PageModel.STATE_LOADED) addNearby(e.page);
			
			trace("showing", e.page.name, "with", _nearby_pages.length, "pages nearby");
		}
		
		private function handlePageStateChange(e:PageEvent):void {
			if (_page && e.page == _page.page && e.page.state == PageModel.STATE_LOADED) {
				addNearby(e.page);
			}
		}
		
		private function addNearby(page:PageModel):void {
			while (_nearby_pages.length) {
				removeChild(_nearby_pages.pop());
			}
			
			for each (var link:LinkModel in page.links) {
				if (link && link.target) {
					var pv:PageView = new PageView(link.target, true);
					_nearby_pages.push(pv);
					addChildAt(pv, 0);
				}
			}
			
			for (var i:int = 0; i < _nearby_pages.length; i++) {
				var angle:Number = (i / _nearby_pages.length) * Math.PI * 2;
				_nearby_pages[i].x = Math.sin(angle) * 325;
				_nearby_pages[i].y = Math.cos(angle) * 250;
			}
		}
		
	}

}