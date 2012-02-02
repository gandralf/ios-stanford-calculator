//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Alexandre Lages on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "CalculatorIO.h"

@interface CalculatorViewController()
@property(strong, nonatomic) CalculatorIO* calculatorIO;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize history = _history;
@synthesize calculatorIO = _calculatorIO;

- (CalculatorIO *)calculatorIO {
    if (!_calculatorIO) {
        _calculatorIO = [[CalculatorIO alloc] init];
    }
    
    return _calculatorIO;
}

- (IBAction)digitPressed:(UIButton *)sender {
    [self.calculatorIO digitPressed:sender.currentTitle];
    self.display.text = self.calculatorIO.display;
}

- (IBAction)enterPressed {
    [self.calculatorIO enterPressed];
    self.history.text = self.calculatorIO.history;
}

- (IBAction)operationPressed:(UIButton *)sender {
    [self.calculatorIO operationPressed:sender.currentTitle];
    self.display.text = self.calculatorIO.display;
    self.history.text = self.calculatorIO.history;
}
@end
