package  {
	import com.grapefrukt.clients.playpen.events.PageEvent;
	import com.grapefrukt.clients.playpen.models.LinkModel;
	import com.grapefrukt.clients.playpen.models.PageCollection;
	import com.grapefrukt.clients.playpen.models.PageModel;
	import com.grapefrukt.clients.playpen.parser.PageParser;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;

	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	
	[Frame(factoryClass = "Preloader")]
	
	public class Main extends Sprite {
		
		private var _pages			:PageCollection;
		private var _current_page	:PageModel;
		private var _last_page		:PageModel;
		private var _bmp			:Bitmap;
		private var _tf				:TextField;

		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_pages = new PageCollection;
			
			_bmp = new Bitmap();
			_bmp.scaleX = _bmp.scaleY = 5;
			addChild(_bmp);
			
			setPage(_pages.getPage('Main_Page'));
			//setPage(_pages.getPage('Commander Video'));
			
			_tf = new TextField();
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.x = 10;
			_tf.y = _bmp.height + 10;
			addChild(_tf);
			
			addEventListener(MouseEvent.MOUSE_MOVE, handleMouse);
			addEventListener(MouseEvent.CLICK, handleMouse);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboard);
			
		}
		
		private function handleKeyboard(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.BACKSPACE) {
				if(_last_page) setPage(_last_page);
			}
			
			if (e.keyCode == Keyboard.SPACE) {
				setPage(_pages.getPage('Main_Page'));
			}
		}
		
		private function handleMouse(e:MouseEvent):void {
			var xpos:int = mouseX / _bmp.scaleX;
			var ypos:int = mouseY / _bmp.scaleY;
			var link:LinkModel = _current_page.getLink(xpos, ypos);
			_tf.text = (link ? link.label.replace(/\\n/g, '\n') : '');
			if (link && e.type == MouseEvent.CLICK) {
				setPage(link.target);
			}
		}
		
		private function setPage(page:PageModel):void{
			_last_page = _current_page;
			_current_page = page;
			
			if (_last_page) _last_page.removeEventListener(PageEvent.STATE_CHANGE, handleCurrentPageStateChange)
			
			if (_current_page.state == PageModel.STATE_LOADED) {
				handleCurrentPageStateChange(null);
			} else {
				_current_page.addEventListener(PageEvent.STATE_CHANGE, handleCurrentPageStateChange)
			}
			
			_current_page.load();
			
			_bmp.bitmapData = page.image;
		}
		
		private function handleCurrentPageStateChange(e:PageEvent):void {
			for each (var link:LinkModel in _current_page.links) {
				if (link && link.target) link.target.load();
			}
		}

	}

}