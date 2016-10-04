//
//  ChatInboxViewController.m
//  Rideal
//
//  Created by OSX on 30/08/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import "ChatInboxViewController.h"
#import "ChatInboxCustomCell.h"
#import "MessagesViewController.h"
@interface ChatInboxViewController ()

@end

@implementation ChatInboxViewController
@synthesize tblView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    tblView.hidden=YES;
    [self getAllInbox ];
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)cmdHomeBtn:(id)sender
{
    
}

- (IBAction)backBTn:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark -
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return inboxData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;
    
    ChatInboxCustomCell *customeCell = [tableView dequeueReusableCellWithIdentifier:@"ChatInboxCustomCell"];
    
    double t = customeCell.nameTitle.frame.size.height + customeCell.messageTime.frame.size.height;
    
     CGFloat width = (CGFloat)t;
    
    NSString *name = [inboxData[indexPath.row] valueForKey:@"name"];
    
    
    name = [[name substringToIndex:NSMaxRange([name rangeOfComposedCharacterSequenceAtIndex:0])] uppercaseString];
    
    customeCell.nameTitle.text = name;
    
    customeCell.nameLbl.text = [NSString stringWithFormat:@"%@",[inboxData[indexPath.row]valueForKey:@"name"]];
    
    NSString *myString = [NSString stringWithFormat:@"%@",[inboxData[indexPath.row]valueForKey:@"last_msg_time"]];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:locale];
    NSDate *yourDate = [dateFormatter dateFromString:myString];
    dateFormatter.dateFormat = @"dd-MMMM-yyyy";
    
    
    NSLog(@"%@",[dateFormatter stringFromDate:yourDate]);
    
    
    NSString *myStringDate = [dateFormatter stringFromDate:yourDate];
    
   myStringDate = [myStringDate stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    
    customeCell.messageTime.text = [NSString stringWithFormat:@"Last Message - %@",myStringDate];
    
//    customeCell.messageTime.text = [NSString stringWithFormat:@"%@",ts_local_string];
    
    customeCell.nameTitle.layer.cornerRadius = customeCell.nameTitle.frame.size.width/2;
    customeCell.nameTitle.layer.masksToBounds = YES;
    customeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return customeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessagesViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    VC.name = [inboxData[indexPath.row] valueForKey:@"name"];
    VC.friendID = [inboxData[indexPath.row] valueForKey:@"friendId"];
    [self presentViewController:VC animated:NO
                     completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getAllInbox
{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    

    
    NSDictionary * dict = @{
                            @"userId":userID,
                            };
    
    
    [[DataModel sharedDataManager] Api:INBOX_CHAT Data:dict withBlock:^(id response, NSError *error)
     {
         if (error) {
             
             [hud hideAnimated:YES];
             
             [self ShowAlertOK:@"Please try again later..."];
         }
         else{
             if ([[response valueForKey:@"response"]intValue] ==1)
             {
                 [hud hideAnimated:YES];

                 NSLog(@"Chat inbox api %@",[response valueForKey:@"data"]);
                 
                 inboxData = [[NSMutableArray alloc]init];
                 
                 inboxData = [response valueForKey:@"data"];
                 [tblView reloadData];
                 tblView.hidden=NO;
                 
                 
             }
             else
             {
                 [hud hideAnimated:YES];
                 
                  [self ShowAlertOK:@"No data found..."];
                 
                 if ([[response valueForKey:@"message"] isEqualToString:@"0"])
                 {
                     
                 }
                 
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



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if  ([buttonTitle isEqualToString:@"Block"])
    {
        NSLog(@"Destructive pressed --> Delete Something");
    }
    if ([buttonTitle isEqualToString:@"Cancel"])
    {
        NSLog(@"Other 1 pressed");
    }
    
    
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
