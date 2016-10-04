//
//  ViewController.h
//  Rideal
//
//  Created by OSX on 25/08/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface ViewController : UIViewController<UITextFieldDelegate>
{
    MBProgressHUD *hud;
}
@property (strong, nonatomic) IBOutlet UIView *ViewFirst;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UIView* viewSignUp;
@property (strong, nonatomic) IBOutlet UIView *ViewForgetpassword;

- (IBAction)ActionViewSignUp:(id)sender;
- (IBAction)ActionSignUp:(id)sender;
- (IBAction)ActionCloseSighUp:(id)sender;
- (IBAction)ActionSignIn:(id)sender;
- (IBAction)ActionTermAndCondition:(id)sender;
- (IBAction)ActionForgetPassword:(id)sender;
- (IBAction)ActionSubmutForgetEmail:(id)sender;
- (IBAction)ActionCloseForget:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtForgetEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtSigninUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtSigninPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtSignUpRepeatPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtSignUpUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtSignUpEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtSignUpPassword;

- (IBAction)ActionUberBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BtnUberBtnClicked;
- (IBAction)ActionLyftBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BtnLyftBtnClicked;
- (IBAction)ActionBothBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BtnBothBtnClicked;

@end

