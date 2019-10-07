//
//  MRFCardController.m
//  DeckOfCardOBJC
//
//  Created by Michael Flowers on 10/7/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import "MRFCardController.h"

@implementation MRFCardController
+ (MRFCardController *)sharedController
{
    //get the memory once, and never create the singleton again
    static MRFCardController * sharedController = nil;
    static dispatch_once_t onceToken;
    //this will create a token, 1, to keep track of how many sharedController's been ran.
    dispatch_once(&onceToken, ^{
        sharedController = [MRFCardController  new];
    });
    return sharedController;
}

static NSString * const baseURLString = @"https://deckofcardsapi.com/api/deck/new";
- (void)drawNewCard:(NSInteger)numberOfCards completion:(void (^)(NSArray<MRFCard *> *))completion
{
    NSURL * url = [NSURL URLWithString:baseURLString];
    NSString * cardCount = [@(numberOfCards) stringValue];
    NSURL * drawURL = [url URLByAppendingPathComponent:@"draw/"];
    
    //now because we are going to add a query we initialize urlComponents
    NSURLComponents * urlComponents = [NSURLComponents componentsWithURL:drawURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem * queryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    urlComponents.queryItems = @[queryItem];
    
    NSURL * finalURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in %s: %@: %@",  __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary * topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            if (!topLevelDictionary)
            {
                //if we dont get the top level dictionary back we have an error
                NSLog(@"Error parsing the json %@",error);
                completion(nil);
                return;
                
            }
            //check our  dictionary for this key and assign it to our cardsArray property
            NSArray * cardsArray =  topLevelDictionary[@"cards"];
            NSMutableArray * cardPlaceHolder = [NSMutableArray new];
            
            //iterate through the dictionary of cards
            for (NSDictionary * dictionary in cardsArray)
            {
                MRFCard * card = [[MRFCard alloc] initWithDictionary:dictionary];
                [cardPlaceHolder addObject: card];
            }
            completion(cardPlaceHolder);
        }
        
    }]resume];
    
}

- (void)fetchImageFromCard:(MRFCard *)card completion:(void (^)(UIImage *))completion
{
    NSURL * imageURL = [NSURL URLWithString:card.image];
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in the image function: %s: %@: %@",  __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@" this is the response in the image function. %@", response);
        }
        
        if (data)
        {
            //crate a uiimage
            UIImage * image = [UIImage imageWithData:data];
            completion(image);
        }

    }] resume];
}

@end
