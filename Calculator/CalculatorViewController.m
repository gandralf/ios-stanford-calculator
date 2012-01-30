//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Alexandre Lages on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController() {
}
@property BOOL typingANumber;
@property(strong, nonatomic) CalculatorBrain* brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize history = _history;
@synthesize typingANumber = _typingANumber;
@synthesize brain = _brain;

- (CalculatorBrain *) brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    if (self.typingANumber) {
        if (![@"0" isEqualToString:self.display.text]) {
            self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
        } else {
            self.display.text = sender.currentTitle;
        }
    } else {
        self.typingANumber = YES;
        self.display.text = sender.currentTitle;
    }
}

- (IBAction)enterPressed {
    self.typingANumber = NO;
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.history.text = self.brain.description;
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.typingANumber) {
        [self enterPressed];
    }
    
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.history.text = self.brain.description;
}

- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
@end
