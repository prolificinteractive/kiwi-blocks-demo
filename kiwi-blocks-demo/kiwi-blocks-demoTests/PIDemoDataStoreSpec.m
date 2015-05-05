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

    typedef void (^PIDemoDataStoreFetchPeopleCallback)(NSArray *people,
                                                       NSError *error);
    typedef void (^PIDemoServerCallback)(id JSON, NSError *error);

    context(@"Data fetched successfully", ^{

        __block NSDictionary *json;
        
        beforeEach(^{
            
            json = @{
                     @"people" : @[
                             @{
                                 @"name" : @"Leela",
                                 @"role" : @"Space Captain",
                                 @"blog_posts" : @[
                                         @{
                                             @"title" : @"First day on the Planet Express",
                                             @"url" : @"http://some.website/blog/first-day"
                                             }
                                         ]
                                 },
                             @{
                                 @"name" : @"Professor Farnsworth",
                                 @"role" : @"Scientist",
                                 @"blog_posts" : @[
                                         @{
                                             @"title" : @"Good news, everybody!",
                                             @"url" : @"http://some.website/blog/good-news"
                                             }
                                         ]
                                 }
                             ]
                     };
            
            [PIDemoServer
               stub:@selector(GET:parameters:completion:)
               withBlock:^id(NSArray *params) {
                   
                   PIDemoServerCallback completion = params[2];
                   completion(json, nil);
                   
                   return nil;
               }];
            
        });
        
        it(@"Should deserialize into Person objects", ^{
            
            __block PIDemoPerson *leela;
            __block PIDemoPerson *professor;
            
            [PIDemoDataStore fetchPeopleWithCompletion:^(NSArray *people, NSError *error) {
                                            leela = people[0];
                                            professor = people[1];
                                         }];
            
            [[leela.name should] equal:@"Leela"];
            [[leela.role should] equal:@"Space Captain"];
            
            PIDemoBlogPost *leelasBlogPost = leela.blogPosts[0];
            [[leelasBlogPost.title should] equal:@"First day on the Planet Express"];
            [[leelasBlogPost.url.absoluteString should]
             equal:@"http://some.website/blog/first-day"];
            
            [[professor.name should] equal:@"Professor Farnsworth"];
            [[professor.role should] equal:@"Scientist"];
            
            PIDemoBlogPost *professorsBlogPost = professor.blogPosts[0];
            [[professorsBlogPost.title should] equal:@"Good news, everybody!"];
            [[professorsBlogPost.url.absoluteString should]
             equal:@"http://some.website/blog/good-news"];
            
        });
        
        it(@"Should call completion block with data", ^{

        __block id peopleFetched;
        NSArray *testPeople = @[ @"person 1", @"person 2" ];
        KWCaptureSpy *successBlockSpy = [PIDemoDataStore
            captureArgument:@selector(fetchPeopleWithCompletion:)
                    atIndex:0];

        [PIDemoDataStore
            fetchPeopleWithCompletion:^(NSArray *people, NSError *error) {
              peopleFetched = people;
            }];

        PIDemoDataStoreFetchPeopleCallback successBlock =
            successBlockSpy.argument;
        successBlock(testPeople, nil);

        [[expectFutureValue(peopleFetched) shouldEventually] equal:testPeople];

      });

    });

  });
});

SPEC_END
