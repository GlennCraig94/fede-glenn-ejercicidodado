Class {
	#name : #ReverseTurnsCard,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #'effect application' }
ReverseTurnsCard >> applyTo: aGame [
	aGame applyReverseTurnsCard
]

{ #category : #classification }
ReverseTurnsCard >> isPermanent [
	^ false
]
