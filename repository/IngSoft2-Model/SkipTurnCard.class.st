Class {
	#name : #SkipTurnCard,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #'effect application' }
SkipTurnCard >> applyTo: aGame [
	aGame applySkipTurnCard
]

{ #category : #classification }
SkipTurnCard >> isPermanent [
	^ false
]
