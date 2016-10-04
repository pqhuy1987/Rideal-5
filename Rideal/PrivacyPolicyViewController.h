//
//  PrivacyPolicyViewController.h
//  Rideal
//
//  Created by OSX on 02/09/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface PrivacyPolicyViewController : UIViewController
{
    MBProgressHUD *hud;
}
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *hedTitle;
@property(weak,nonatomic) NSString *headTitle;
@property (assign) BOOL privacy ;

@end
