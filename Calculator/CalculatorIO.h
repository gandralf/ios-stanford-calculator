//
//  CalculatorIO.h
//  Calculator
//
//  Created by Alexandre Lages on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorIO : NSObject
@property(strong,nonatomic) NSString *display;
@property(strong,nonatomic) NSString *history;
- (void)digitPressed:(NSString *)digit;
- (void)enterPressed;
- (void)clearPressed;
- (void)backspacePressed;
- (void)dotPressed;
- (void)plusMinusPressed;
- (void)piPressed;
- (void)eulerPressed;
- (void)operationPressed:(NSString *)operation;
@end
