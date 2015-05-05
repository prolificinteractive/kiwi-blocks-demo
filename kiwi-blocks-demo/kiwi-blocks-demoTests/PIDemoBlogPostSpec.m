//
//  PIDemoBlogPostSpec.m
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "Kiwi.h"
#import "PIDemoModelProtocol.h"
#import "PIDemoBlogPost.h"

SPEC_BEGIN(PIDemoBlogPostSpec)

__block NSDictionary *json;
__block PIDemoBlogPost *blogPost;

beforeAll(^{

  json = @{
    @"title" : @"First day on the Planet Express",
    @"url" : @"http://some.website/blog/first-day"
  };

  blogPost = [PIDemoBlogPost modelFromJSONDictionary:json];

});

describe(@"PIDemoBlogPost", ^{

  describe(@"Protocol: PIDemoModelProtocol", ^{

    it(@"Should conform", ^{

      [[blogPost should] conformToProtocol:@protocol(PIDemoModelProtocol)];

    });
  });

  describe(@"Class method: modelFromJSONDictionary", ^{

    it(@"Should create model with correct properties", ^{

      [[blogPost.title should] equal:@"First day on the Planet Express"];
      [[blogPost.url.absoluteString should]
          equal:@"http://some.website/blog/first-day"];

    });

  });
});

SPEC_END
