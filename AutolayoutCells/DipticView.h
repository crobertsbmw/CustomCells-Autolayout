//
//  DipticView.h
//  Kiwi
//
//  Created by croberts on 11/15/13.
//  Copyright (c) 2013 Roberts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "KiwiTextView.h"
#import "OfferView.h"
@class DipticView;             //define class, so protocol can see MyClass
@protocol DipticDelegate   //define delegate protocol
-(void)avatarTapped;  //define delegate method to be implemented within another class
-(void)didFlagItem:(Item*)item;
@end //end protocol

@interface DipticView : UITableView <UITextViewDelegate, UIGestureRecognizerDelegate, OfferViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Item *item;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionView;
@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet KiwiTextView *commentTextView;
@property (strong, nonatomic) IBOutlet UIButton *cancelComment;
@property (strong, nonatomic) IBOutlet UIButton *postComment;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
@property (strong, nonatomic) IBOutlet UIButton *profileBtn;
@property (nonatomic, weak) id <DipticDelegate> dipticDelegate; //define MyClassDelegate as delegate
@property (strong, nonatomic) IBOutlet UIButton *offerBtn;
@property (strong, nonatomic) OfferView *offerView;
@property (strong, nonatomic) IBOutlet UIButton *flagItem;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *commentLabelTopConstraint;
 
@property bool hasScrollen, noTabBar;
-(void)loadAllImages;
-(void)setOffered:(NSString*)cash;
@end
