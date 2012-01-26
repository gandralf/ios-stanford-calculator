//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Alexandre Lages on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController() {
}
@property BOOL typingANumber;
@end

@implementation CalculatorViewController
@synthesize display;
@synthesize typingANumber = _typingANumber;


- (IBAction)digitPressed:(UIButton *)sender {
    if (self.typingANumber) {
        self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
    } else if (![@"0" isEqualToString:sender.currentTitle]) {
        self.typingANumber = YES;
        self.display.text = sender.currentTitle;
    }
}


@end
