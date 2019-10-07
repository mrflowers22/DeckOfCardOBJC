//
//  MRFCardViewController.h
//  DeckOfCardOBJC
//
//  Created by Michael Flowers on 10/7/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRFCardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *suitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;

- (IBAction)drawButtonTapped:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
