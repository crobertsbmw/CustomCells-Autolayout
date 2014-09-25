#import "DipticView.h"
#import "WebImage.h"
#import "Utilities.h"
#import "MessageCell.h"
#import "BrowseView.h"
#import "User.h"
#import "Offer.h"
#import "ConnectionManager.h"
#import "KiwiLabel.h"
#import "OfferView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DipticCell.h"

@implementation DipticView{
    int contentHeight;
    NSMutableArray *commentViews;
    ConnectionManager *conman;
    CGRect offerFrame;
    UIView *flagModal;
    NSMutableDictionary *offScreenCells;
}
@synthesize item;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return [self init];
}
/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = @"dipticCell";
    if (indexPath.row > 0){
        reuseIdentifier = @"cell2";
    }
 
    UITableViewCell *cell = [offScreenCells objectForKey:reuseIdentifier];
    if (!cell) {
        if (indexPath.row==0){
            cell = [[DipticCell alloc] init];
        }else{
            cell = [[UITableViewCell alloc] init];
        }
        [offScreenCells setObject:cell forKey:reuseIdentifier];
    }
    
    // Configure the cell with content for the given indexPath, for example:
     cell.textLabel.text = @"one";
    // ...
    
    // Make sure the constraints have been set up for this cell, since it may have just been created from scratch.
    // Use the following lines, assuming you are setting up constraints from within the cell's updateConstraints method:
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // Set the width of the cell to match the width of the table view. This is important so that we'll get the
    // correct cell height for different table view widths if the cell's height depends on its width (due to
    // multi-line UILabels word wrapping, etc). We don't need to do this above in -[tableView:cellForRowAtIndexPath]
    // because it happens automatically when the cell is used in the table view.
    // Also note, the final width of the cell may not be the width of the table view in some cases, for example when a
    // section index is displayed along the right side of the table view. You must account for the reduced cell width.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints.
    // (Note that you must set the preferredMaxLayoutWidth on multi-line UILabels inside the -[layoutSubviews] method
    // of the UITableViewCell subclass, or do it manually at this point before the below 2 lines!)
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell's contentView
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1.0f;
    
    return height;
}
*/
-(id)init{
    //Implementation details go BELOW
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:@"DipticCell" bundle:nil] forCellReuseIdentifier:@"dipticCell"];
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    self.rowHeight = UITableViewAutomaticDimension;
    offScreenCells = [[NSMutableDictionary alloc] init];
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        DipticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dipticCell"];
        if (cell == nil) {
            cell = [[DipticCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"dipticCell"];
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];
        }
        cell.textLabel.text = @"one";
        return cell;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
