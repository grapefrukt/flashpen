package com.grapefrukt.clients.playpen.models {
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class LinkModel {
		
		private var _label	:String;
		private var _target	:PageModel;
		
		public function LinkModel(label:String, target:PageModel) {
			_target = target;
			_label = label;	
		}
		
		public function get label():String { return _label; }
		public function get target():PageModel { return _target; }
		
	}

}