//
//  DipticCell.m
//  Kiwi
//
//  Created by croberts on 9/24/14.
//  Copyright (c) 2014 Roberts. All rights reserved.
//

#import "DipticCell.h"

@implementation DipticCell


-(void)awakeFromNib{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
 self.scrollView.bouncesZoom = YES;
 self.scrollView.bounces = YES;
 self.scrollView.showsHorizontalScrollIndicator = NO;
 self.scrollView.showsVerticalScrollIndicator = NO;
 self.cancelComment.layer.cornerRadius = 3;
 self.postComment.layer.cornerRadius = 3;
 self.profileBtn.layer.cornerRadius = self.profileBtn.frame.size.width/2;
 
 self.profileBtn.clipsToBounds = YES;
 [Utilities prepareBtn:self.profileBtn];
 [self.offerBtn setBackgroundColor:CREAM_COLOR];
 self.offerBtn.layer.cornerRadius = self.offerBtn.frame.size.height/2;
 self.offerBtn.titleLabel.font = [UIFont fontWithName:KIWI_FONT size:self.offerBtn.titleLabel.font.pointSize];
 [Utilities prepareBtn:self.offerBtn];
 offerFrame = self.offerBtn.frame;
 self.offerView = [[OfferView alloc] init];
 self.offerView.delegate = self;
 self.descriptionView.scrollEnabled = NO;
 */
@end

