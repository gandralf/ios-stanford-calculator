//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Alexandre Lages on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <math.h>

#import "CalculatorBrain.h"

@interface CalculatorBrain() {
}
@property(nonatomic, strong) NSMutableArray* operatorStack;
@property(nonatomic, strong) NSString* history;
@end

@implementation CalculatorBrain

@synthesize operatorStack = _operatorStack;
@synthesize history = _history;

- (NSMutableArray *) operatorStack {
    if (!_operatorStack) {
        _operatorStack = [[NSMutableArray alloc] init];
    }
    
    return _operatorStack;
}

- (NSString *)history {
    if (!_history) {
        _history = @"";
    }
    
    return _history;
}

- (void) pushOperand:(double)number {
    [self.operatorStack addObject:[NSNumber numberWithDouble:number]];
    if (self.operatorStack.count == 1) {
        self.history = [NSString stringWithFormat:@"%g", number];
    } else {
        self.history = [self.history stringByAppendingFormat:@" %g", number];
    }
}

- (double) popOperand {
    NSNumber* lastObject = [self.operatorStack lastObject];
    if (self.operatorStack.count > 0) {
        [self.operatorStack removeLastObject];
    }
    return [lastObject doubleValue];
}

- (void) updateHistory:operation withResult:(double)result {
    self.history = [self.history stringByAppendingFormat:@" %@", operation];
    if (self.operatorStack.count == 0) {
        self.history = [self.history stringByAppendingFormat:@" = %g", result];
    }
    
    [self.operatorStack addObject:[NSNumber numberWithDouble:result]];
}

- (double) performOperation:(NSString *)operation {
    double result = 0;
    if (self.operatorStack.count > 1) {
        double b = [self popOperand];
        double a = [self popOperand];
        
        if ([@"+" isEqualToString:operation]) {
            result = a + b;
        } else if ([@"-" isEqualToString:operation]) {
            result = a - b;
        } else if ([@"*" isEqualToString:operation]) {
            result = a * b;
        } else if ([@"/" isEqualToString:operation]) {
            result = a / b;
        }
        
        [self updateHistory:operation withResult:result];
    } else {
        result = [[self.operatorStack lastObject] doubleValue];
    }
    
    return result;
}

- (double) performFunction:(NSString *)function {
    double result;
    if ([@"sin" isEqualToString:function]) {
        result = sin([self popOperand] * M_PI / 180);
    } else if ([@"cos" isEqualToString:function]) {
        result = cos([self popOperand] * M_PI / 180);
    } else if ([@"tan" isEqualToString:function]) {
        result = tan([self popOperand] * M_PI / 180);
    } else if ([@"log" isEqualToString:function]) {
        result = log([self popOperand]);
    }
    
    [self updateHistory:function withResult:result];
    
    return result;
}

- (NSString *)description {
    return self.history;
}

- (void) clear {
    [self.operatorStack removeAllObjects];
    self.history = @"";
}

@end
