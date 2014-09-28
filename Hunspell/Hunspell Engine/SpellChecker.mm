//
//  SpellChecker.h
//  Hunspell
//
//  Created by Aaron Signorelli on 11/05/2012.
//

#import "SpellChecker.h"
#import "HunspellBridge.h"



@implementation SpellChecker



- (id)init
{
	self = [super init];
	currentLanguage = [NSMutableString stringWithCapacity:16];
	[currentLanguage setString: @""];
	return self;
}

- (void) dealloc
{
	releaseDictionary();
}


- (void)updateLanguage:(NSString *)language
{
	NSComparisonResult comparison = [language compare:currentLanguage];
	
	if (comparison != NSOrderedSame) {
		bool result = loadDictionary(language.UTF8String);
		if (result) {
			[currentLanguage setString:language];
			NSLog(@"Language updated to [%@].", language);
		} else {
			NSLog(@"Failed to update language to [%@].", language);
		}
	}
}


-(NSArray *) getSuggestionsForWord:(NSString *) word {
    
    NSMutableArray *result;
	char **suggestionsList;
    
	int suggestionCount = getSuggestions(word.UTF8String, &suggestionsList);
	
	if (suggestionCount) {		
		result = [[NSMutableArray alloc] initWithCapacity:suggestionCount];
		for (int i = 0; i < suggestionCount; i++) {
			NSString *nsSuggestion = [[NSString alloc] initWithCString:*(suggestionsList + i) 
															   encoding:NSUTF8StringEncoding];
			if (nsSuggestion == NULL) {
				NSLog(@"Failed to convert [%s] to NSString", *(suggestionsList + i));
			}else{
                [result addObject:nsSuggestion];
            }
		}
	} else {
		result = [NSMutableArray array];
	}
	
	releaseSuggestions(suggestionCount, &suggestionsList);
	
	return result;
}

-(BOOL) isSpeltCorrectly:(NSString *) word {
    
    BOOL isInDictionary = isSpeltCorrectly(word.UTF8String);
    
    return isInDictionary;    
}



@end

