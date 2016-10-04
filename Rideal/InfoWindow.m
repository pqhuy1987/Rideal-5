//
//  InfoWindow.m
//  Rideal
//
//  Created by OSX on 08/09/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import "InfoWindow.h"

@implementation InfoWindow
@synthesize photo;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[self layer] setCornerRadius:10.0f];
        [[self layer] setMasksToBounds:YES];
    }
    return self;
}


@end
