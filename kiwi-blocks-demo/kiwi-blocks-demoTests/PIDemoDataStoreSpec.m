//
//  PIDemoDataStoreSpec.m
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/5/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "Kiwi.h"
#import "PIDemoDataStore.h"

SPEC_BEGIN(PIDemoDataStoreSpec)

describe(@"PIDemoDataStore", ^{

  describe(@"Class method: fetchPeopleWithCompletion:", ^{

    typedef void (^PIDemoDataStoreFetchPeopleCallback)(NSArray *people,
                                                       NSError *error);

    context(@"Data fetched successfully", ^{

      it(@"Should call completion block", ^{

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
