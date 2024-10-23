'From Cuis7.1 [latest update: #6770] on 18 October 2024 at 9:47:01 am'!
'Description '!
!provides: 'Tests-JSON Extensions' 1 3!
!requires: 'JSON-Extensions' 1 1 nil!
SystemOrganization addCategory: #'Tests-JSON Extensions'!


!classDefinition: #JsonExtensionsTests category: #'Tests-JSON Extensions'!
TestCase subclass: #JsonExtensionsTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tests-JSON Extensions'!
!classDefinition: 'JsonExtensionsTests class' category: #'Tests-JSON Extensions'!
JsonExtensionsTests class
	instanceVariableNames: ''!


!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:33:32'!
testBoolean
	"Booleans serialize as 'false' or 'true'."
	#(false true) do: [:each | self assert: each asJsonObject equals: each]! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:23:11'!
testCharacterSequence
	"CharacterSequences serialize as JSON strings."
	self assert: 'string' asJsonObject equals: 'string'! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:30:13'!
testDictionary
	"Dictionaries serialize as JSON objects, given appropriate keys and values."
	|dict|
	dict := {'one' -> 1 . 'two' -> 2} asDictionary.
	self assert: dict asJsonObject equals: dict.
	self assert: Dictionary new asJsonObject equals: Dictionary new! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:29:08'!
testDictionaryKeyError
	"Dictionary keys must be strings."
	self
		should: [{1 -> 'one'. 2 -> 'two'} asDictionary asJsonObject]
		raise: JsonDomainError! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:32:39'!
testDictionaryValueError
	"Dictionary values must be serializable."
	self
		should: [{'an' -> Object new} asDictionary asJsonObject]
		raise: JsonDomainError! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:22:50'!
testNumber
	"Integers and Floats serialize as JSON numbers."
	#(1 3.14) do: [:each | self assert: each asJsonObject equals: each]! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:31:53'!
testNumberError
	"Rational (or Complex) numbers do not serialize."
	self
		should: [(1/2) asJsonObject]
		raise: JsonDomainError! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:34:02'!
testObjectError
	"Objects do not generally serialize."
	self
		should: [Object new asJsonObject]
		raise: JsonDomainError! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:25:50'!
testSequenceableCollection
	"Sequences serialize as JSON arrays, given appropriate elements."
	self assert: #(1 2 3) asJsonObject equals: #(1 2 3).
	self assert: #() asJsonObject equals: #()! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:30:35'!
testSequenceableCollectionError
	"The elements of a serializable sequence must also be serializable."
	self
		should: [{Object new. Set new} asJsonObject]
		raise: JsonDomainError! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:43:25'!
testSnakeCase
	#('test_snake_case' 'testSnakeCase' 'TestSnakeCase') do: [:each |
		self assert: each asSnakeCase equals: 'test_snake_case'
	]! !

!JsonExtensionsTests methodsFor: 'as yet unclassified' stamp: 'ess 10/18/2024 09:22:13'!
testUndefinedObject
	"UndefinedObject serializes as 'null'."
	self assert: nil asJsonObject equals: nil! !
