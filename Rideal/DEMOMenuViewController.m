//
//  DEMOMenuViewController.m
//  QFC
//
//  Created by OSX on 21/01/16.
//  Copyright (c) 2016 Harpreet. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "DEMONavigationController.h"
#import "ViewController.h"
#import "ChatInboxViewController.h"
#import "PrivacyPolicyViewController.h"
#import "DataModel.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

#import <SDWebImage/UIImageView+WebCache.h>
@interface DEMOMenuViewController ()
{
    NSArray *ArrayName;
    NSArray *ArrayImages;
    NSString *StrRoleType;
    
    NSData *pngData;
    NSData *syncResData;
    NSMutableURLRequest *request;
}
@end

@implementation DEMOMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ImgProfile.layer.cornerRadius =  self.ImgProfile.frame.size.width/2;
    self.ImgProfile.layer.masksToBounds = YES;  
    
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.allowsImageEditing = YES;
    self.imgPicker.delegate = self;
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Do any additional setup after loading the view.
    
 //   NSString *type = [[NSUserDefaults standardUserDefaults]valueForKey:@"type"];
     NSString *type = @"All";
    
    NSString *name = [[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
    _Lbl_Name.text = [NSString stringWithFormat:@"%@",name];
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults]valueForKey:@"image"];
    
    if (![str  isEqual: @""] || str != nil)
    {
        [self.ImgProfile sd_setImageWithURL:[NSURL URLWithString:str]
                              placeholderImage:[UIImage imageNamed:@"ic_user_icon.png"]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         
                                     }];
    }
    
    if ([type isEqualToString:@"Uber"])
    {
        StrRoleType =@"Uber";
        _Img_btn_Uber.image =[UIImage imageNamed:@"checked.png"];
        _Img_Btn_Lyft.image =[UIImage imageNamed:@"check.png"];
        _Img_btn_both.image =[UIImage imageNamed:@"check.png"];
        _allToggleImage.image =[UIImage imageNamed:@"check.png"];
    }
    else if ([type isEqualToString:@"Both"])
    {
        StrRoleType =@"Both";
        _Img_btn_Uber.image =[UIImage imageNamed:@"check.png"];
        _Img_Btn_Lyft.image =[UIImage imageNamed:@"check.png"];
        _Img_btn_both.image =[UIImage imageNamed:@"checked.png"];
        _allToggleImage.image =[UIImage imageNamed:@"check.png"];
    }
    else if ([type isEqualToString:@"Lyft"])
    {
        StrRoleType =@"Lyft";
        _Img_btn_Uber.image =[UIImage imageNamed:@"check.png"];
        _Img_Btn_Lyft.image =[UIImage imageNamed:@"checked.png"];
        _Img_btn_both.image =[UIImage imageNamed:@"check.png"];
        _allToggleImage.image =[UIImage imageNamed:@"check.png"];
    }
    else
    {
         StrRoleType =@"All";
        _Img_btn_Uber.image =[UIImage imageNamed:@"check.png"];
        _Img_Btn_Lyft.image =[UIImage imageNamed:@"check.png"];
        _Img_btn_both.image =[UIImage imageNamed:@"check.png"];
        _allToggleImage.image =[UIImage imageNamed:@"checked.png"];
        [[NSUserDefaults standardUserDefaults] setObject:@"All" forKey:@"type"];
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ActionLyftBtn:(id)sender
{
    [self hideMenuOnClick];
    StrRoleType =@"Lyft";
    _Img_btn_Uber.image =[UIImage imageNamed:@"check.png"];
    
     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"zoom"];
    _Img_Btn_Lyft.image =[UIImage imageNamed:@"checked.png"];
    _Img_btn_both.image =[UIImage imageNamed:@"check.png"];
    _allToggleImage.image =[UIImage imageNamed:@"check.png"];
    [[NSUserDefaults standardUserDefaults] setObject:@"Lyft" forKey:@"type"];
   
    [self notificationCenter];

}

- (IBAction)ActionBothBtn:(id)sender
{
    [self hideMenuOnClick];
    StrRoleType =@"Both";
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"zoom"];
    
    _Img_btn_Uber.image =[UIImage imageNamed:@"check.png"];
    _Img_Btn_Lyft.image =[UIImage imageNamed:@"check.png"];
    _Img_btn_both.image =[UIImage imageNamed:@"checked.png"];
    _allToggleImage.image =[UIImage imageNamed:@"check.png"];
    [[NSUserDefaults standardUserDefaults] setObject:@"Both" forKey:@"type"];
    
    [self notificationCenter];

}

