//
//  ViewController.m
//  AutolayoutCells
//
//  Created by croberts on 9/25/14.
//  Copyright (c) 2014 Roberts. All rights reserved.
//

#import "ViewController.h"
#import "DipticView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DipticView *view = [[DipticView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
