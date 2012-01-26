//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Alexandre Lages on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain() {
}
@property(nonatomic, strong) NSMutableArray* operatorStack;
@end

@implementation CalculatorBrain

@synthesize operatorStack = _operatorStack;

- (NSMutableArray *) operatorStack {
    if (!_operatorStack) {
        _operatorStack = [[NSMutableArray alloc] init];
    }
    
    return _operatorStack;
}

- (void) pushOperand:(double)number {
    [self.operatorStack addObject:[NSNumber numberWithDouble:number]];
}

- (double) popOperand {
    NSNumber* lastObject = [self.operatorStack lastObject];
    if (self.operatorStack.count > 0) {
        [self.operatorStack removeLastObject];
    }
    return [lastObject doubleValue];
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
    } else {
        result = [[self.operatorStack lastObject] doubleValue];
    }
    
    return result;
}

@end
