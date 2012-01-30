//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Alexandre Lages on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *history;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)enterPressed;
- (IBAction)operationPressed:(UIButton *)sender;
@end
