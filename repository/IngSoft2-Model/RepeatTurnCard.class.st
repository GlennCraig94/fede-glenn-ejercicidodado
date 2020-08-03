Class {
	#name : #RepeatTurnCard,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #'effect application' }
RepeatTurnCard >> applyTo: aGame [
	aGame applyRepeatTurnCard
]

{ #category : #classification }
RepeatTurnCard >> isPermanent [
	^false
]
