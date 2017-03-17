package tink.testrunner;

import tink.testrunner.Case;

using tink.CoreApi;

@:forward
abstract Suite(SuiteObject) from SuiteObject to SuiteObject {
	
	@:from
	public static inline function ofCases<T:Case>(cases:Array<T>):Suite
		return new BasicSuite({
			name: [for(c in cases) switch Type.getClass(c) {
				case null: null;
				case c: Type.getClassName(c);
			}].join(', '),
		}, cast cases);
	
	@:from
	public static inline function ofCase(caze:Case):Suite
		return ofCases([caze]);
}

interface SuiteObject {
	var info:SuiteInfo;
	var cases:Array<Case>;
	var startup:Services;
	var before:Services;
	var after:Services;
	var shutdown:Services;
}

typedef SuiteInfo = {
	name:String,
}


class BasicSuite implements SuiteObject {
	public var info:SuiteInfo;
	public var cases:Array<Case>;
	public var startup:Services;
	public var before:Services;
	public var after:Services;
	public var shutdown:Services;
	
	public function new(info, cases, ?startup, ?before, ?after, ?shutdown) {
		this.info = info;
		this.cases = cases;
		this.startup = startup != null ? startup : [];
		this.before = before != null ? before : [];
		this.after = after != null ? after : [];
		this.shutdown = shutdown != null ? shutdown : [];
	}
}