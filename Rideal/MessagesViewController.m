//
//  MessagesViewController.m
//  Rideal
//
//  Created by OSX on 05/09/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessageViewCell.h"
#import "AFNetworking.h"

@interface MessagesViewController ()
{
    CGSize keyboardSize;
}
@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _nameLbl.text = [NSString stringWithFormat:@"%@",_name];
    
    i =0;
    
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                             target: self
                                           selector:@selector(updateChat:)
                                           userInfo: nil repeats:YES];
    
   
    
    _messageTxtField.delegate = self;
    
    _messageTxtField.layer.cornerRadius = 5.0;
    _messageTxtField.layer.masksToBounds = true;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _messageTxtField.leftView = paddingView;
    _messageTxtField.leftViewMode = UITextFieldViewModeAlways;
    
    _messageTableView.separatorColor = [UIColor clearColor];
    
    _messageTableView.backgroundColor = [UIColor colorWithRed:0.9333333333 green:0.9333333333 blue:0.9333333333 alpha:1.0];
    
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

//     [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
    [_messageTableView reloadData ];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    if(i==0)
    {
        i++;
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [timer invalidate];
}

-(void)updateChat:(NSTimer*)timer
{
    
        //        [hud hideAnimated:YES];
         [self getAllChat:_friendID];
        
        
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma MARK:- keyboard observer

-(void)keyboardDidShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
}

-(void)keyboardDidHide:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    NSLog(@"keyboard height%f",keyboardSize);
    
    [self restoreViewFrameOrigionYToZero];// keyboard is dismissed, restore frame view to its  zero origin
}


-(void) restoreViewFrameOrigionYToZero
{
    
    CGFloat keyboardHeight = keyboardSize.height;
    
    _messageTableView.frame = CGRectMake(0, _messageTableView.frame.origin.y + keyboardHeight,self.view.frame.size.width,_messageTableView.frame.size.height);
    
    _messageWrapperView.frame = CGRectMake(0, _messageWrapperView.frame.origin.y + keyboardHeight, self.view.frame.size.width, _messageWrapperView.frame.size.height);
}


#pragma MARK-: Touch Events

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_messageTxtField resignFirstResponder];
}


#pragma MARK:- UITextFieldDelegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _messageTxtField)
    {
        CGFloat keyboardHeight = keyboardSize.height;
        
        _messageTableView.frame = CGRectMake(0, _messageTableView.frame.origin.y - 216,self.view.frame.size.width,_messageTableView.frame.size.height);
        
        _messageWrapperView.frame = CGRectMake(0, _messageWrapperView.frame.origin.y - 216, self.view.frame.size.width, _messageWrapperView.frame.size.height);
    }
    
    
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _messageTxtField)
    {
        CGFloat keyboardHeight = keyboardSize.height;
        
        _messageTableView.frame = CGRectMake(0, _messageTableView.frame.origin.y + 216,self.view.frame.size.width,_messageTableView.frame.size.height);
        
        _messageWrapperView.frame = CGRectMake(0, _messageWrapperView.frame.origin.y + 216, self.view.frame.size.width, _messageWrapperView.frame.size.height);
    }
    
    return YES;
}



#pragma MARK:-tableview DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame;
    //  set the height here, According to the NSArray of text
    UITextView *tempTxtView = [[UITextView alloc] init];
    tempTxtView.frame = CGRectMake(0, 0, self.view.frame.size.width/2.4, 20);
    
    tempTxtView.text = [NSString stringWithFormat:@"%@",[messageData[indexPath.row] valueForKey:@"message"]];// Add the Text of index according to the Section
    
    // Fit  the  UITextView to the Content
    frame = tempTxtView.frame;
    frame.size.height = tempTxtView.contentSize.height;
    tempTxtView.frame = frame;
    
    
  return frame.size.height + tempTxtView.contentSize.height;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"%lu",(unsigned long)messageData.count);
     NSLog(@"%@",messageData);
    
    return  messageData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;
    
    MessageViewCell *customeCell = [tableView dequeueReusableCellWithIdentifier:@"MessageViewCell"];
    
    
    customeCell.backgroundColor = [UIColor clearColor];
    
