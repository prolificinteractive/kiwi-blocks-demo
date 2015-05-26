# Kiwi and Blocks

A recent iOS project has familiarized Prolific with a new testing framework for us: [Kiwi](https://github.com/kiwi-bdd/Kiwi). Kiwi is described as a "Behavior Driven Development (BDD) library for iOS development" - meaning it provides a format for verifying expected code _behavior_. The purpose of defining behavior is to catch when it unintentionally changes during refactors or implementation of new features. 

![Kiwi logo](https://raw.githubusercontent.com/prolificinteractive/kiwi-blocks-demo/feature/blog_post/images/kiwi1.png?token=AFNCYa8wDXlhi2PZbrN9ffO03SK11W9Eks5Vbe6-wA%3D%3D "Kiwi logo")

Kiwi exists in an ecosystem of [testing](https://developer.apple.com/library/ios/documentation/DeveloperTools/Conceptual/testing_with_xcode/Introduction/Introduction.html) [frameworks](https://github.com/specta/specta) [gaining](https://github.com/kif-framework/KIF) [popularity](https://github.com/calabash/calabash-ios) [among](https://github.com/facebook/ios-snapshot-test-case) [iOS](https://github.com/pivotal/cedar) [developers](https://github.com/Quick/Quick). There are plenty of great pieces out there exploring the pros and cons of each - and there is no definitive call on which is best to use. However, what is becoming more definitive is that iOS applications are not exempt from the notion that testing frameworks can help greatly in developing quality software. 

If you're exploring or using tests in your iOS development and Kiwi is your framework of choice, read on as I explore one of its lesser documented features: the ability to use a block when stubbing methods.

## The Assignment

You've been given the task of writing an application that displays blog posts associated with people. This is what the JSON you're expected to work with is going to look like:

``` JSON
{
	"people" : [
		{
			"name" : "Jorge Luis Mendez",
			"role" : "Senior iOS Engineer",
			"blog_posts" : [
				{
					"title" : "Making Mantle Deserialization Generic",
					"url" : "http://blog.prolificinteractive.com/2014/12/15/making-mantle-deserialization-generic/"
				},
				{
					"title" : "Why Use NS_OPTIONS for Bitmasks",
					"url" : "http://blog.prolificinteractive.com/2015/03/18/why-use-ns_options-for-bitmasks/"
				}
			]
		},
		{
			"name" : "Irene Duke",
			"role" : "Senior Android Engineer",
			"blog_posts" : [
				{
					"title" : "A New Beginning",
					"url" : "http://blog.prolificinteractive.com/2014/11/19/new-beginning/"
				}
			]
		}
	]
}
```

You've also heard that the server isn't up yet. But, thats's okay - you know Kiwi can help you write code that behaves properly without that piece in place. Let's take a look at the start of this very application: http://github.com/prolificinteractive/kiwi-blocks-demo

### Setup

The demo project has elements of how a typical Prolific application may start - a class that represents network interaction (`PIDemoServer`), classes that represent the core application models (`PIDemoPerson`, `PIDemoBlogPost`), and a class that acts as a layer between application code and the details of retrieving JSON from the network and translating it into models (`PIDemoDataStore`). The key methods in `PIDemoServer` and `PIDemoDataStore` utilize `completion` blocks to interact with their calling classes. 

Given our focus on one specific Kiwi stub type, there are details missing from what a Prolific project might actually look like - most notably, a robust strategy for translating models (Prolific often uses [Mantle](http://blog.prolificinteractive.com/2014/12/15/making-mantle-deserialization-generic/)). Also, given this application is supposed to be covered by tests, there should be test specs for how our server and model classes are to behave. However, the type of test we're interested in is in `PIDemoDataStoreSpec` - let's take a look.

### Kiwi

