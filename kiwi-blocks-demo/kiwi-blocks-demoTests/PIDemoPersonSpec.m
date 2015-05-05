//
//  PIDemoPersonSpec.m
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "Kiwi.h"
#import "PIDemoModelProtocol.h"
#import "PIDemoBlogPost.h"
#import "PIDemoPerson.h"

SPEC_BEGIN(PIDemoPersonSpec)

__block NSDictionary *json;
__block PIDemoPerson *person;

beforeAll(^{

  json = @{
    @"name" : @"Leela",
    @"role" : @"Space Captain",
    @"blog_posts" : @[
      @{
        @"title" : @"First day on the Planet Express",
        @"url" : @"http://some.website/blog/first-day"
      }
    ]
  };

  person = [PIDemoPerson modelFromJSONDictionary:json];

});

describe(@"PIDemoPerson", ^{

  describe(@"Protocol: PIDemoModelProtocol", ^{

    it(@"Should conform", ^{

      [[person should] conformToProtocol:@protocol(PIDemoModelProtocol)];

    });
  });

  describe(@"Class method: modelFromJSONDictionary", ^{

    it(@"Should create model with correct properties", ^{

      [[person.name should] equal:@"Leela"];
      [[person.role should] equal:@"Space Captain"];

      PIDemoBlogPost *blogPost = person.blogPosts[0];
      [[blogPost.title should] equal:@"First day on the Planet Express"];
      [[blogPost.url.absoluteString should]
          equal:@"http://some.website/blog/first-day"];

    });

  });
});

SPEC_END
