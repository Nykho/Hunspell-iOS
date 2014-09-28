//
//  SpellingViewController.h
//  Hunspell
//
//  Created by Aaron Signorelli on 18/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpellingSuggestionDelegate.h"

@interface SpellingViewController : UIViewController {
    SpellingSuggestionDelegate *_spellingDelegate;
}

@property (strong, nonatomic) IBOutlet UITextField *inputBox;
@property (nonatomic, strong) IBOutlet UIButton *ieButton, *gbButton, *usButton, *endButton;

@end
