"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMyCounter,
	#superclass : #PackageManifest,
	#category : #'MyCounter-Manifest'
}

{ #category : #'code-critics' }
ManifestMyCounter class >> ruleRBInconsistentMethodClassificationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ApiServerTeapotTest #setUp #false)) #'2021-11-09T12:18:09.656468+01:00') )
]

{ #category : #'code-critics' }
ManifestMyCounter class >> ruleRBUncommonMessageSendRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ApiServerTeapotTest #setUp #false)) #'2021-11-09T12:17:53.493542+01:00') )
]
