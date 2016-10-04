//
//  MessagesViewController.h
//  Rideal
//
//  Created by OSX on 05/09/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "MBProgressHUD.h"
#import "PrefixHeader.pch"
@interface MessagesViewController : UIViewController<UIAccelerometerDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate>
{
    NSMutableArray *messageData;
    NSTimer *timer;
    int previousData;
    MBProgressHUD *hud;
    int i;
    NSString *msg;
}

@property (weak, nonatomic) IBOutlet UITableView *messageTableView;

@property (weak, nonatomic) IBOutlet UIView *messageWrapperView;

@property (weak, nonatomic) IBOutlet UITextField *messageTxtField;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property(nonatomic) NSString *friendID;
@property(nonatomic) NSString *name;

- (IBAction)backBtn:(id)sender;

- (IBAction)sendMessae:(id)sender;
- (IBAction)blockUser:(id)sender;

@end
