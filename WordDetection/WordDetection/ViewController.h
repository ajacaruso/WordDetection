//
//  ViewController.h
//  WordDetection
//
//  Created by Adam Jacaruso on 8/17/13.
//  Copyright (c) 2013 Adam Jacaruso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong) IBOutlet UITextField *inputField;
@property (strong) IBOutlet UILabel *responseLabel;

- (IBAction)testWord:(id)sender;

@end
