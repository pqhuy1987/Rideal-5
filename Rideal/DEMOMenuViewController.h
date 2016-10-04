//
//  DEMOMenuViewController.h
//  QFC
//
//  Created by OSX on 21/01/16.
//  Copyright (c) 2016 Harpreet. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface DEMOMenuViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,NSURLConnectionDelegate>
{
    MBProgressHUD *hud;
    UIImagePickerController *imgPicker;
}
@property (weak, nonatomic) IBOutlet UIImageView *allToggleImage;
@property (weak, nonatomic) IBOutlet UIImageView *ImgProfile;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_Name;
@property (weak, nonatomic) IBOutlet UIButton *btn_Uber;
@property (weak, nonatomic) IBOutlet UIImageView *Img_btn_Uber;
@property (weak, nonatomic) IBOutlet UIImageView *Img_Btn_Lyft;
@property (weak, nonatomic) IBOutlet UIImageView *Img_btn_both;
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (weak, nonatomic) IBOutlet UIButton *selectImage;
- (IBAction)grabImage:(id)sender;

- (IBAction)ActionUberBtn:(id)sender;
- (IBAction)ActionLyftBtn:(id)sender;
- (IBAction)ActionBothBtn:(id)sender;
- (IBAction)ActionMessage:(id)sender;
- (IBAction)ActionShareBtn:(id)sender;
- (IBAction)ActionPrivacyBtn:(id)sender;
- (IBAction)ActionLogout:(id)sender;
- (IBAction)allBtnAction:(id)sender;

@end
