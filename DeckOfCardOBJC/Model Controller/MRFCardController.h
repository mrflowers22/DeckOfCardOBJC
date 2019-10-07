//
//  MRFCardController.h
//  DeckOfCardOBJC
//
//  Created by Michael Flowers on 10/7/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRFCard.h"
#import <UIKit/UIKit.h>
@interface MRFCardController : NSObject

+ (MRFCardController *)sharedController;

- (void)drawNewCard:(NSInteger)numberOfCards completion:(void (^) (NSArray<MRFCard *> *))completion;

//need a fetch  for our image
- (void)fetchImageFromCard:(MRFCard *)card completion:(void (^) (UIImage *))completion;

@end


