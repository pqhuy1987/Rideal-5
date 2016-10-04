//
//  MessageViewCell.m
//  Rideal
//
//  Created by OSX on 05/09/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import "MessageViewCell.h"

@implementation MessageViewCell
@synthesize messageTextView = _messageTextView;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
