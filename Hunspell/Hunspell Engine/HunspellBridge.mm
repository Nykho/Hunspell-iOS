//
//  HunspellBridge.m
//  Hunspell
//
//  Created by Aaron Signorelli on 11/05/2012.
//

#import "HunspellBridge.h"
#import "stdio.h"
#import "string.h"

#import "hunspell.h"

@implementation HunspellBridge



static Hunhandle *handle = NULL;

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

void releaseDictionary()
{
	if (handle != NULL) {
        delete (Hunspell*)(handle);
	}	
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

@end

