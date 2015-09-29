//
//  SpellChecker.h
//  Hunspell
//
//  Created by Aaron Signorelli on 11/05/2012.
//

#import "SpellChecker.h"

#import "stdio.h"
#import "string.h"
#import "hunspell.h"

static Hunhandle *handle = NULL;


void releaseDictionary()
{
    if (handle != NULL) {
        delete (Hunspell*)(handle);
    }
}


bool loadDictionary(const char *language)
{
    NSString *dictPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%s", language] ofType:@"dic"];
    NSString *affPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%s", language] ofType:@"aff"];
    
    if(dictPath == nil || affPath == nil){
        NSLog(@"Can't find the dictionary for the language code %s.\n", language);
        return(false);
    }
    
    releaseDictionary();
    handle = (Hunhandle*)(new Hunspell(affPath.UTF8String, dictPath.UTF8String));
    
    return(handle != NULL);
}



bool isSpeltCorrectly(const char *word)
{
    int result = ((Hunspell*)handle)->spell(word);
    return(result != 0);
}

int getSuggestions(const char *word, char ***suggest_list_ptr)
{
    return ((Hunspell*)handle)->suggest(suggest_list_ptr, word);
}

void releaseSuggestions(int n, char ***list)
{
    if (list && *list && n > 0) {
        for (int i = 0; i < n; i++) {
            if ((*list)[i]){
                free((*list)[i]);
            }
        }
        
        free(*list);
        *list = NULL;
    }
}



@implementation SpellChecker {
    NSString *currentLanguage;
}

+ (SpellChecker*)sharedInstance
{
    static SpellChecker* sharedInstance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedInstance = [[SpellChecker alloc] init];
        [sharedInstance updateLanguage:@"en_US"];
    });
    
    return sharedInstance;
}


- (id)init
{
    self = [super init];
    if (self) {
        currentLanguage = @"";
    }
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
            currentLanguage = language;
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

