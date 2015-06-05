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

    context(@"Server request successful", ^{

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

        [[jorge.name shouldEventually] equal:@"Jorge Luis Mendez"];
        [[jorge.role shouldEventually] equal:@"Senior iOS Engineer"];

        PIDemoBlogPost *jorgesBlogPost = jorge.blogPosts[0];
        [[jorgesBlogPost.title shouldEventually]
            equal:@"Making Mantle Deserialization Generic"];
        [[jorgesBlogPost.url.absoluteString shouldEventually]
            equal:@"http://blog.prolificinteractive.com/2014/12/15/"
            @"making-mantle-deserialization-generic/"];

        [[irene.name shouldEventually] equal:@"Irene Duke"];
        [[irene.role shouldEventually] equal:@"Senior Android Engineer"];

        PIDemoBlogPost *irenesBlogPost = irene.blogPosts[0];
        [[irenesBlogPost.title shouldEventually] equal:@"A New Beginning"];
        [[irenesBlogPost.url.absoluteString shouldEventually]
            equal:@"http://blog.prolificinteractive.com/2014/11/19/"
            @"new-beginning/"];

      });

    });

    context(@"Server request not successful", ^{

      __block NSError *serverError;

      beforeEach(^{

        serverError = [NSError errorWithDomain:@"test" code:100 userInfo:@{ @"user" : @"info" }];

        [PIDemoServer stub:@selector(GET:parameters:completion:)
                 withBlock:^id(NSArray *params) {

                   PIDemoServerCallback completion = params[2];
                   completion(nil, serverError);

                   return nil;
                 }];

      });

      it(@"Should callback with error", ^{

        __block NSError *errorReceived;

        [PIDemoDataStore
            fetchPeopleWithCompletion:^(NSArray *people, NSError *error) {
              errorReceived = error;
            }];

        [[errorReceived shouldEventually] equal:serverError];

      });

    });

  });

});

SPEC_END
