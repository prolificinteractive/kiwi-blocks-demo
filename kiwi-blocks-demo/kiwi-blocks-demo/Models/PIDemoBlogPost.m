//
//  PIDemoBlogPost.m
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "PIDemoBlogPost.h"

@implementation PIDemoBlogPost

#pragma mark - Protocol conformance

#pragma mark PIDemoModelProtocol

+ (instancetype)modelFromJSONDictionary:(NSDictionary *)JSONDictionary {

  PIDemoBlogPost *blogPost = [[PIDemoBlogPost alloc] init];

  blogPost.title = JSONDictionary[@"title"];
  blogPost.url = [NSURL URLWithString:JSONDictionary[@"url"]];

  return blogPost;
}

@end
