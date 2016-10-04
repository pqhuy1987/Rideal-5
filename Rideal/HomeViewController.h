//
//  HomeViewController.h
//  Rideal
//
//  Created by OSX on 25/08/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MBProgressHUD.h"
@interface HomeViewController : UIViewController<CLLocationManagerDelegate,GMSMapViewDelegate>
{
    GMSMapView *googlMapView;
    GMSMarker *iconMarker;
     MBProgressHUD *hud;
    NSTimer *timer;
    NSMutableArray *driversLocation;
     NSMutableArray *previousData;
    NSString *selectedId;
     UIView *view;
    NSString *name;
    NSString *driverId;
    int prevoiusId;
     
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIView *ViewMap;
@property (weak, nonatomic) IBOutlet UISwitch *toggleBtn;



- (IBAction)swicthBtn:(id)sender;

@end
