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
@property(nonatomic, readonly) NSString *history;
+ (double)evaluateProgram:(NSMutableArray *)workProgram withVariables:(NSDictionary *)varibles;
@end

@implementation CalculatorBrain

@synthesize program = _program;

- (NSMutableArray *) program {
    if (!_program) {
        _program = [[NSMutableArray alloc] init];
    }
    
    return _program;
}

-(NSString *)history {
    return [CalculatorBrain descriptionOfProgram:self.program];
}

- (void) pushOperand:(double)number {
    [self.program addObject:[NSNumber numberWithDouble:number]];
}

- (double) performOperation:(NSString *)operation {
    [self.program addObject:operation];
    return [CalculatorBrain runProgram:self.program usingVariableValues:nil];
}

- (double) performFunction:(NSString *)function {
    return [self performOperation:function];
}


+ (NSString *)descriptionOfProgram:(id)program {
    NSString *result;
    
    if ([program count] > 0) {
        result = [program componentsJoinedByString:@" "];
        
        if ([program count] > 1) {
            NSMutableArray *consumeableProgram = [program mutableCopy];
            double programResult = [self evaluateProgram:consumeableProgram withVariables:nil];
            if (![consumeableProgram count]) {
                result = [result stringByAppendingFormat:@" = %g", programResult];
            }
        }
        
    } else {
        result = @"";
    }

    return result;
}

+ (double)evaluateProgram:(NSMutableArray *)workProgram withVariables:(NSDictionary *)varibles {
    double result = 0;
    id topOfStack = [workProgram lastObject];
    [workProgram removeLastObject];
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    } else if ([@"sin" isEqualToString:topOfStack]) {
        result = sin([self evaluateProgram:workProgram withVariables:varibles] * M_PI / 180);
    } else if ([@"cos" isEqualToString:topOfStack]) {
        result = cos([self evaluateProgram:workProgram withVariables:varibles] * M_PI / 180);
    } else if ([@"tan" isEqualToString:topOfStack]) {
        result = tan([self evaluateProgram:workProgram withVariables:varibles] * M_PI / 180);
    } else if ([@"log" isEqualToString:topOfStack]) {
        result = log([self evaluateProgram:workProgram withVariables:varibles]);
    } else if ([@"sqrt" isEqualToString:topOfStack]) {
        result = sqrt([self evaluateProgram:workProgram withVariables:varibles]);
    } else if (topOfStack) {
        NSString *operation = topOfStack;
        double b = [self evaluateProgram:workProgram withVariables:varibles];
        double a = [self evaluateProgram:workProgram withVariables:varibles];
        
        if ([@"+" isEqualToString:operation]) {
            result = a + b;
        } else if ([@"-" isEqualToString:operation]) {
            result = a - b;
        } else if ([@"*" isEqualToString:operation]) {
            result = a * b;
        } else if ([@"/" isEqualToString:operation]) {
            result = a / b;
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program 
 usingVariableValues:(NSDictionary *)varibles {
    double result = 0;
    
    if ([program isKindOfClass:[NSArray class]]) {
        NSArray *programArray = program;
        NSMutableArray *workProgram = [programArray mutableCopy];
        
        result = [self evaluateProgram: workProgram withVariables:varibles];
    }
    
    return result;
}

+ (NSSet *)variablesUsedInProram:(id)program {
    return nil;
}

- (NSString *)description {
    return self.history;
}

- (void) clear {
    [self.program removeAllObjects];
}

@end
