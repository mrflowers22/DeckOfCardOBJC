//
//  MRFCard.m
//  DeckOfCardOBJC
//
//  Created by Michael Flowers on 10/7/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import "MRFCard.h"

@implementation MRFCard

- (instancetype)initWithCardSuit:(NSString *)suit image:(NSString *)image
{
    self = [super init];
    if (self)
    {
        _suit = suit;
        _image = image;
    }
    return self;
}
@end


@implementation MRFCard(JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    //initialize card with a dictionary - @ is what we are pulling from the json/api
    NSString * suit = dictionary[@"suit"];
    NSString *image = dictionary[@"image"];
    
    return [self initWithCardSuit:suit image:image];
}
@end