//    customeCell.messageTextView.text = _messageData[indexPath.row];
   
    customeCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    customeCell.textLabel.text = _messageData[indexPath.row];
    
    
    
    NSLog(@"%@",messageData[indexPath.row]);
    
    NSString *status =  [NSString stringWithFormat:@"%@",[messageData[indexPath.row] valueForKey:@"status"]];

    
    
    
    
    if ([status  isEqual: @"0"])
    {
        customeCell.wrapperView.hidden = NO;
        customeCell.senderMessageWrapperView.hidden = YES;
        customeCell.messageTextView.text = [NSString stringWithFormat:@"%@",[messageData[indexPath.row] valueForKey:@"message"]];
        
        customeCell.timeLbl.text = [NSString stringWithFormat:@"%@",[messageData[indexPath.row] valueForKey:@"timeAgo"]];
        customeCell.senderMessageWrapperView.hidden = YES;
        customeCell.wrapperView.frame = CGRectMake(customeCell.contentView.frame.origin.x + 5, customeCell.contentView.frame.origin.y + 5, self.view.frame.size.width/2.4, customeCell.contentView.frame.size.height - 5);
        customeCell.wrapperView.backgroundColor = [UIColor whiteColor];
        customeCell.messageTextView.textAlignment = NSTextAlignmentLeft;
        customeCell.wrapperView.layer.cornerRadius = 10.0;
        customeCell.wrapperView.layer.masksToBounds = YES;
        

    }
    else
    {
        customeCell.wrapperView .hidden = YES;
        
        customeCell.senderMessageWrapperView.hidden = NO;
        customeCell.senderTextView.text = [NSString stringWithFormat:@"%@",[messageData[indexPath.row] valueForKey:@"message"]];
        
        customeCell.senderTextView.frame = CGRectMake(5, 0,customeCell.senderMessageWrapperView.frame.size.width , customeCell.contentView.frame.size.height);
        
        
        customeCell.sendetTimeLbl.text = [NSString stringWithFormat:@"%@",[messageData[indexPath.row] valueForKey:@"timeAgo"]];
        
        
        
        
        NSLog(@"customeCell.sendetTimeLbl.text %f",customeCell.sendetTimeLbl.frame.size.height);
        NSLog(@"customeCell.sendetTimeLbl.text %f",customeCell.senderTextView.frame.size.height);
        
        customeCell.senderMessageWrapperView.layer.cornerRadius = 10.0;
        customeCell.senderMessageWrapperView.layer.masksToBounds = YES;
        
    }
    
    return customeCell;
}

- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)sendMessae:(id)sender
{
    BOOL blockeUsers = [[NSUserDefaults standardUserDefaults]boolForKey:_friendID];
    
    if (blockeUsers)
    {
       [self ShowAlertOK:@"Unblock this User"];
    }
    else
    {
        if (![_messageTxtField.text  isEqual: @""])
        {
            
            msg =  _messageTxtField.text;
            _messageTxtField.text = @"";
            
            [_messageTxtField resignFirstResponder];
            
            NSString *userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
            
            NSDictionary * dict = @{
                                    @"senderId":userID,
                                    @"receiverId" :_friendID,
                                    @"msg" :msg
                                    };
 
            
            
            [[DataModel sharedDataManager] Api:SEND_MESSAGE_API Data:dict withBlock:^(id response, NSError *error)
             {
                 if (error) {
                     
                     
                     
                     [self ShowAlertOK:@"Try Again.."];
                 }
                 else{
                     if ([[response valueForKey:@"response"]intValue] ==1)
                     {
                         
                         
                         
                         
                         
                         NSLog(@"%@",[response valueForKey:@"data"]);
                         
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
    
    
    
    
//    [messageData insertObject:_messageTxtField.text atIndex:messageData.count];
//    [_messageTableView reloadData ];
//    
    
    
}

- (IBAction)blockUser:(id)sender
{
    
    [timer invalidate];
    
    
     BOOL blockeUsers = [[NSUserDefaults standardUserDefaults]boolForKey:_friendID];
    
    NSString *title = [NSString stringWithFormat:@"Unblock This User"];
    NSString *otherButtonTitle = [NSString stringWithFormat:@"Unblock"];
    if (!blockeUsers)
    {
        otherButtonTitle = [NSString stringWithFormat:@"Block"];
        title = [NSString stringWithFormat:@"Block this user"];
    }
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:otherButtonTitle
                           ,
                           nil];
    popup.tag = 1;
    [popup showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    BOOL blockeUsers = [[NSUserDefaults standardUserDefaults]boolForKey:_friendID];
    
    
    
 
    
    NSLog(@"%ld",(long)buttonIndex);
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    if (!blockeUsers)
                   {
                       [self blockUserApi:@"0"];
                    }
                    else
                    {
                        [self blockUserApi:@"1"];
                    }
                 
                    
                    
                    break;
                default:
                    timer = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                                             target: self
                                                           selector:@selector(updateChat:)
                                                           userInfo: nil repeats:YES];
                    
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    
    
}

#pragma MARK:- Block User Api
-(void)blockUserApi :(NSString *)status
{
    NSString *userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    
    NSString *str = [NSString stringWithFormat:@"http://54.149.39.72/rideal/index.php/webservice/blockChat?userId=%@&friendId=%@&status=%@",userID,_friendID,status];
    
    NSURL *url = [NSURL URLWithString:str];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *e = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonArray)
    {
        NSLog(@"Error parsing JSON: %@", e);
    } else
    {
       NSString *str = [jsonArray valueForKey:@"message"];
        
        if ([str isEqualToString:@"Blocked succesfully!!"])
        {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:_friendID];
            
        }
        else
        {
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:_friendID];
            
            [_messageTxtField resignFirstResponder];
            
            timer = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                                     target: self
                                                   selector:@selector(updateChat:)
                                                   userInfo: nil repeats:YES];

        }
        
    }
    
    
    
    
    
    
//    NSDictionary * dict = @{
//                            @"userId":userID,
//                            @"friendId" :@"12",
//                            @"status" :status                           
//                            };
//    
//    
//    [[DataModel sharedDataManager] Api:BLOCK_CHAT_USER Data:dict withBlock:^(id response, NSError *error)
//     {
//         if (error) {
//             
//             [hud hideAnimated:YES];
//             
//             [self ShowAlertOK:@"Try Again.."];
//         }
//         else{
//             if ([[response valueForKey:@"response"]intValue] ==1)
//             {
//                 [hud hideAnimated:YES];
//                 
//                 
//                 NSLog(@"%@",[response valueForKey:@"data"]);
//                 
//             }
//             else
//             {
//                 [hud hideAnimated:YES];
//                 [self ShowAlertOK:[response valueForKey:@"message"]];
//             }
//             
//         }
//         
//     }];

}


-(void)getAllChat :(NSString *)friendId
{
   
    
    
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    NSString *userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    
    NSDictionary * dict =  @{
                            @"userId":userID,
                            @"friendId" :friendId
                            };
    
    
    [[DataModel sharedDataManager] Api:GET_ALL_CHAT Data:dict withBlock:^(id response, NSError *error)
     {
         if (error) {
             
             [hud hideAnimated:YES];
             
//             [self ShowAlertOK:@"Try Again.."];
         }
         else{
             if ([[response valueForKey:@"response"]intValue] == 1)
             {
                 
                 
                 
                 
                 messageData = [[NSMutableArray alloc]init];
                 [hud hideAnimated:YES];
                 
                 
                 messageData = [[[response valueForKey:@"data"] valueForKey:@"chatting"] mutableCopy];
                 NSLog(@"%@",messageData);
                 
                 
                 
                 
                 
                 
                 int count = 0;
                 
                 [_messageTableView reloadData];
                 //                 if (previousData.count != messageData.count)
//                 {
//                     //
//                 }
                 
                 if (messageData.count > 5 && previousData != messageData.count)
                 {
                     
                     NSIndexPath *index = [NSIndexPath indexPathForRow:messageData.count-1 inSection:0];
//
                     [self.messageTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                     
                     
                     
//                     [self.messageTableView setContentOffset:CGPointMake(0, CGFLOAT_MAX) animated: YES];
 
                 }
                 NSLog(@"%@",messageData);

                 
//                 previousData = messageData;
                 
                 
                 int j = 0;
                 for (id d in messageData)
                 {
                     NSLog(@"d%@",d);
                     j++;
                 }
                 
                  count = j;
                 previousData = count;
                 
             }
             else
             {
                 
                  [self getAllChat:friendId];
                 
             }
             
         }
         

         
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


@end
