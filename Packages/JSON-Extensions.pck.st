'From Cuis7.1 [latest update: #6786] on 21 October 2024 at 11:03:43 am'!
'Description Adds #asJsonObject conversion to map objects to a form that can be serialized as JSON, short of generating JSON strings.  This is sometimes useful in that the serializable objects can be further composed and manipulated, unlike opaque string representations.'!
!provides: 'JSON-Extensions' 1 1!
!requires: 'JSON' 1 26 nil!
SystemOrganization addCategory: 'JSON-Extensions'!


!classDefinition: #JsonDomainError category: 'JSON-Extensions'!
Error subclass: #JsonDomainError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JSON-Extensions'!
!classDefinition: 'JsonDomainError class' category: 'JSON-Extensions'!
JsonDomainError class
	instanceVariableNames: ''!


!JsonDomainError commentStamp: '<historical>' prior: 0!
Object cannot be converted to a JSON serializable form.  See comment at Object>>#asJsonObject.!

!Object methodsFor: '*JSON-Extensions-converting' stamp: 'ess 10/18/2024 08:58:09'!
asJsonObject
	"Convert this object to a form that can be serialized as JSON.
	
Most objects cannot easily be serialized as JSON, so the default implementation signals an error.  Boolean, UndefinedObject, Float, Integer, and CharacterSequence are serializable.  A SequenceableCollection can be serialized if its elements are serializable, and a Dictionary can be serialized if its keys are strings and its values are serializable."
	JsonDomainError signal! !

!SequenceableCollection methodsFor: '*JSON-Extensions-converting' stamp: 'ess 10/21/2024 11:02:43'!
asJsonObject
	"A SequenceableCollection can be serialized as a JSON array if its elements can be serialized.
	
See comment at Object>>asJsonObject for more details."
	^self collect: #asJsonObject! !

!CharacterSequence methodsFor: '*JSON-Extensions-converting' stamp: 'ess 10/21/2024 11:02:22'!
asJsonObject
	"CharacterSequences serialize directly to JSON as strings.
	
See comment at Object>>asJsonObject for more details."
	^self! !

!CharacterSequence methodsFor: '*JSON-Extensions-converting' stamp: 'ess 10/18/2024 09:45:48'!
asSnakeCase
	"as_snake_case
	
A convenience, as snake_case is commonly used for JSON object keys."
	^self species streamContents: [:outStream |
		self withIndexDo: [:each :i |
			i > 1 & each isUppercase ifTrue: [outStream nextPut: $_].
			outStream nextPut: each asLowercase
		]
	]
! !

!Dictionary methodsFor: '*JSON-Extensions-converting' stamp: 'ess 10/21/2024 11:02:55'!
asJsonObject
	"A Dictionary can be serialized as JSON if its keys are strings and its values are serializable.
	
See comment at Object>>asJsonObject for more details."
	|result|
	result := OrderedDictionary new.
	self keysAndValuesDo: [:key :value |
		(key isKindOf: CharacterSequence) ifFalse: [JsonDomainError signal].
		result at: key put: value asJsonObject
	].
	^result! !

!Boolean methodsFor: '*JSON-Extensions-converting' stamp: 'ess 10/21/2024 11:01:35'!
asJsonObject
	"Booleans serialize directly to JSON as 'true' and 'false'.
	
See comment at Object>>asJsonObject for more details."
	^self! !

!Float methodsFor: '*JSON-Extensions-converting' stamp: 'ess 10/21/2024 11:02:01'!
asJsonObject
	"Floats serialize directly to JSON as numbers.
	
See comment at Object>>asJsonObject for more details."
	^self! !

!Integer methodsFor: '*JSON-Extensions-converting' stamp: 'ess 10/21/2024 11:02:07'!
asJsonObject
	"Integers (between 2^-52 and 2^52-1) serialize directly to JSON as numbers.  (Integers outside this range can also be serialized, but only approximately.)
	
See comment at Object>>asJsonObject for more details."
	^self! !

!UndefinedObject methodsFor: '*JSON-Extensions-converting' stamp: 'ess 10/21/2024 11:01:43'!
asJsonObject
	"The UndefinedObject serializes directly to JSON as 'null'.
	
See comment at Object>>asJsonObject for more details."
	^self! !
