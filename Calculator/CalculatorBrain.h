//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Alexandre Lages on 1/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void) pushOperand:(double)number;
- (double) performOperation:(NSString*)operation;
- (void) clear;
- (double) performFunction:(NSString *)operation;
@end
