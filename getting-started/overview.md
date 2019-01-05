# Overview

`tink_testrunner` logically breaks down a test suite into several major parts:

## Assertion

Contains the result, a human-readable description and position of an assertion.

```haxe
class Assertion {
	public var holds(default, null):Bool;
	public var description(default, null):String;
	public var pos(default, null):PosInfos;
}
```

[Read more...](basics/assertion.md)

## Assertions

A collection of Assertion. 

A naive repsentation would be `Array<Assertion>`.
But we chose to use `Stream<Assertion>` in order to support async tests.
After all, `Stream` is the async counterpart of `Array`.

[Read more...](basics/multi-assertions.md)

## Case

A function that emits Assertions.

So it is basically `Void->Assertions`. However, in order to support more fine-grain controls
on what tests to be included/excluded, the actual implementation of a Case does include some extra control informations.

```haxe
interface Case {
	var info:CaseInfo; // meta info such as descriptions, etc
	var timeout:Int; // timeout in ms
	var include:Bool; // include only this case while running
	var exclude:Bool; // exclude this case while running
	function execute():Assertions;
}
```

[Read more...](basics/case.md)

## Suite

A collection of Cases.

So basically it is `Array<Case>`. However, we may also want to execute some pre/post actions for a case,
so the actual implementation looks like this:

```haxe
interface Suite {
	var info:SuiteInfo; // meta info
	var cases:Array<Case>;
	function setup():Promise<Noise>; // to be run once before all cases
	function before():Promise<Noise>; // to be run before each cases
	function after():Promise<Noise>; // to be run after each cases
	function teardown():Promise<Noise>; // to be run once after all cases
}
```

[Read more...](basics/suite.md)

## Batch

A colllection of Suites.

This time it is really just `Array<Suite>`.

## Runner

A Runner will take a Batch and run it, then emits the results to a reporter.

[Read more...](basics/runner.md)

## Reporter

A Reporter reports the progress of a Runner to user. There is not much to say about it.

[Read more...](basics/reporter.md)

