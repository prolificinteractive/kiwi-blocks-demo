//
//  PIDemoPerson.h
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "PIDemoModelProtocol.h"

@interface PIDemoPerson : NSObject <PIDemoModelProtocol>

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *role;
@property(nonatomic, copy) NSArray *blogPosts;

+ (instancetype)modelFromJSONDictionary:(NSDictionary *)JSONDictionary;

@end