/*
-(void)setItem:(Item *)itam{
 
    item = itam;
    WebImage *webimage = [self.item.images firstObject];
    if (webimage.image){
        self.imageView.image =  webimage.image;
    }
    
    self.titleLabel.text = self.item.title;
    self.locationLabel.text = self.item.location;
    self.descriptionView.text = self.item.info;

    if(self.item.images.count>1){
        self.imageScrollView.contentSize = CGSizeMake(10+self.item.images.count*(self.imageScrollView.frame.size.height+10), 0);
    }else{ //remove the scroll view.
        
        [self.imageScrollView removeFromSuperview];
    }
    
   // self.scrollView.contentOffset = CGPointMake(0, 0);
    
    if (self.item.comments.count > 0){
        commentViews = [[NSMutableArray alloc] init];
        UIView *prevView = nil;
        for (int i = 0; i < self.item.comments.count; i++){
            if (!prevView){
                prevView = self.commentLabel;
            }
            
            //for each comment display the name of the person, the timestamp and the comment.
            NSDictionary *comment = [self.item.comments objectAtIndex:i];
            
            UIView *commentView = [[UIView alloc] init];
            commentView.translatesAutoresizingMaskIntoConstraints = NO;
            commentView.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:commentView];

            [self.contentView addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:@"H:|[commentView]|"
                                       options:NSLayoutFormatDirectionLeadingToTrailing
                                       metrics:nil
                                       views:NSDictionaryOfVariableBindings(commentView)]];
            [self.contentView addConstraints:[NSLayoutConstraint
                                              constraintsWithVisualFormat:@"V:[prevView]-20-[commentView(==60)]"
                                              options:NSLayoutFormatDirectionLeadingToTrailing
                                              metrics:nil
                                              views:NSDictionaryOfVariableBindings(prevView, commentView)]];
            

            if (self.item.comments.count%2==1?i%2==1:i%2!=1)
                commentView.backgroundColor = [UIColor colorWithWhite:.97 alpha:1];
     
 
            KiwiLabel *nameLabel = [[KiwiLabel alloc] initWithFrame:CGRectMake(20, 10, self.frame.size.width-30, 25)];
            nameLabel.font = [UIFont fontWithName:KIWI_FONT size:20];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.text = comment[@"name"];
            [commentView addSubview:nameLabel];
            
            KiwiTextView *commentLabel = [[KiwiTextView alloc] initWithFrame:CGRectMake(20, 25, self.frame.size.width-30, 20)];
            commentLabel.font = [UIFont fontWithName:KIWI_FONT size:15];
            commentLabel.editable = NO;
            commentLabel.backgroundColor = [UIColor clearColor];
            commentLabel.text = comment[@"comment"];
            [commentView addSubview:commentLabel];
 
           // commentLabel.frame = [Utilities fitToSize:commentLabel]; I'm pretty sure we don't need this line with autolayout
    //
    //        if(comment.posted_by == [User currentUser].pk || [User currentUser].isStaff){
    //            UIButton *delete = [[UIButton alloc] initWithFrame:CGRectMake(246, 4, 55, 55)];
     //           delete.tag = comment.pk;
     //           delete.titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:25];
     //           [delete addTarget:self action:@selector(deleteComment:) forControlEvents:UIControlEventTouchUpInside];
    //            [delete setTitle:@"x" forState:UIControlStateNormal];
     //           [delete setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
     //           [commentView addSubview:delete];
    //        }
 
            [commentViews addObject:commentView];
            prevView = commentView;
        }
        NSLog(@"%@",self.commentLabelTopConstraint);
        [self.contentView removeConstraint:self.commentLabelTopConstraint];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:prevView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.commentTextView attribute:NSLayoutAttributeTop multiplier:0 constant:20]];
    }
    self.commentTextView.hidden = NO;
    self.commentTextView.delegate = self;


    self.cancelComment.hidden = YES;
    self.postComment.hidden = YES;
    [Utilities prepareBtn:self.cancelComment];
    [Utilities prepareBtn:self.postComment];
      
}

-(void)loadAllImages{
    if (self.item.user_avatar){
        [self.profileBtn setBackgroundImage:self.item.user_avatar forState:UIControlStateNormal];
    }else if (self.item.avatar_url){
        __weak typeof(self) weakSelf = self;
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadWithURL:[NSURL URLWithString:self.item.avatar_url] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished){
            if(image){
                weakSelf.item.user_avatar = image;
            }
        }];
    }
    
    if(self.item.images.count>1){
        for (int i = 0; i < self.item.images.count; i++){
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+i*(self.imageScrollView.frame.size.height+10), 0, self.imageScrollView.frame.size.height, self.imageScrollView.frame.size.height)];
            WebImage *wi = [self.item.images objectAtIndex:i];
            NSURL *url = [NSURL URLWithString:wi.image_URL];
            [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"kiwi-icon.png"]];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i;
            imageView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
            [self.imageScrollView addSubview:imageView];
        }
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"begin editing");
    if ([textView.text isEqualToString:@"Click here to post questions/comments."])
        textView.text = @"";
    bool was_hidden = self.cancelComment.hidden;
    self.cancelComment.hidden = NO;
    self.postComment.hidden = NO;
    
    int keyboard = self.noTabBar?167+49:167;
    self.contentSize = CGSizeMake(0, contentHeight + keyboard + self.cancelComment.frame.size.height);
    [UIView transitionWithView:self duration:.25 options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentOffset = CGPointMake(0, self.contentOffset.y + keyboard +(was_hidden?self.cancelComment.frame.size.height:0));
    } completion:nil];
 
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    int keyboard = self.noTabBar?167+49:167;
 
    [UIView transitionWithView:self duration:.25 options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentOffset = CGPointMake(0, self.contentOffset.y-keyboard);
    } completion:^(BOOL finished) {
        self.contentSize = CGSizeMake(0, contentHeight + (self.cancelComment.hidden?0:self.cancelComment.frame.size.height));
    }];
 
}
- (IBAction)cancelCommentPressed:(id)sender {
    self.commentTextView.text = @"Click here to post questions/comments.";
    if ([self.commentTextView isFirstResponder]){
        self.cancelComment.hidden = YES;
        self.postComment.hidden = YES;
        [self.commentTextView resignFirstResponder];
    }else{
 
    [UIView transitionWithView:self duration:.10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentOffset = CGPointMake(0, self.contentOffset.y - self.cancelComment.frame.size.height);
    } completion:^(BOOL finished) {
        self.cancelComment.hidden = YES;
        self.postComment.hidden = YES;
        [self.commentTextView resignFirstResponder];
        self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height-self.cancelComment.frame.size.height);
    }];
 
        self.cancelComment.hidden = YES;
        self.postComment.hidden = YES;
        [self.commentTextView resignFirstResponder];
    }
}

- (IBAction)postCommentPressed:(id)sender {
    NSString *text = self.commentTextView.text;
    if (text.length < 2 || [text isEqualToString:@"Click here to post questions/comments."]){
        [[[UIAlertView alloc] initWithTitle:@"Try entering a longer comment." message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
        return;
    }
    
    self.postComment.enabled = NO;
    __weak typeof(self) weakSelf = self;
    __weak typeof(commentViews) weakCommentViews = commentViews;
    
    [self.item addComment:text withCompletion:^(NSString *error) {
        weakSelf.postComment.enabled = YES;
        if (!error){
            for (int i = 0; i < weakCommentViews.count; i++){
                UIView *comment = weakCommentViews[i];
                [comment removeFromSuperview];
            }
            NSDictionary *commentDict = @{@"name":[User currentUser].firstName,@"comment":text};
            [weakSelf.item.comments addObject:commentDict];
            [weakSelf cancelCommentPressed:nil];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"Error Saving Comment" message:error delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
        }
    }];
}

- (IBAction)avatarBtnPressed:(id)sender {
    NSLog(@"avatar button pressed");
    [self.dipticDelegate avatarTapped];
}

- (IBAction)makeOffer:(id)sender {
    
    self.offerView.frame = self.offerBtn.frame;
    CGPoint point = [self.offerBtn.superview convertPoint:self.offerBtn.center toView:nil];
    [self.window addSubview:self.offerView];
    self.offerView.center = point;
    
    self.offerView.layer.cornerRadius = self.offerView.frame.size.width/2;
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAAnimationLinear];
    anim1.fromValue = [NSNumber numberWithFloat:self.offerView.layer.cornerRadius];
    anim1.toValue = [NSNumber numberWithFloat:240.0f];
    anim1.duration = .2;
    self.offerView.layer.cornerRadius = 240.0f;
    
    [self.offerView.layer addAnimation:anim1 forKey:@"cornerRadius"];
    
    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.offerBtn.alpha = 0;
        self.offerView.frame = CGRectMake(50, 50, 480, 480);
    } completion:nil];
    
}

-(void)dismissOfferView{
    CGPoint point = [self.offerBtn.superview convertPoint:self.offerBtn.frame.origin toView:nil];
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAAnimationLinear];
    anim1.fromValue = [NSNumber numberWithFloat:self.offerView.layer.cornerRadius];
    anim1.toValue = [NSNumber numberWithFloat:self.offerBtn.frame.size.width/2];
    anim1.duration = .2;
    self.offerView.layer.cornerRadius = self.offerBtn.frame.size.width/2;
    [self.offerView.layer addAnimation:anim1 forKey:@"cornerRadius"];

    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.offerBtn.alpha = 1;
        self.offerView.frame = CGRectMake(point.x, point.y, self.offerBtn.frame.size.width, self.offerBtn.frame.size.height);
    } completion:^(BOOL finished) {
        [self.offerView removeFromSuperview];
    }];
}

-(void)submitOffer:(NSString *)cash{
    if([User currentUser].isGuest){
        [[[UIAlertView alloc] initWithTitle:@"Create an account" message:@"Before you can make an offer, you must create an account or login." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil]show];
        return;
    };
    User *user = [User currentUser];
    if (!user.deviceToken || user.deviceToken.length < 2){
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    for (int i = 0; i < user.acceptedOffers.count; i++){
        Offer *offer = user.acceptedOffers[i];
        if (offer.item.pk == self.item.pk){
            [[[UIAlertView alloc] initWithTitle:@"Offer already made." message:@"The seller has already accepted an offer from you for this item." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
    }
    for (int i = 0; i < user.sentOffers.count; i++){
        Offer *offer = user.sentOffers[i];
        if (offer.item.pk == self.item.pk){
            [[[UIAlertView alloc] initWithTitle:@"Offer already made." message:@"You have already made an offer on this item." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
    }
    for (int i = 0; i < user.recievedOffers.count; i++){
        Offer *offer = user.recievedOffers[i];
        if (offer.item.pk == self.item.pk){
            [[[UIAlertView alloc] initWithTitle:@"Offer already made." message:@"You have already made an offer on this item, and a counter-offer is now waiting your review." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
    }
    
    Offer *offer = [[Offer alloc] init];
    offer.item = self.item;
    //If we are logged in we shouldn't have to set the owner and buyer.
    offer.cash = cash;
    offer.type = @"offer";
    self.offerView.cashField.enabled = NO;

    [offer saveInBackground:^(NSString *error) {
        self.offerView.cashField.enabled = YES;
        [[User currentUser].sentOffers addObject:offer];
        if (error){
            self.offerView.cashField.text = @"Error, please try again.";
        }else{
            [self setOffered:offer.cash];
        }
    }];
}
-(void)setOffered:(NSString*)cash{
    self.offerBtn.backgroundColor = [UIColor colorWithWhite:.10 alpha:1];
    [self.offerBtn setTitleColor:CREAM_COLOR forState:UIControlStateNormal];
    [self.offerBtn setTitle:@"OFFERD" forState:UIControlStateNormal];
    self.offerView.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
    [self.offerView.cashField setTextColor:CREAM_COLOR];
    self.offerView.cashField.enabled = NO;
    self.offerView.cashField.text = cash;
    [self.offerView.acceptBtn removeFromSuperview];
    [self.offerView.declineBtn removeFromSuperview];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissOfferView)];
    [self.offerView addGestureRecognizer:tap];
}
- (IBAction)flagBtnPressed:(id)sender {
    if (!flagModal){
        flagModal = [[UIView alloc] initWithFrame:CGRectMake(30, 70, 320-60, 280)];
        flagModal.layer.cornerRadius = 10;
        flagModal.backgroundColor = [UIColor whiteColor];
        
        UITextView *titleField = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 320-80, 40)];
        titleField.font = [UIFont fontWithName:KIWI_FONT size:22];
        titleField.text = @"Flag this item?";
        titleField.userInteractionEnabled = NO;
        titleField.textAlignment = NSTextAlignmentCenter;
        titleField.backgroundColor = [UIColor clearColor];
        
        UITextView *textField = [[UITextView alloc] initWithFrame:CGRectMake(10, 60, 320-80, 90)];
        textField.font = [UIFont fontWithName:KIWI_FONT size:16];
        textField.text = @"Thank you for helping keep the community safe by flagging content that is spam, inappropriate, or scams.";
        textField.userInteractionEnabled = NO;
        textField.backgroundColor = [UIColor clearColor];
        
        [flagModal addSubview:textField];
        [flagModal addSubview:titleField];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelBtn addTarget:self
                      action:@selector(cancelFlag:)
            forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont fontWithName:KIWI_FONT size:17];
        
        cancelBtn.frame = CGRectMake(10, 160, 320-80, 50);
        [flagModal addSubview:cancelBtn];
        
        UIButton *flagItemBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [flagItemBtn addTarget:self
                        action:@selector(flagItem:)
              forControlEvents:UIControlEventTouchUpInside];
        [flagItemBtn setTitle:@"Flag Item" forState:UIControlStateNormal];
        flagItemBtn.titleLabel.font = [UIFont fontWithName:KIWI_FONT size:17];
        flagItemBtn.frame = CGRectMake(10, 220, 320-80, 50);
        [flagModal addSubview:flagItemBtn];
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:flagModal.bounds];
        flagModal.layer.masksToBounds = NO;
        flagModal.layer.shadowColor = [UIColor blackColor].CGColor;
        flagModal.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        flagModal.layer.shadowRadius = 10;
        flagModal.layer.shadowOpacity = 2.5f;
        flagModal.layer.shadowPath = shadowPath.CGPath;
    }
    [self addSubview:flagModal];
    flagModal.alpha = 0;
    [UIView animateWithDuration:.3 animations:^{
        flagModal.alpha = 1;
    }];
}

-(void)cancelFlag:(id)sender {
    flagModal.alpha = 1;
    [UIView animateWithDuration:.3 animations:^{
        flagModal.alpha = 0;
    } completion:^(BOOL finished) {
        [flagModal removeFromSuperview];
    }];
}

-(void)flagItem:(id)sender{
    [self.item reportItem];
    [self cancelFlag:nil];
    [self.dipticDelegate didFlagItem:self.item];
}
*/
@end
