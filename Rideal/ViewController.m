//
//  ViewController.m
//  Rideal
//
//  Created by OSX on 25/08/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "DEMORootViewController.h"
#import "PrefixHeader.pch"
#import "DataModel.h"
#import "MBProgressHUD.h"
#import "PrivacyPolicyViewController.h"
#import <Foundation/Foundation.h>
@import QuartzCore;

@interface ViewController ()
{
    UITapGestureRecognizer * tapGesture;
    UIWindow *window;
    bool isSelectTerm;
    bool isKeyBoardOpen;
    NSString *StrRoleType;
    
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    
    StrRoleType = @"";
    
    [self Animation];
    tapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BackgroundTap)];
    [self.view addGestureRecognizer:tapGesture];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [_txtForgetEmail resignFirstResponder];
    [_txtSigninPassword resignFirstResponder];
    [_txtSigninUsername resignFirstResponder];
    [_txtSignUpEmail resignFirstResponder];
    [_txtSignUpPassword resignFirstResponder];
    [_txtSignUpUsername resignFirstResponder];
}

-(void)BackgroundTap
{
    [_txtForgetEmail resignFirstResponder];
    [_txtSigninPassword resignFirstResponder];
    [_txtSigninUsername resignFirstResponder];
    [_txtSignUpEmail resignFirstResponder];
    [_txtSignUpPassword resignFirstResponder];
    [_txtSignUpUsername resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Animation{
    
    [UIView animateWithDuration:3.0
                          delay: 0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         _backgroundImage.frame = CGRectMake( _backgroundImage.frame.origin.x-10, _backgroundImage.frame.origin.y, _backgroundImage.frame.size.width+30, _backgroundImage.frame.size.height+30);
                         
                         
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:3.0
                                               delay: 0.0
                                             options: UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              _backgroundImage.frame = CGRectMake( _backgroundImage.frame.origin.x, _backgroundImage.frame.origin.y-10, _backgroundImage.frame.size.width, _backgroundImage.frame.size.height);
                                              
                                              
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:3.0
                                                                    delay: 0.0
                                                                  options: UIViewAnimationOptionCurveLinear
                                                               animations:^{
                                                                   _backgroundImage.frame = CGRectMake( _backgroundImage.frame.origin.x+10, _backgroundImage.frame.origin.y, _backgroundImage.frame.size.width-30, _backgroundImage.frame.size.height-30);
                                                                   
                                                                   
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [UIView animateWithDuration:3.0
                                                                                         delay: 0.0
                                                                                       options: UIViewAnimationOptionCurveLinear
                                                                                    animations:^{
                                                                                        _backgroundImage.frame = CGRectMake( _backgroundImage.frame.origin.x, _backgroundImage.frame.origin.y+10, _backgroundImage.frame.size.width+30, _backgroundImage.frame.size.height+30);
                                                                                        
                                                                                        
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        
                                                                                        [UIView animateWithDuration:3.0
                                                                                                              delay: 0.0
                                                                                                            options: UIViewAnimationOptionCurveLinear
                                                                                                         animations:^{
                                                                                                             _backgroundImage.frame = CGRectMake( _backgroundImage.frame.origin.x-10, _backgroundImage.frame.origin.y, _backgroundImage.frame.size.width, _backgroundImage.frame.size.height);
                                                                                                             
                                                                                                             
                                                                                                         }
                                                                                                         completion:^(BOOL finished) {
                                                                                                             [UIView animateWithDuration:3.0
                                                                                                                                   delay: 0.0
                                                                                                                                 options: UIViewAnimationOptionCurveLinear
                                                                                                                              animations:^{
                                                                                                                                  _backgroundImage.frame = CGRectMake( _backgroundImage.frame.origin.x+10, _backgroundImage.frame.origin.y, _backgroundImage.frame.size.width-30, _backgroundImage.frame.size.height-30);
                                                                                                                                  
                                                                                                                                  
                                                                                                                              }
                                                                                                                              completion:^(BOOL finished) {
                                                                                                                                  [self Animation];
                                                                                                                              }];
                                                                                                         }];
                                                                                        
                                                                                    }];
                                                                   
                                                               }];
                                              
                                          }];
                         
                     }];
}


- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 30, 0);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 30, 0);
}
- (IBAction)ActionViewSignUp:(id)sender {
    _viewSignUp.hidden = NO;
    
    _viewSignUp.frame = CGRectMake(500, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    [UIView animateWithDuration:1.0 animations:^{
        _viewSignUp.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _ViewFirst.frame = CGRectMake(500, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        _ViewFirst.hidden = YES;
        
    }];
}


#pragma mark - Action SignIn

- (IBAction)ActionSignIn:(id)sender
{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");

    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"MyAppDeviceToken"];
  
    if (_txtSigninUsername.text.length == 0 )
    {
        [hud hideAnimated:YES];
        [self ShowAlertOK:@"Enter Email First..."];
    }
    else if (_txtSigninPassword.text.length <= 0 )
    {
        [hud hideAnimated:YES];
        [self ShowAlertOK:@"Enter Password First..."];
    }
    else
    {
       
        
        NSString *deviceToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"MyAppDeviceToken"];
        
        
        NSDictionary * dict = @{
                                @"email":_txtSigninUsername.text,
                                @"password" :_txtSigninPassword.text,
                                @"token" :deviceToken,
                                @"dType" : @"IOS"
                                };
//        NSDictionary * dict = @{
//                                @"email":_txtSigninUsername.text,
//                                @"password" :_txtSigninPassword.text,
//                                @"token" :@"jh34br43br34rbhj34vvr3vrvrvrhj2v3rhv32jhrv32",
//                                @"dType" : @"IOS"
//                                };
      
        
        [[DataModel sharedDataManager] Api:GET_LOGIN_API Data:dict withBlock:^(id response, NSError *error)
        {
            if (error) {
                
                [hud hideAnimated:YES];
                
                [self ShowAlertOK:@"Try Again.."];
            }
            else{
                if ([[response valueForKey:@"response"]intValue] ==1)
                {
                    [hud hideAnimated:YES];
                    
//                    NSLog(@"response%@",response);
                    
                    [[NSUserDefaults standardUserDefaults]setValue:[[response valueForKey:@"data"]valueForKey:@"username"] forKey:@"username"];
                    [[NSUserDefaults standardUserDefaults]setValue:[[response valueForKey:@"data"]valueForKey:@"id"] forKey:@"id"];
                    [[NSUserDefaults standardUserDefaults]setValue:[[response valueForKey:@"data"]valueForKey:@"image"] forKey:@"image"];
                    
                    NSLog(@"%@",[response valueForKey:@"data"]);
                    
                    [[NSUserDefaults standardUserDefaults]setValue:[[response valueForKey:@"data"]valueForKey:@"email"] forKey:@"email"];
                    [[NSUserDefaults standardUserDefaults]setValue:@"All" forKey:@"type"];
                    
                    [_txtSigninPassword resignFirstResponder];
                    
                    
                    [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"isLogin"];
                    
                    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    DEMORootViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"DEMORootViewController"];
                    window.rootViewController = vc ;
                    [window makeKeyAndVisible];

//                    CurrentUserName = [NSString stringWithFormat:@"%@ %@", [[response valueForKey:@"data"] valueForKey:@"fname"],[[response valueForKey:@"data"] valueForKey:@"lname"]];
//                    LoginType = @"Email";
//                    [DEFAULTS setValue:[response valueForKey:@"data"] forKey:@"CurrentUserData"];
//                    
//                    [DEFAULTS setValue:[[response valueForKey:@"data"] valueForKey:@"ID"] forKey:@"CurrentUserID"];
//                    [DEFAULTS synchronize];
//                    [self Login];
                }
                else
                {
                    [hud hideAnimated:YES];
                    [self ShowAlertOK:[response valueForKey:@"message"]];
                }
                
            }

        }];
    }
}


#pragma mark - Action SignUp

