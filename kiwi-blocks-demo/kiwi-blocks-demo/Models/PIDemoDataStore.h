//
//  PIDemoDataStore.h
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIDemoDataStore : NSObject

#pragma mark - Requests

+ (void)fetchPeopleWithCompletion:(void (^)(NSArray *people,
                                            NSError *error))completion;
@end
