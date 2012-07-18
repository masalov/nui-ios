//
//  NUIViewController.m
//  NUILayout
//
//  Created by Ivan Masalov on 6/8/12.
//  Copyright (c) 2012 eko team. All rights reserved.
//

#import "NUIViewController.h"
#import "NUILoader/NUILoader.h"

@interface NUIViewController ()

@property (nonatomic, retain) NUILoader *loader;
@property (nonatomic, retain) UILabel *label2;

@end

@implementation NUIViewController

@synthesize loader = loader_;
@synthesize label2 = label2_;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loader = [[[NUILoader alloc] initWithRootObject:self] autorelease];
    [loader_ loadFromFile:@"nui.nui"];
    label2_.backgroundColor = [UIColor redColor];
}

- (void)buttonTapped:(UIButton *)b
{
    if (b.selected) {
        [loader_ loadState:@"shown"];
    } else {
        [loader_ loadState:@"hidden"];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
