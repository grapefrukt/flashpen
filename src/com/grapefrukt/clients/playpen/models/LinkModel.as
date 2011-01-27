package com.grapefrukt.clients.playpen.models {
	/**
	 * ...
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	public class LinkModel {
		
		private var _label:String;
		private var _target:String;
		
		public function LinkModel(label:String, target:String) {
			_target = target;
			_label = label;	
		}
		
		public function get label():String { return _label; }
		public function get target():String { return _target; }
		
	}

}