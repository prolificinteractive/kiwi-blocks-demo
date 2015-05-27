//
//  PIDemoPerson.h
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "PIDemoModelProtocol.h"

@interface PIDemoPerson : NSObject <PIDemoModelProtocol>

@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, copy, readonly) NSString *role;
@property(nonatomic, copy, readonly) NSArray *blogPosts;

@end
