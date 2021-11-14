"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMyCounter,
	#superclass : #PackageManifest,
	#category : #'MyCounter-Manifest'
}

{ #category : #'code-critics' }
ManifestMyCounter class >> ruleGRBlockFormattingRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Counters #increment: #false)) #'2021-11-13T12:06:49.261188+01:00') )
]

{ #category : #'code-critics' }
ManifestMyCounter class >> ruleGRUsesCurlyBraceArraysRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'ApiServerTeapot class' #createAt: #true)) #'2021-11-12T20:58:02.327359+01:00') )
]

{ #category : #'code-critics' }
ManifestMyCounter class >> ruleRBImplementedNotSentRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'ApiServerTeapot class' #createAt: #true)) #'2021-11-12T20:54:52.916373+01:00') )
]

{ #category : #'code-critics' }
ManifestMyCounter class >> ruleRBInconsistentMethodClassificationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ApiServerTeapotTest #setUp #false)) #'2021-11-09T12:18:09.656468+01:00') )
]

{ #category : #'code-critics' }
ManifestMyCounter class >> ruleRBSendsUnknownMessageToGlobalRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'ApiServerTeapot class' #createAt: #true)) #'2021-11-12T20:54:28.754396+01:00') )
]

{ #category : #'code-critics' }
ManifestMyCounter class >> ruleRBSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'ApiServerTeapot class' #createAt: #true)) #'2021-11-12T20:54:44.879937+01:00') )
]

{ #category : #'code-critics' }
ManifestMyCounter class >> ruleRBUncommonMessageSendRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ApiServerTeapotTest #setUp #false)) #'2021-11-09T12:17:53.493542+01:00') #(#(#RGMetaclassDefinition #(#'ApiServerTeapot class' #ApiServerTeapot)) #'2021-11-12T20:54:24.523278+01:00') )
]
