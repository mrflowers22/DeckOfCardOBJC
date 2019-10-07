//
//  MRFCard.h
//  DeckOfCardOBJC
//
//  Created by Michael Flowers on 10/7/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRFCard : NSObject
//copy = ????
//readonly = is making it a constant, you can only read it you cannot write it
@property (nonatomic, copy, readonly) NSString * suit;
@property (nonatomic, copy, readonly) NSString * image;
- (instancetype)initWithCardSuit: (NSString *)suit image:(NSString *)image;
@end

NS_ASSUME_NONNULL_END

//adopting to codable
@interface MRFCard (JSONConvertable)
//id = any
- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end
