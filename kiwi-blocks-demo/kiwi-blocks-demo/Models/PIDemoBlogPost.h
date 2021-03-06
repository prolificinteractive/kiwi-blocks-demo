//
//  PIDemoBlogPost.h
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "PIDemoModelProtocol.h"

@interface PIDemoBlogPost : NSObject <PIDemoModelProtocol>

@property(nonatomic, copy, readonly) NSString *title;
@property(nonatomic, strong, readonly) NSURL *url;

@end
