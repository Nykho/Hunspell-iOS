//
//  SpellingViewController.m
//  Hunspell for iOS
//
//  Created by Aaron Signorelli on 18/04/2012.
//  Copyright (c) 2012 Aaron Signorelli. All rights reserved.
//

#import "SpellingViewController.h"
#import "SpellingSuggestionDelegate.h"


@interface SpellingViewController ()

@end

@implementation SpellingViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     
    _spellingDelegate = [[SpellingSuggestionDelegate alloc] init];
    [_spellingDelegate.spellChecker updateLanguage:@"en_US"];
    _inputBox.delegate = _spellingDelegate;
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark buttons

-(IBAction)switchToEnglish:(id)sender {
    [_spellingDelegate.spellChecker updateLanguage:@"en_US"];
}

-(IBAction)switchToEnglish_US:(id)sender {
    [_spellingDelegate.spellChecker updateLanguage:@"en_US"];
}

-(IBAction)switchToIrish:(id)sender {
    [_spellingDelegate.spellChecker updateLanguage:@"en_US"];
}

-(IBAction)dropKeyboard:(id)sender {
    [_inputBox resignFirstResponder]; 
}

@end
