package flash.events;


import massive.munit.Assert;


class EventDispatcherTest {
	
	
	@Test public function new () {
		
		var dispatcher = new EventDispatcher ();
		
		Assert.isNotNull (dispatcher);
		
		var dispatcher2 = new EventDispatcher (dispatcher);
		
		Assert.isNotNull (dispatcher2);
		
	}
	
	
	@Test public function addEventListener () {
		
		var dispatcher = new EventDispatcher ();
		dispatcher.addEventListener ("event", function (_) {});
		
		Assert.isTrue (dispatcher.hasEventListener ("event"));
		
	}
	
	
	@Test public function dispatchEvent () {
		
		// Standard
		
		var caughtEvent = false;
		var dispatcher = new EventDispatcher ();
		
		var listener = function (_) { 
			
			caughtEvent = true;
			
		};
		
		dispatcher.addEventListener ("event", listener);
		dispatcher.dispatchEvent (new Event ("event"));
		
		Assert.isTrue (caughtEvent);
		
		// Capture is true
		
		var correctPhase = true;
		var dispatcher = new EventDispatcher ();
		
		var listener = function (event:Event) {
			
			correctPhase = (event.eventPhase == EventPhase.CAPTURING_PHASE);
			
		}
		
		dispatcher.addEventListener ("event", listener, true);
		dispatcher.dispatchEvent (new Event ("event"));
		
		Assert.isTrue (correctPhase);
		
		// Capture is false
		
		var correctPhase = true;
		var dispatcher = new EventDispatcher ();
		
		var listener = function (event:Event) { 
			
			if (event.eventPhase == EventPhase.CAPTURING_PHASE) {
				
				correctPhase = false;
				
			}
			
		}
		
		dispatcher.addEventListener ("event", listener, false);
		dispatcher.dispatchEvent (new Event ("event"));
		
		Assert.isTrue (correctPhase);
		
		// First in, first out standard order
		
		var correctOrder = true;
		var dispatcher = new EventDispatcher ();
		
		var listener = function (_) {
			
			correctOrder = false;
			
		}
		
		var listener2 = function (_) {
			
			correctOrder = true;
			
		}
		
		dispatcher.addEventListener ("event", listener);
		dispatcher.addEventListener ("event", listener2);
		
		Assert.isTrue (correctOrder);
		
		// Order by priority
		
		var correctOrder = true;
		var dispatcher = new EventDispatcher ();
		
		var listener = function (_) {
			
			correctOrder = false;
			
		}
		
		var listener2 = function (_) {
			
			correctOrder = true;
			
		}
		
		dispatcher.addEventListener ("event", listener2, false, 10);
		dispatcher.addEventListener ("event", listener, false, 20);
		dispatcher.dispatchEvent (new Event ("event"));
		
		Assert.isTrue (correctOrder);
		
	}
	
	
	@Test public function hasEventListener () {
		
		
		
	}
	
	
	@Ignore @Test public function removeEventListener () {
		
		var dispatcher = new EventDispatcher ();
		var listener = function (_) {};
		dispatcher.addEventListener ("event", listener);
		dispatcher.removeEventListener ("event", listener);
		
		Assert.isFalse (dispatcher.hasEventListener ("event"));
		
	}
	
	
	/*@Ignore @Test public function toString () {
		
		
		
	}*/
	
	
	@Ignore @Test public function willTrigger () {
		
		
		
	}
	
	
}