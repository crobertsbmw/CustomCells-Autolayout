//
//  DipticView.h
//  Kiwi
//
//  Created by croberts on 11/15/13.
//  Copyright (c) 2013 Roberts. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DipticView;             //define class, so protocol can see MyClass

@interface DipticView : UITableView <UITextViewDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@end
