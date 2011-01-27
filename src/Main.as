package  {
	import com.grapefrukt.clients.playpen.display.PageTreeView;
	import com.grapefrukt.clients.playpen.events.PageEvent;
	import com.grapefrukt.clients.playpen.models.LinkModel;
	import com.grapefrukt.clients.playpen.models.PageCollection;
	import com.grapefrukt.clients.playpen.models.PageModel;
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
		
		private var _pages	:PageCollection;
		private var _tree	:PageTreeView;
		
		public static const STAGE_W:int = 800;
		public static const STAGE_H:int = 600;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_pages = new PageCollection('Main_Page');
			_tree = new PageTreeView(_pages);
			_tree.x = STAGE_W / 2;
			_tree.y = STAGE_H / 2;
			addChild(_tree);
			
			_pages.current.show();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboard);
			
		}
		
		private function handleKeyboard(e:KeyboardEvent):void {	
			if (e.keyCode == Keyboard.SPACE) {
				_pages.home.show();
			}
		}

	}

}