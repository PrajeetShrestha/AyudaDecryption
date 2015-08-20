//
//  ViewController.m
//  DecryptionEngineAyuda
//
//  Created by Prajeet Shrestha on 8/19/15.
//  Copyright (c) 2015 Prajeet Shrestha. All rights reserved.
//

#import "ViewController.h"
//http://www.ayudasystems.com/Jobs?id=46924#devchallenge
@interface ViewController ()
@property (nonatomic) NSDictionary *keys;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keys = [NSDictionary new];
    self.keys = [self combineKeyAndValues];
    [self breakInputStringIntoArrayOfTwoCharacterString:nil];
}
// 20 , 27 , C7 , C1
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSDictionary *)combineKeyAndValues {
    NSArray *keys = [self breakKeys];
    NSArray *values = [self breakValues];
    NSMutableDictionary *keyValues = [NSMutableDictionary new];
    for (NSString *key in keys) {
        NSInteger index = [keys indexOfObject:key];
        [keyValues setObject:values[index] forKey:key];
    }
    [keyValues setObject:@" " forKey:@"0A"];
    [keyValues setObject:@"\n" forKey:@"2720"];

    NSLog(@"Key Values %@",keyValues);
    return keyValues;
}

- (NSArray *)breakKeys {
    NSString *string = @"6B68696E6F6C6D62636061666764657A7B78797E7F7C7D7273704B48494E4F4C4D42434041464744455A5B58595E5F5C5D525350544A0B1B6A1809190E1E0F1F741C0C1D00120213031A75070117517157775610110D160614041505C7C1";
    NSInteger lengthOfString = string.length;
    NSMutableArray *splittedKeys = [NSMutableArray new];
    for (int i = 0; i < lengthOfString; i += 2) {
        NSString *subString = [string substringWithRange:NSMakeRange(i,2)];
        [splittedKeys addObject:subString];
    }
    return splittedKeys;
}

- (NSArray*)breakValues {
    NSString *string = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~`!1@2#3$4%5^6&7*8(9)0_-+={[}]|:;'<,>.?/íë";
    NSInteger lengthOfString = string.length;
    NSMutableArray *splittedValues = [NSMutableArray new];
    for (int i = 0; i < lengthOfString; i ++) {
        NSString *subString = [string substringWithRange:NSMakeRange(i,1)];
        [splittedValues addObject:subString];
    }
    return splittedValues;
}

- (void)breakInputStringIntoArrayOfTwoCharacterString:(NSString *)inputString {

    NSString *string;
    if (inputString == nil) {
        string = @"6B0A6F46484F584F5E420A6D43465E42454443C1462720594346435C584F440A5A4F44444B0A47C75843C1462720450A474F444F460A4B4D464B580A4F464F444B5E420B2720644B0749424B4F584F4E0A5A4B464B44074EC75843C1462720450A4D4B464B4E42584F474743440A4F444445584B5E420627206C4B445F43464559060A464F0A464344444B5E4245442720444F4C0A4B4F4B58060A59C70A444F4C0A4B4F4B5845440B";
    } else {
        string = inputString;
    }


    NSInteger lengthOfString = string.length;
    NSMutableArray *splittedCharacters = [NSMutableArray new];
    for (int i = 0; i < lengthOfString; i += 2) {
        NSString *subString = [string substringWithRange:NSMakeRange(i,2)];
        if ([subString isEqualToString:@"27"]) {
            subString = [string substringWithRange:NSMakeRange(i,4)];
            i = i + 2;
        }
        [splittedCharacters addObject:subString];
    }
    NSLog(@"Printing Decrypted Message");
    NSMutableString *mutatedString = [NSMutableString new];
    for (NSString *key in splittedCharacters) {
        if (self.keys[key] != nil || self.keys[key] != NULL ) {
            [mutatedString appendString:self.keys[key]];
        } else {
            NSLog(@"Null for key: %@",key);
        }
        //NSLog(@"%@",self.keys[key]);
    }
    NSLog(@"Mutated String: \n%@",mutatedString);
}

@end