- (IBAction)ActionMessage:(id)sender
{
    ChatInboxViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatInboxViewController"];

    [self presentViewController:VC animated:NO
                     completion:nil];
    
//    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
//    ChatInboxViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatInboxViewController"];
//    navigationController.viewControllers = @[VC];
//    self.frostedViewController.contentViewController = navigationController;
//    [self.frostedViewController hideMenuViewController];
    
    
}

- (IBAction)ActionShareBtn:(id)sender
{
    NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
    NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)ActionPrivacyBtn:(id)sender
{
    PrivacyPolicyViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPolicyViewController"];
    VC.headTitle = @"Privacy Policy";
    VC.privacy = YES;
    [self presentViewController:VC animated:NO
                     completion:nil];
}
#pragma MARK:- UPDATE STATUS API


- (IBAction)ActionLogout:(id)sender
{
    
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    
    
    NSString *userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"http://54.149.39.72/rideal/index.php/webservice/updateStatus?userId=%@&status=0",userID];
    
    NSLog(@"%@",url);
    NSString *feedStr = [NSString stringWithFormat:@"%@",url];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    manager.requestSerializer.timeoutInterval = 10;
    
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    
    
    [manager POST:feedStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",[responseObject description]);
        
        
        NSLog(@"JSON: %@", responseObject);
        
        //         NSString * message = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"message"]];
        NSString *message = [responseObject valueForKey:@"message"];
        [hud hideAnimated:YES];
        if ([message containsString:@"Offline"])
        {
            
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isLogin"];
            
            [self dismissViewControllerAnimated:NO completion:nil];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            ViewController *VC = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            [hud hideAnimated:YES];
            [self presentViewController:VC animated:NO
                             completion:nil];
            
        }
        

        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
         [hud hideAnimated:YES];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Try again" preferredStyle:UIAlertControllerStyleAlert];
        
       
        
        UIAlertAction* Ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:Ok];
       
        [self presentViewController:alertController animated:YES completion:nil];
        
    }];
}

- (IBAction)allBtnAction:(id)sender
{
    
    [self hideMenuOnClick];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"zoom"];
    StrRoleType =@"All";
    _Img_btn_Uber.image =[UIImage imageNamed:@"check.png"];
    _Img_Btn_Lyft.image =[UIImage imageNamed:@"check.png"];
    _Img_btn_both.image =[UIImage imageNamed:@"check.png"];
    _allToggleImage.image =[UIImage imageNamed:@"checked.png"];
    [[NSUserDefaults standardUserDefaults] setObject:@"All" forKey:@"type"];
    
     [self notificationCenter];
}
- (IBAction)grabImage:(id)sender
{
    [self presentModalViewController:self.imgPicker animated:YES];
}

#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    self.ImgProfile.image = image;
    
    [self uploadPhoto:self.ImgProfile.image];
    
    
    
    [self dismissModalViewControllerAnimated:YES];
}


