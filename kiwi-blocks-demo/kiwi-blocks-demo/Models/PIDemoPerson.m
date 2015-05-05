//
//  PIDemoPerson.m
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "PIDemoPerson.h"

@implementation PIDemoPerson

#pragma mark - Protocol conformance

#pragma mark PIDemoModelProtocol

+ (instancetype)modelFromJSONDictionary:(NSDictionary *)JSONDictionary {

  PIDemoPerson *person = [[PIDemoPerson alloc] init];

  person.name = JSONDictionary[@"name"];
  person.role = JSONDictionary[@"role"];
  person.blogPosts = @[];

  return person;
}

@end
