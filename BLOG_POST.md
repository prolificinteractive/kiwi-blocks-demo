# Kiwi and Blocks

While Prolific is no stranger to testing frameworks, one of our recent iOS projects has familiarized us with a new one: [Kiwi](https://github.com/kiwi-bdd/Kiwi). Kiwi is described as a "Behavior Driven Development (BDD) library for iOS development" - meaning it allows developers to write "specs" in code about expected behavior. The purpose of defining behavior is to catch when it unintentionally changes during refactors or implementation of new features. 

![Kiwi logo](https://raw.githubusercontent.com/prolificinteractive/kiwi-blocks-demo/feature/blog_post/images/kiwi1.png?token=AFNCYU3rHjEtZVJGJxmuko8fL2xczDdHks5VWnqHwA%3D%3D "Kiwi logo")

Kiwi exists in an ecosystem of iOS [testing](https://developer.apple.com/library/ios/documentation/DeveloperTools/Conceptual/testing_with_xcode/Introduction/Introduction.html) [frameworks](https://github.com/specta/specta) [gaining](https://github.com/kif-framework/KIF) [popularity](https://github.com/calabash/calabash-ios) [among](https://github.com/facebook/ios-snapshot-test-case) [developers](https://github.com/Quick/Quick). There are plenty of great pieces out there exploring the pros and cons of each - and there is no definitive call on which should be used. However, what is becoming more definitive is that iOS applications are not exempt from the general notion that testing frameworks play a role in developing quality software. If you're exploring or using tests in your iOS development and Kiwi is your testing framework of choice, read on as I explore one of its lesser documented features: the ability to stub the behavior of methods that execute blocks.

## Business Specifications

You've been given the task of writing an application that displays blog posts. This is what the JSON you're expected to work with is going to look like:

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

## Kiwi Specifications