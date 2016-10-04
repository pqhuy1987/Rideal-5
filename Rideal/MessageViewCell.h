//
//  MessageViewCell.h
//  Rideal
//
//  Created by OSX on 05/09/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *senderMessageWrapperView;
@property (weak, nonatomic) IBOutlet UITextView *senderTextView;
@property (weak, nonatomic) IBOutlet UILabel *sendetTimeLbl;

@property (weak, nonatomic) IBOutlet UIView *wrapperView;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@end
