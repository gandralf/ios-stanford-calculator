//
//  CalculatorIO.m
//  Calculator
//
//  Created by Alexandre Lages on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorIO.h"
#import "CalculatorBrain.h"

@interface CalculatorIO()
@property BOOL typingANumber;
@property(strong, nonatomic) CalculatorBrain* brain;
@end

@implementation CalculatorIO
@synthesize typingANumber = _typingANumber;
@synthesize brain = _brain;
@synthesize display = _display;
@synthesize history = _history;

- (NSString *)display {
    if (!_display) {
        _display = @"0";
    }
    
    return _display;
}

- (NSString *)history {
    if (!_history) {
        _history = @"";
    }
    
    return _history;
}

- (CalculatorBrain *) brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    
    return _brain;
}

- (void)digitPressed:(NSString *)digit {
    if (self.typingANumber) {
        if (![@"0" isEqualToString:self.display]) {
            self.display = [self.display stringByAppendingString:digit];
        } else {
            self.display = digit;
        }
    } else {
        self.typingANumber = YES;
        self.display = digit;
    }
    
}

- (void)dotPressed {
    if (!self.typingANumber) {
        self.display = @"0.";
        self.typingANumber = YES;
    } else {
        NSRange range = [self.display rangeOfString:@"." options:NSCaseInsensitiveSearch];
        if (range.location == NSNotFound) {
            self.display = [self.display stringByAppendingString:@"."];
        }
    }
}

- (void)enterPressed {
    self.typingANumber = NO;
    [self.brain pushOperand:[self.display doubleValue]];
    self.history = self.brain.description;
}

- (void)operationPressed:(NSString *)operation {
    if (self.typingANumber) {
        [self enterPressed];
    }
    
    double result = [self.brain performOperation:operation];
    self.display = [NSString stringWithFormat:@"%g", result];
    self.history = self.brain.description;
}

- (void)clearPressed {
    [self.brain clear];
    self.display = @"0";
    self.history = self.brain.description;
}

- (void)backspacePressed {
    if (self.typingANumber) {
        if (self.display.length > 1) {
            self.display = [self.display substringToIndex:self.display.length -1];
        } else if (self.display.length == 1) {
            self.display = @"0";
        }
    }
}

- (void)plusMinusPressed {
    double result = [self.display doubleValue] * -1;
    self.display = [NSString stringWithFormat:@"%g", result];
    self.typingANumber = YES;
}

- (void)piPressed {
    
}
- (void)eulerPressed {
    
}

@end
