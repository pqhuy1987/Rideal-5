//
//  ChatInboxViewController.h
//  Rideal
//
//  Created by OSX on 30/08/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "MBProgressHUD.h"
#import "PrefixHeader.pch"


@interface ChatInboxViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    MBProgressHUD *hud;
    NSMutableArray *inboxData;
}
@property (strong , nonatomic) IBOutlet UITableView *tblView;
- (IBAction)cmdHomeBtn:(id)sender;

- (IBAction)backBTn:(id)sender;



@end
