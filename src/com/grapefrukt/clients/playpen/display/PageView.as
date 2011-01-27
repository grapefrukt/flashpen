package com.grapefrukt.clients.playpen.display {
	import com.grapefrukt.clients.playpen.models.LinkModel;
	import com.grapefrukt.clients.playpen.models.PageModel;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Martin Jonasson (m@webbfarbror.se)
	 */
	public class PageView extends Sprite {
		
		private var _page:PageModel;
		private var _bmp:Bitmap;
		private var _thumbnail:Boolean;
		
		public function PageView(page:PageModel, thumbnail:Boolean = false) {
			_thumbnail = thumbnail;
			_page = page;
			
			_bmp = new Bitmap(page.image);
			_bmp.scaleX = _bmp.scaleY = 5;
			_bmp.x = -_bmp.width / 2;
			_bmp.y = -_bmp.height / 2;
			addChild(_bmp);
			
			if (_thumbnail) {
				scaleX = scaleY = .5;
			}
			
			mouseChildren = false;
			
			addEventListener(MouseEvent.MOUSE_MOVE, handleMouse);
			addEventListener(MouseEvent.CLICK, handleMouse);
		}
		
		private function handleMouse(e:MouseEvent):void {
			var xpos:int = (mouseX - _bmp.x) / _bmp.scaleX;
			var ypos:int = (mouseY - _bmp.y) / _bmp.scaleY;
			var link:LinkModel = _page.getLink(xpos, ypos);
			
			buttonMode = _thumbnail ? true : link != null;
			
			if (e.type == MouseEvent.CLICK) {
				if (!_thumbnail && link)	link.target.show();
				if (_thumbnail) _page.show();
			}
			
		}
		
		public function get page():PageModel { return _page; }
		
	}

}