-(void)uploadPhoto :(UIImage *)img
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    

    NSString *userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    
    NSData *dataImg = UIImageJPEGRepresentation(img, 0.4f);
    
     
    
        NSString *basePath =[NSString stringWithFormat:@"http://54.149.39.72/rideal/index.php/webservice/profile?userId=%@",userID];
        NSLog(@"basePath %@",basePath);
        NSURL *url = [NSURL URLWithString:basePath];
      /*  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSData *imageData = dataImg;
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        //  UIImage *image=profileImg.image;
        
        // NSData *imageData =UIImageJPEGRepresentation(image, 0.1);
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@.jpg\"\r\n",@"profile"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];*/
    
   /*
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes;
    
    
    
    
    
        AFHTTPRequestSerializer *requestOperation = [[AFHTTPRequestSerializer alloc]initWithRequest:request];
        
        requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
        requestOperation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = responseObject;
            NSLog(@"dict upload PHoto  -- %@",dict);
           
            [[NSUserDefaults standardUserDefaults]setValue:[dict valueForKey:@"data"] forKey:@"image"];
            
            if ([[responseObject valueForKey:@"response"] intValue] == 1)
            {
                
                [self ShowAlertOK:[responseObject valueForKey:@"message"]];
                [hud hideAnimated:YES];
                [self saveImage:self.ImgProfile.image filename:[NSString stringWithFormat:@"%@mypic",userID]];
            }
            else
            {
                 [self ShowAlertOK:@"Try Again"];
                 [hud hideAnimated:YES];
                 self.ImgProfile.image = [UIImage imageNamed:@"ic_user_icon.png"];
            }
        }
            failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
     
        
        self.ImgProfile.image = [UIImage imageNamed:@"ic_user_icon.png"];
        
                 [hud hideAnimated:NO];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed!"  message:@"Please try again..."  delegate:nil  cancelButtonTitle:@"OK"  otherButtonTitles:nil];
                                                    [alert show];
                                                    
                                                }];
        
        [[NSOperationQueue mainQueue]addOperation:requestOperation];*/
    
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
////        manager.responseSerializer.acceptableContentTypes = @"text/html";
//    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url];
//
//    
//    
//    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
//    manager1.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
//    
//    
//   
//    
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:basePath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        [formData appendPartWithFileData:dataImg name:@"image" fileName:@"profile.jpg" mimeType:@"image/jpeg"];
//        
//       
//    } error:nil];
//
//    
//    
//    
// 
//    
//    
//    
//    NSURLSessionUploadTask *uploadTask;
//    uploadTask = [manager
//                  uploadTaskWithStreamedRequest:request
//                  progress:^(NSProgress * _Nonnull uploadProgress) {
//                      // This is not called back on the main queue.
//                      // You are responsible for dispatching to the main queue for UI updates
//                      dispatch_async(dispatch_get_main_queue(), ^{
//                          //Update the progress view
//                         
//                      });
//                  }
//                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                      if (error)
//                      {
//                          NSLog(@"%@",error.localizedDescription);
//                          NSLog(@"%@",error.localizedFailureReason);
//                          NSLog(@"%@",error.recoveryAttempter);
//                          NSLog(@"%@",error.localizedRecoveryOptions);
//                          NSLog(@"%@",error.localizedRecoverySuggestion);
//
//                          
//                          [self ShowAlertOK:@"Try Again"];
//                          [hud hideAnimated:YES];
//                          self.ImgProfile.image = [UIImage imageNamed:@"ic_user_icon.png"];
//                          
//                      } else
//                      {
//                          if ([[responseObject valueForKey:@"response"] intValue] == 1)
//                          {
//                              
//                              [self ShowAlertOK:[responseObject valueForKey:@"message"]];
//                              [hud hideAnimated:YES];
//                              [self saveImage:self.ImgProfile.image filename:[NSString stringWithFormat:@"%@mypic",userID]];
//                          }
//                          else
//                          {
//                              [self ShowAlertOK:@"Try Again"];
//                              [hud hideAnimated:YES];
//                              self.ImgProfile.image = [UIImage imageNamed:@"ic_user_icon.png"];
//                          }
//  
//                      }
//                  }];
//    
//    [uploadTask resume];
    
    
    
    
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:basePath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:dataImg name:@"image" fileName:@"filename.jpeg" mimeType:@"text/html" ];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                          
                                                    if ([[responseObject valueForKey:@"response"] intValue] == 1)
                                                    {
                          
                                                        [self ShowAlertOK:[responseObject valueForKey:@"message"]];
                                                        [hud hideAnimated:YES];
                                                        [self saveImage:self.ImgProfile.image filename:[NSString stringWithFormat:@"%@mypic",userID]];
                                                    }
                                                    else
                                                    {
                                                        [self ShowAlertOK:@"Try Again"];
                                                        [hud hideAnimated:YES];
                                                        self.ImgProfile.image = [UIImage imageNamed:@"ic_user_icon.png"];
                                                    }
                          
                          
                      }
                  }];
    
    [uploadTask resume];
    
   }

-(void)saveImage : (UIImage *)image filename:(NSString *)filename
{
    //    UIImage *image = [UIImage imageNamed:@"Image.jpg"];
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    
    NSLog(@"%@",stringPath);
    // New Folder is your folder name
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [data writeToFile:filename atomically:YES];
}


- (IBAction)ActionUberBtn:(id)sender
{
    
    [self hideMenuOnClick];
    StrRoleType =@"Uber";
     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"zoom"];
    _Img_btn_Uber.image =[UIImage imageNamed:@"checked.png"];
    _Img_Btn_Lyft.image =[UIImage imageNamed:@"check.png"];
    _Img_btn_both.image =[UIImage imageNamed:@"check.png"];
    _allToggleImage.image =[UIImage imageNamed:@"check.png"];
    [[NSUserDefaults standardUserDefaults] setObject:@"Uber" forKey:@"type"];
   
    [self notificationCenter];

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

-(void)notificationCenter
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"setValue"
     object:self];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"zoom"
     object:self];
    
    
    
}

-(void)hideMenuOnClick
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"hideMenu"
     object:self];
}


@end
