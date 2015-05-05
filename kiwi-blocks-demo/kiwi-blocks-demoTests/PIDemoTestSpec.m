//
//  PIDemoTestSpec.m
//  kiwi-blocks-demo
//
//  Created by Harlan Kellaway on 5/4/15.
//  Copyright (c) 2015 Prolific Interactive. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(PIDemoTestSpec)

__block NSInteger six;
__block NSInteger two;

beforeAll(^{

  six = 6;
  two = 2;

});

describe(@"Arithmetic", ^{

  describe(@"Addition", ^{

    it(@"Should add correctly", ^{

      NSInteger eight = 8;

      [[theValue(six + two) should] equal:theValue(eight)];

    });

  });

  describe(@"Subtraction", ^{

    it(@"Should subtract correctly", ^{

      NSInteger four = 4;

      [[theValue(six - two) should] equal:theValue(four)];

    });

  });

  describe(@"Multiplication", ^{

    it(@"Should multiply correctly", ^{

      NSInteger twelve = 12;

      [[theValue(six * two) should] equal:theValue(twelve)];

    });
  });

  describe(@"Division", ^{

    it(@"Should divide correctly", ^{

      NSInteger three = 3;

      [[theValue(six / two) should] equal:theValue(three)];

    });

  });

});

SPEC_END