- (IBAction)ActionSignUp:(id)sender
{

    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    BOOL validEmail = [ self NSStringIsValidEmail:_txtSignUpEmail.text];

    if (_txtSignUpUsername.text.length == 0)
    {
        [hud hideAnimated:YES];
        [self ShowAlertOK:@"Please Enter Username."];
    }
    else if (!validEmail)
    {
        [hud hideAnimated:YES];
        [self ShowAlertOK:@"Please Enter Valid Email"];
    }
    else if (_txtSignUpPassword.text.length ==0)
    {
        [hud hideAnimated:YES];
        [self ShowAlertOK:@"Please Enter Password"];
    }
    else if (_txtSignUpPassword.text.length <=5)
    {
        [hud hideAnimated:YES];
        [self ShowAlertOK:@"Please Enter Atlest 6 Character."];
    }
    else if (_txtSignUpRepeatPassword.text.length == 0)
    {
        [hud hideAnimated:YES];
        [self ShowAlertOK:@"Please Confirm Your Password."];
    }
    else if (![_txtSignUpRepeatPassword.text isEqualToString:_txtSignUpPassword.text])
    {
        [hud hideAnimated:YES];
        [self ShowAlertOK:@"Password does not matched"];
    }
    else if ([StrRoleType isEqualToString:@""])
    {
        [hud hideAnimated:YES];
        [self ShowAlertOK:@"Please Select Role"];
    }
    else
    {
        NSDictionary * dict = @{
                                @"username":_txtSignUpUsername.text,
                                @"email":_txtSignUpEmail.text,
                                @"password":_txtSignUpPassword.text,
                                @"role" :StrRoleType,
                                };
        [[DataModel sharedDataManager] Api:GET_REGISTER_API Data:dict withBlock:^(id response, NSError *error) {
            
            if (error) {
                
                [hud hideAnimated:YES];
                
                [self ShowAlertOK:@"Try Again.."];
            }
            else{
                if ([[response valueForKey:@"response"] intValue] == 1) {
                    
                    [self ShowAlertOK:[response valueForKey:@"message"]];
                   
                    [[NSUserDefaults standardUserDefaults]setValue:[[response valueForKey:@"data"]valueForKey:@"username"] forKey:@"username"];
                    [[NSUserDefaults standardUserDefaults]setValue:[[response valueForKey:@"data"]valueForKey:@"id"] forKey:@"id"];
                    [[NSUserDefaults standardUserDefaults]setValue:[[response valueForKey:@"data"]valueForKey:@"email"] forKey:@"email"];
                    
                    [hud hideAnimated:YES];
                    
                    _ViewFirst.hidden = NO;
                    [self SetTextFeild];
                    _ViewFirst.frame = CGRectMake(500, 0, self.view.frame.size.width, self.view.frame.size.height);
                    [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                        _viewSignUp.frame = CGRectMake(500, 0, self.view.frame.size.width, self.view.frame.size.height);
                        _ViewFirst.frame = CGRectMake(00, 0, self.view.frame.size.width, self.view.frame.size.height);
                        
                    if (isKeyBoardOpen==YES)
                    {
                        _viewSignUp.hidden = YES;
                            
                    } } completion:^(BOOL finished) {
                        _viewSignUp.hidden = YES;
                        
                    }];

                        _txtSignUpEmail.text = @"";
                        _txtSignUpPassword.text = @"";
                        _txtSignUpRepeatPassword.text = @"";
                        _txtSignUpUsername.text = @"";
                    [_BtnBothBtnClicked setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox.png"] forState:UIControlStateNormal];
                    [_BtnLyftBtnClicked setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox.png"] forState:UIControlStateNormal];
                    [_BtnUberBtnClicked setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox.png"] forState:UIControlStateNormal];
                    isSelectTerm = NO;

                    
//                        window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                        DEMORootViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"DEMORootViewController"];
//                        window.rootViewController = vc ;
//                        [window makeKeyAndVisible];
                    
                    
                 }
                else
                {
                    
                    [hud hideAnimated:YES];
                    
                    [self ShowAlertOK:[response valueForKey:@"mesg"]];
                }
                
                
            }
        }];
        
        
    }
    
}

- (IBAction)ActionCheckBox:(id)sender
{
    if (isSelectTerm==YES)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox.png"] forState:UIControlStateNormal];
        isSelectTerm = NO;
    }
    else if (isSelectTerm==NO)
    {
        isSelectTerm= YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"checked_checkbox.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)ActionUberBtnClicked:(id)sender
{
    StrRoleType =@"Uber";
    [_BtnUberBtnClicked setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    [_BtnLyftBtnClicked setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [_BtnBothBtnClicked setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
}
- (IBAction)ActionLyftBtnClicked:(id)sender {
    StrRoleType =@"Lyft";
    [_BtnUberBtnClicked setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [_BtnLyftBtnClicked setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    [_BtnBothBtnClicked setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
}
- (IBAction)ActionBothBtnClicked:(id)sender
{
    StrRoleType =@"Both";
    [_BtnUberBtnClicked setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [_BtnLyftBtnClicked setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [_BtnBothBtnClicked setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
}
- (IBAction)ActionTermAndCondition:(id)sender {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PrivacyPolicyViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"PrivacyPolicyViewController"];
    vc.headTitle = @"Terms And Condition";
    vc.privacy = NO;
    [self presentViewController:vc animated:NO completion:nil];
    
//    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
//    hud.label.font = [UIFont italicSystemFontOfSize:16.f];
//    
//    
//    [[DataModel sharedDataManager] Api:GET_TERMS_AND_CONDITIONS Data:nil withBlock:^(id response, NSError *error)
//     {
//         if (error)
//         {
//             [hud hideAnimated:YES];
//             [self ShowAlertOK:@"Try Again.."];
//         }
//         else
//         {
//             if ([[response valueForKey:@"response"]intValue] == 1)
//             {
//                 [hud hideAnimated:YES];
//                 [self ShowAlertOK:[response valueForKey:@"terms"]];
//             }
//             else{
//                 [hud hideAnimated:YES];
//                 [self ShowAlertOK:[response valueForKey:@"message"]];
//             }
//         }
//     }];
}

- (IBAction)ActionForgetPassword:(id)sender
{
    _ViewForgetpassword.hidden = NO;
    _ViewForgetpassword.frame = CGRectMake(500, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    [UIView animateWithDuration:1.0 animations:^{
        _ViewForgetpassword.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _ViewFirst.frame = CGRectMake(500, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self SetTextFeild];
    return YES;
}

#pragma mark - Action Forgot

- (IBAction)ActionSubmutForgetEmail:(id)sender
{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    hud.label.font = [UIFont italicSystemFontOfSize:16.f];

    
    if (_txtForgetEmail.text.length == 0 )
    {
        [hud hideAnimated:YES];
        
        [self ShowAlertOK:@"Enter Email First..."];
    }
    else if (![self NSStringIsValidEmail:_txtForgetEmail.text])
    {
        [hud hideAnimated:YES];
        [self ShowAlertOK:@"Please Enter Valid Email"];
    }
    else
    {
        NSDictionary * dict = @{
                                 @"email":_txtForgetEmail.text,
                               };
        [[DataModel sharedDataManager] Api:GET_FORGET_PASSWORD_API Data:dict withBlock:^(id response, NSError *error)
         {
             if (error) {
                 [hud hideAnimated:YES];
                 [self ShowAlertOK:@"Try Again.."];
             }
             else{
                 if ([[response valueForKey:@"response"]intValue] == 1)
                 {
                     
                     [self ShowAlertOK:[response valueForKey:@"message"]];
                     [hud hideAnimated:YES];
                 }
                 else
                 {
                     [hud hideAnimated:YES];
                     [self ShowAlertOK:@"Email does not exist!"];
                 }
             }
         }];
    }
}

- (IBAction)ActionCloseForget:(id)sender {
  //  _viewSignIn.hidden = NO;
    _ViewFirst.hidden = NO;
    [self SetTextFeild];
    
    _ViewFirst.frame = CGRectMake(500, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView animateKeyframesWithDuration:1.0 delay:0.2 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        _ViewForgetpassword.frame = CGRectMake(500, 0, self.view.frame.size.width, self.view.frame.size.height);
        _ViewFirst.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        if (isKeyBoardOpen==YES) {
            _ViewForgetpassword.hidden = YES;
            
        }
        
        
        
    } completion:^(BOOL finished) {
        _ViewForgetpassword.hidden = YES;
        
    }];
    
}
- (IBAction)ActionCloseSighUp:(id)sender {
    _ViewFirst.hidden = NO;
    
    [self SetTextFeild];
    //    _txtSignUpEmail.text = @"";
    //    _txtSignUpPassword.text = @"";
    //    _txtSignUpPhone.text = @"";
    //    _txtSignUpUsername.text = @"";
    //    [_btnSelectedCountry setTitle:@"" forState:UIControlStateNormal];
    //    [_btnCheck setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox.png"] forState:UIControlStateNormal];
    //    isSelectTerm = NO;
    
    _ViewFirst.frame = CGRectMake(500, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    
    
    [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        _viewSignUp.frame = CGRectMake(500, 0, self.view.frame.size.width, self.view.frame.size.height);
        _ViewFirst.frame = CGRectMake(00, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
        if (isKeyBoardOpen==YES) {
            _viewSignUp.hidden = YES;
            
        }
        
        
    } completion:^(BOOL finished) {
        _viewSignUp.hidden = YES;
        
    }];
    
    
    
    
}
-(void)ShowAlertOK:(NSString*)Str{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:Str
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                    
                                    
                                }];
    
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)SetTextFeild
{
    [_txtSignUpRepeatPassword resignFirstResponder];
    [_txtForgetEmail resignFirstResponder];
    [_txtSigninPassword resignFirstResponder];
    [_txtSigninUsername resignFirstResponder];
    [_txtSignUpPassword resignFirstResponder];
    [_txtSignUpUsername resignFirstResponder];
    [_txtSignUpEmail resignFirstResponder];
}

#pragma MARK:- Email Validation

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}





@end
