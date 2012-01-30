//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Alexandre Lages on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorTests.h"
#import "CalculatorViewController.h"

@interface MockLabel: NSObject
@property(nonatomic, strong) NSString* text;
+ (MockLabel *) newLabel:(NSString *) text;
@end

@implementation MockLabel
@synthesize text = _text;

+ (MockLabel *) newLabel:(NSString *) text {
    MockLabel* result = [[MockLabel alloc] init];
    result.text = text;
    return result;
}
@end

@interface MockButton: NSObject
@property(nonatomic, strong) NSString* currentTitle;
+ (MockButton *) newButton:(NSString *) text;
@end

@implementation MockButton
@synthesize currentTitle = _currentTitle;
+ (MockButton *) newButton:(NSString *)text {
    MockButton *button = [[MockButton alloc] init];
    button.currentTitle = text;
    
    return button;
}
@end

@interface CalculatorTests()
@property(strong, nonatomic) MockLabel *display;
@property(strong, nonatomic) MockLabel *history;
@property(strong, nonatomic) CalculatorViewController *controller;
@end

@implementation CalculatorTests
@synthesize display = _display;
@synthesize history = _history;
@synthesize controller = _controller;

- (CalculatorViewController *)controller {
    if (!_controller) {
        _controller = [[CalculatorViewController alloc] init];
        self.display = [MockLabel newLabel:@"0"];
        self.history = [MockLabel newLabel:@""];
        _controller.display = (id) self.display;
        _controller.history = (id) self.history;
    }
    
    return _controller;
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
    [self.controller digitPressed:(id)[MockButton newButton:buttonText]];
    STAssertEqualObjects(displayText, self.controller.display.text, nil);
}

- (void)pressEnter {
    [self.controller enterPressed];
}

- (void)pressOperation:(NSString *)operation Wait:(NSString *) displayText {
    [self.controller operationPressed:(id) [MockButton newButton:operation]];
    STAssertEqualObjects(self.controller.display.text, displayText, nil);
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
    [self pressEnter];
    [self pressDigit:@"6" Wait:@"6"];
    [self pressOperation:@"+" Wait:@"10"];
    STAssertEqualObjects(@"4 6 + =", self.controller.history.text, nil);
}

@end
