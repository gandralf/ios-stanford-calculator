//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Alexandre Lages on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorTests.h"
#import "CalculatorIO.h"

@interface CalculatorTests()
@property(strong, nonatomic) CalculatorIO *calculatorIO;
@end

@implementation CalculatorTests
@synthesize calculatorIO = _calculatorIO;

- (CalculatorIO *)calculatorIO {
    if (!_calculatorIO) {
        _calculatorIO = [[CalculatorIO alloc] init];
    }
    
    return _calculatorIO;
}

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)pressDigit:(NSString *)buttonText Wait:(NSString *)displayText {
    [self.calculatorIO digitPressed:buttonText];
    STAssertEqualObjects(self.calculatorIO.display, displayText, nil);
}

- (void)pressEnter {
    [self.calculatorIO enterPressed];
}

- (void)pressClear {
    [self.calculatorIO clearPressed];
}

- (void)pressPi {
    [self.calculatorIO piPressed];
    STAssertEqualObjects(@"3.14159", self.calculatorIO.display, nil);
}

- (void)pressEuler {
    [self.calculatorIO eulerPressed];
    STAssertEqualObjects(@"2.71828", self.calculatorIO.display, nil);
}

- (void)pressBackspace:(NSString *)displayText {
    [self.calculatorIO backspacePressed];
    STAssertEqualObjects(self.calculatorIO.display, displayText, nil);
}

- (void)pressDot:(NSString *)displayText {
    [self.calculatorIO dotPressed];
    STAssertEqualObjects(displayText, self.calculatorIO.display, nil);
}

- (void)pressPlusMinus:(NSString *)displayText {
    [self.calculatorIO plusMinusPressed];
    STAssertEqualObjects(self.calculatorIO.display, displayText, nil);
}

- (void)pressOperation:(NSString *)operation Wait:(NSString *) displayText {
    [self.calculatorIO operationPressed:operation];
    STAssertEqualObjects(self.calculatorIO.display, displayText, nil);
}

- (void)pressFunction:(NSString *)function Wait:(NSString *) displayText {
    [self.calculatorIO functionPressed:function];
    STAssertEqualObjects(self.calculatorIO.display, displayText, nil);
}

- (void)testIgnoreFirstZero {
    [self pressDigit:@"0" Wait:@"0"];
    [self pressDigit:@"0" Wait:@"0"];
    [self pressDigit:@"1" Wait:@"1"];
    [self pressDigit:@"0" Wait:@"10"];
}

- (void)testSimpleSum {
    [self pressDigit:@"6" Wait:@"6"];
    [self pressEnter];
    [self pressDigit:@"4" Wait:@"4"];
    [self pressOperation:@"+" Wait:@"10"];
}

- (void)testLongOperation {
    [self pressDigit:@"6" Wait:@"6"];
    [self pressEnter];
    [self pressDigit:@"8" Wait:@"8"];
    [self pressEnter];
    [self pressDigit:@"2" Wait:@"2"];
    [self pressOperation:@"/" Wait:@"4"];
    [self pressOperation:@"+" Wait:@"10"];
}

- (void)testHistory {
    [self pressDigit:@"4" Wait:@"4"];
    STAssertEqualObjects(self.calculatorIO.history, @"", nil);
    [self pressEnter];
    STAssertEqualObjects(self.calculatorIO.history, @"4", nil);
    [self pressDigit:@"6" Wait:@"6"];
    STAssertEqualObjects(self.calculatorIO.history, @"4", nil);
    [self pressOperation:@"+" Wait:@"10"];
    STAssertEqualObjects(self.calculatorIO.history, @"4 6 + = 10", nil);
}

- (void)testClear {
    [self pressDigit:@"4" Wait:@"4"];
    [self pressEnter];
    [self pressClear];
    STAssertEqualObjects(self.calculatorIO.display, @"0", nil);
    STAssertEqualObjects(self.calculatorIO.history, @"", nil);
}

- (void)testDot {
    [self pressDot:@"0."];
    [self pressDigit:@"8" Wait:@"0.8"];
    [self pressEnter];
    
    [self pressDigit:@"4" Wait:@"4"];
    [self pressDot:@"4."];
    [self pressDigit:@"2" Wait:@"4.2"];
}

- (void)testFormat {
    [self pressDigit:@"1" Wait:@"1"];
    [self pressEnter];
    [self pressDigit:@"2" Wait:@"2"];
    [self pressOperation:@"/" Wait:@"0.5"];
    [self pressDigit:@"3" Wait:@"3"];
    [self pressOperation:@"/" Wait:@"0.166667"];
}

- (void)testBackspacePressed {
    [self pressBackspace:@"0"];
    [self pressDigit:@"1" Wait:@"1"];
    [self pressDigit:@"2" Wait:@"12"];
    [self pressBackspace:@"1"];
    [self pressBackspace:@"0"];
}

- (void)testPlusMinusPressed {
    [self pressDigit:@"3" Wait:@"3"];
    [self pressPlusMinus:@"-3"];
    [self pressPlusMinus:@"3"];
    [self pressPlusMinus:@"-3"];
    [self pressEnter];
    [self pressPlusMinus:@"3"];
}

- (void)testPiAndEulerPressed {
    [self pressPi];
    [self pressEuler];
}

- (void)testFunctionsPressed {
    [self pressDigit:@"9" Wait:@"9"];
    [self pressDigit:@"0" Wait:@"90"];
    [self pressFunction:@"sin" Wait:@"1"];
    STAssertEqualObjects(@"90 sin = 1", self.calculatorIO.history, nil);
}

@end
