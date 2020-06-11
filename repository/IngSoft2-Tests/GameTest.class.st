Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testAPlayerPlaysTwiceFails [
	| board playerOne playerTwo die game|
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	board := Board withSpaces:10 Laps: 2.
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne with: playerTwo).
	game play: playerOne.
	self
		should: [ game play: playerOne ]
		raise: TurnError
]

{ #category : #tests }
GameTest >> testAtomicBombEffectStaysSameLaps [
	| board playerOne playerTwo die |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	
	board := PracticeBoard
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo)
		withLaps: 3
		withEffect: (Array with: (AtomicBombEffect withProbability: 1)).
	board set: playerOne toPosition: 0 toLap: 1.
	board set: playerTwo toPosition: 8 toLap: 3.
	
	board play: playerOne.
	self assert: playerOne currentLap equals: 1.
	self assert: playerTwo currentLap equals: 3.

]

{ #category : #tests }
GameTest >> testAtomicBombEffectToStartingPosition [
	| board playerOne playerTwo die |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	
	board := PracticeBoard
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo)
		withLaps: 1
		withEffect: (Array with: (AtomicBombEffect withProbability: 1)).
	board set: playerOne toPosition: 0 toLap: 1.
	board set: playerTwo toPosition: 8 toLap: 1.
	
	board play: playerOne.
	self assert: playerOne position equals: 0.
	self assert: playerTwo position equals: 0.

]

{ #category : #tests }
GameTest >> testCompleteOneLap [
	| board playerOne die game|
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	board := Board withSpaces:10 Laps: 2.
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne).
	game play: playerOne.
	game play: playerOne.
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position: 3 lap: 2).
]

{ #category : #tests }
GameTest >> testMoonWalkEffect [
	| board playerOne playerTwo die |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	
	board := PracticeBoard
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo)
		withLaps: 1
		withEffect: (Array with: (MoonWalkEffect withProbability: 1)).
	board set: playerOne toPosition: 0 toLap: 1.
	board set: playerTwo toPosition: 8 toLap: 1.
	
	board play: playerOne.
	self assert: playerOne position equals: 6.
	self assert: playerTwo position equals: 5.

]

