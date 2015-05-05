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
        });
        
        it(@"Should deserialize into Person objects V1", ^{
            
            __block PIDemoPerson *leela;
            __block PIDemoPerson *professor;
            
            [PIDemoServer
             stub:@selector(GET:parameters:completion:)
             withBlock:^id(NSArray *params) {
                 
                 PIDemoServerCallback completion = params[2];
                 completion(json, nil);
                 
                 return nil;
             }];
            
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
        
        it(@"Should deserialize into Person objects V2", ^{
            
            KWCaptureSpy *serverCompletionBlockSpy = [PIDemoServer captureArgument:@selector(GET:parameters:completion:) atIndex:2];
            
            [[PIDemoServer should] receive:@selector(GET:parameters:completion:) withArguments:@"people", @{ @"apiKey" : @"abc" }, any()];
            
            __block PIDemoPerson *leela;
            __block PIDemoPerson *professor;
            
            [PIDemoDataStore
             fetchPeopleWithCompletion:^(NSArray *people, NSError *error) {
                 leela = people[0];
                 professor = people[1];
             }];
            
            PIDemoServerCallback serverCompletionBlock =
            serverCompletionBlockSpy.argument;
            serverCompletionBlock(json, nil);
            
            [[leela.name should] equal:@"Leela"];
            
            [[professor.name should] equal:@"Professor Farnsworth"];
            
        });

    });

  });
});

SPEC_END
