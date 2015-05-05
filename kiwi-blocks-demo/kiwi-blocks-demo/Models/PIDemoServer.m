//
//  PIDemoServer.m
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "PIDemoServer.h"

@implementation PIDemoServer

+ (void)GET:(NSString *)path
    parameters:(NSDictionary *)parameters
    completion:(void (^)(id JSON, NSError *error))completion {

  // Let's imagine an error is always returned from the server for some reason
  NSError *errorAlwaysReturned =
      [NSError errorWithDomain:@"com.prolificinteractive.demo.error"
                          code:-1
                      userInfo:nil];

  completion(nil, errorAlwaysReturned);
}

@end