{ #category : #tests }
GameTest >> testNoEffect [
	| board playerOne die |
	die := LoadedDie withValue: 3.
	playerOne := Player called: 'Fede'.
	board := Game
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 1
		withEffect: (Array with: (NoEffect withProbability: 1)).
	board play: playerOne.
	self assert: playerOne position equals: 3.
]

{ #category : #tests }
GameTest >> testPlayerDoesNotCrossLastLocker [
	|board playerOne die game|
	die := LoadedDie withValue: 12.
	playerOne := Player called: 'Fede'.
	board := Board withSpaces: 10 Laps: 1.
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne).
	game play: playerOne.
	self assert: (game inWhichPositionIs: playerOne) equals: (board lastLocker).
]

{ #category : #tests }
GameTest >> testPlayerPlays [
	| game board playerOne die |
	die := LoadedDie withValue: 5.
	playerOne := Player called: 'Fede'.
	board := Board withSpaces:10 Laps: 2.
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne).
	game play: playerOne.
	self assert: (game inWhichPositionIs: playerOne) equals: (Locker position: 6 lap: 1).
	
]

{ #category : #tests }
GameTest >> testPlayerPosition [
	| board playerOne playerTwo playerThree die result |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	playerThree := Player called: 'Nicky'.
	board := Game
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo with: playerThree)
		withLaps: 2.
	board play: playerOne.
	board play: playerTwo.
	board play: playerThree.
	board play: playerOne.
	result := OrderedCollection new.
	result add: playerOne.
	result add: playerTwo.
	result add: playerThree.
	self assert: result equals: board oldScoreBoard
]

{ #category : #tests }
GameTest >> testPlayerRank [
	| board playerOne playerTwo die |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	die := LoadedDie withValue: 6.
	board := Game
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo )
		withLaps: 1.
	board play: playerOne.
	self assert: playerOne position equals: 6.
	board play: playerTwo.
	self assert: playerTwo position equals: 6.
	board play: playerOne.
	self assert: playerOne rank equals: 1.
	self assert: playerTwo rank equals: 2.
]

{ #category : #tests }
GameTest >> testPlayerWins [
	| board playerOne die game |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	board := Board withSpaces: 10 Laps: 1.
	game := Game
		withBoard: board
		Dice: die
		Players: (Array with: playerOne).
	game play: playerOne.
	self assert: game hasAWinner not.
	game play: playerOne.
	self
		assert: (game inWhichPositionIs: playerOne)
		equals: board lastLocker.
	self assert: game hasAWinner
]

{ #category : #tests }
GameTest >> testPlayingWithTurnsWithThreePlayers [
	| board playerOne playerTwo playerThree die |
	playerOne := Player called: 'Fede'.
	playerTwo := Player called: 'Glenn'.
	playerThree := Player called: 'Nicky'.
	die := LoadedDie withValue: 6.
	board := Game
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne with: playerTwo with: playerThree)
		withLaps: 1.
	board play: playerOne.
	self assert: playerOne position equals: 6.
	board play: playerTwo.
	self assert: playerTwo position equals: 6.
	board play: playerThree.
	self assert: playerThree position equals: 6.
	board play: playerOne.
	self assert: board winner equals: playerOne
]

{ #category : #tests }
GameTest >> testSpeedUp [
	| board playerOne die |
	die := LoadedDie withValue: 3.
	playerOne := Player called: 'Fede'.
	board := Game
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 1
		withEffect: (Array with: (SpeedUpEffect withProbability: 1)).
	board play: playerOne.
	self assert: playerOne position equals: 7.
]

{ #category : #tests }
GameTest >> testSumOfEffectProbabilitiesNotOverOneHundred [
	| playerOne die  |
	self
		should: [ die := LoadedDie withValue: 6.
			playerOne := Player called: 'Fede'.
			PracticeBoard
				withSpaces: 10
				withDice: die
				withPlayers: (Array with: playerOne)
				withLaps: 1
				withEffect: (Array with: (MoonWalkEffect withProbability: 0.5) with: (WormHoleEffect withProbability: 0.6))]
		raise: CreationError
]

{ #category : #tests }
GameTest >> testWormHoleEffect [
	| board playerOne die |
	die := LoadedDie withValue: 6.
	playerOne := Player called: 'Fede'.
	board := Game
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 1
		withEffect: (Array with: (WormHoleEffect withProbability: 1)).
	board play: playerOne.
	self assert: playerOne position equals: 2.
]

{ #category : #tests }
GameTest >> testWormHoleEffectLimitMove [
	| board playerOne die |
	die := LoadedDie withValue: 3.
	playerOne := Player called: 'Fede'.
	board := Game
		withSpaces: 10
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 1
		withEffect: (Array with: (WormHoleEffect withProbability: 1)).
	board play: playerOne.
	self assert: playerOne position equals: 0.
]

{ #category : #tests }
GameTest >> testWormholeEffectProbability [
	| board playerOne die lastPosition wormHoleCounter noEffectCounter |
	die := LoadedDie withValue: 4.
	wormHoleCounter := 0.
	noEffectCounter := 0.
	playerOne := Player called: 'Fede'.
	board := Game
		withSpaces: 1000
		withDice: die
		withPlayers: (Array with: playerOne)
		withLaps: 10
		withEffect: (Array with: (WormHoleEffect withProbability: 0.4)).
	lastPosition := 0.
	1000
		timesRepeat: [ board play: playerOne.
			playerOne position = lastPosition
				ifTrue: [ wormHoleCounter := wormHoleCounter + 1 ]
				ifFalse: [ noEffectCounter := noEffectCounter + 1 ].
			lastPosition := playerOne position ].
	self assert: (wormHoleCounter between: 350 and: 450).
	self assert: 1000 - wormHoleCounter equals: noEffectCounter
]