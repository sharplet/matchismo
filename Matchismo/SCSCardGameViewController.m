//
//  SCSCardGameViewController.m
//  Matchismo
//
//  Created by Adam Sharp on 30/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSCardGameViewController.h"

@interface SCSCardGameViewController ()

@end

@implementation SCSCardGameViewController

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
}

@end
