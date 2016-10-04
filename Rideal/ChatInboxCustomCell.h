//
//  ChatInboxCustomCell.h
//  Rideal
//
//  Created by OSX on 02/09/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatInboxCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameTitle;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageTime;

@end
