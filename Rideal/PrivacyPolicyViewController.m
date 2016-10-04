//
//  PrivacyPolicyViewController.m
//  Rideal
//
//  Created by OSX on 02/09/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import "PrivacyPolicyViewController.h"
#import "DataModel.h"
#import "PrefixHeader.pch"
@interface PrivacyPolicyViewController ()

@end

@implementation PrivacyPolicyViewController
@synthesize webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hedTitle.text = [NSString stringWithFormat:@"%@",_headTitle];
    
    [self loadwebView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadwebView
{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    [[DataModel sharedDataManager] Api:GET_TERMS_AND_CONDITIONS Data:nil withBlock:^(id response, NSError *error)
     {
         if (error)
         {
             [hud hideAnimated:YES];
             [self ShowAlertOK:@"Try Again.."];
         }
         else
         {
             if ([[response valueForKey:@"response"]intValue] == 1)
             {
                 
                
                 [hud hideAnimated:YES];
                 
                 if (_privacy)
                 {
                     [webView loadHTMLString:[response valueForKey:@"privacy"] baseURL:nil];
                 }
                 else
                 {
                     [webView loadHTMLString:[response valueForKey:@"terms"] baseURL:nil];
                 }
                 
                 
                 
             }
             else{
                 
                
                 
             }
         }
     }];

}


-(void)ShowAlertOK:(NSString*)Str
{
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

- (IBAction)backButton:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
