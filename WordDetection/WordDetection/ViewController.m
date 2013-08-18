//
//  ViewController.m
//  WordDetection
//
//  Created by Adam Jacaruso on 8/17/13.
//  Copyright (c) 2013 Adam Jacaruso. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize inputField, responseLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testWord:(id)sender{
    if(inputField.text == NULL){
        [responseLabel setText:@"Enter A Word To Begin"];
    }
    else if([self isRealWord:inputField.text] && [self isAllowedWordType:inputField.text]){
        [responseLabel setText:@"Word is Valid"];
    }else{
        [responseLabel setText:@"Word is Not Valid"];
    }
}


-(bool)isRealWord:(NSString *)currentWord{
    
    bool isValid = false;
    
    UITextChecker* checker = [[UITextChecker alloc] init];
    NSRange range;
    
    range = [checker rangeOfMisspelledWordInString:currentWord range:NSMakeRange(0, [currentWord length]) startingAt:0 wrap:NO language:@"en_US"];
    
    if (range.location == NSNotFound) {
        isValid = true;
    }
    return isValid;
}

-(bool)isAllowedWordType:(NSString *)currentWord{
    
    __block bool isAllowedWordTypeValid = true;
    NSString * currentWordUpperCaseFirstLetter =  [currentWord stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[currentWord substringToIndex:1] uppercaseString]];
    
    NSString *str = [NSString stringWithFormat: @"the %@ is ", currentWordUpperCaseFirstLetter];
    
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:[NSArray arrayWithObject:NSLinguisticTagSchemeNameTypeOrLexicalClass] options:~NSLinguisticTaggerOmitWords];
    
    [tagger setString:str];
    
    [tagger enumerateTagsInRange:NSMakeRange(0, [str length]) scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass options:~NSLinguisticTaggerOmitWords usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
        
        if([tag isEqualToString:@"OtherWord"] || [tag isEqualToString:@"PersonalName"])   {
            isAllowedWordTypeValid = false;
        }
        
    }];
    
    return isAllowedWordTypeValid;
}

@end
