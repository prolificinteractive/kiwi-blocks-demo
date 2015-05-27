//
//  PIDemoDataStoreSpec.m
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/5/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "Kiwi.h"
#import "PIDemoBlogPost.h"
#import "PIDemoDataStore.h"
#import "PIDemoPerson.h"
#import "PIDemoServer.h"

SPEC_BEGIN(PIDemoDataStoreSpec)

describe(@"PIDemoDataStore", ^{

  describe(@"Class method: fetchPeopleWithCompletion:", ^{

    typedef void (^PIDemoServerCallback)(id JSON, NSError *error);

    context(@"Data fetched successfully", ^{

      __block NSDictionary *json;

      beforeEach(^{

        json = @{
          @"people" : @[
            @{
              @"name" : @"Jorge Luis Mendez",
              @"role" : @"Senior iOS Engineer",
              @"blog_posts" : @[
                @{
                  @"title" : @"Making Mantle Deserialization Generic",
                  @"url" : @"http://blog.prolificinteractive.com/2014/12/15/"
                  @"making-mantle-deserialization-generic/"
                }
              ]
            },
            @{
              @"name" : @"Irene Duke",
              @"role" : @"Senior Android Engineer",
              @"blog_posts" : @[
                @{
                  @"title" : @"A New Beginning",
                  @"url" : @"http://blog.prolificinteractive.com/2014/11/19/"
                  @"new-beginning/"
                }
              ]
            }
          ]
        };

        [PIDemoServer stub:@selector(GET:parameters:completion:)
                 withBlock:^id(NSArray *params) {

                   PIDemoServerCallback completion = params[2];
                   completion(json, nil);

                   return nil;
                 }];

      });

      it(@"Should deserialize into Person objects", ^{

        __block PIDemoPerson *jorge;
        __block PIDemoPerson *irene;

        [PIDemoDataStore
            fetchPeopleWithCompletion:^(NSArray *people, NSError *error) {
              jorge = people[0];
              irene = people[1];
            }];

        [[jorge.name should] equal:@"Jorge Luis Mendez"];
        [[jorge.role should] equal:@"Senior iOS Engineer"];

        PIDemoBlogPost *jorgesBlogPost = jorge.blogPosts[0];
        [[jorgesBlogPost.title should]
            equal:@"Making Mantle Deserialization Generic"];
        [[jorgesBlogPost.url.absoluteString should]
            equal:@"http://blog.prolificinteractive.com/2014/12/15/"
            @"making-mantle-deserialization-generic/"];

        [[irene.name should] equal:@"Irene Duke"];
        [[irene.role should] equal:@"Senior Android Engineer"];

        PIDemoBlogPost *irenesBlogPost = irene.blogPosts[0];
        [[irenesBlogPost.title should] equal:@"A New Beginning"];
        [[irenesBlogPost.url.absoluteString should]
            equal:@"http://blog.prolificinteractive.com/2014/11/19/"
                  @"new-beginning/"];

      });

    });

  });
});

SPEC_END
