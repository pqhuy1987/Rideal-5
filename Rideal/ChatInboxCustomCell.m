//
//  ChatInboxCustomCell.m
//  Rideal
//
//  Created by OSX on 02/09/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import "ChatInboxCustomCell.h"

@implementation ChatInboxCustomCell
@synthesize nameLbl = _nameLbl;
@synthesize nameTitle = _nameTitle;
@synthesize messageTime = _messageTime;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
