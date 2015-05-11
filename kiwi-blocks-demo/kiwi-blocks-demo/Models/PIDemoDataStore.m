//
//  PIDemoDataStore.m
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "PIDemoDataStore.h"
#import "PIDemoPerson.h"
#import "PIDemoServer.h"

static NSString *const kPIDemoRequestPathPeople = @"people";

@implementation PIDemoDataStore

#pragma mark - Requests

+ (void)fetchPeopleWithCompletion:(void (^)(NSArray *, NSError *))completion {

  [PIDemoServer GET:kPIDemoRequestPathPeople
         parameters:@{
           @"apiKey" : @"abc"
         }
         completion:^(id JSON, NSError *error) {

           NSMutableArray *people = [NSMutableArray array];
           for (NSDictionary *personJSON in JSON[@"people"]) {
             PIDemoPerson *person =
                 [PIDemoPerson modelFromJSONDictionary:personJSON];
             [people addObject:person];
           }

           completion(people, nil);

         }];
}

@end
