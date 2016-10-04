//
//  HomeViewController.m
//  Rideal
//
//  Created by OSX on 25/08/16.
//  Copyright © 2016 Orem. All rights reserved.
//

#import "HomeViewController.h"
#import "DataModel.h"
#import "PrefixHeader.pch"
#import <CoreLocation/CoreLocation.h>
#import "InfoWindow.h"
#import "MessagesViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@import CoreLocation;

static int z = 0;
static int y = 0;
static int rr = 0;


@interface HomeViewController ()
{
    int i;
     GMSCoordinateBounds *allBounds;
     GMSCoordinateBounds *UberBounds;
     GMSCoordinateBounds *lyftBounds;
     GMSCoordinateBounds *bothBounds;
    
}
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    
    
    [self notificationcenter];
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    
    allBounds = [[GMSCoordinateBounds alloc]init];
    UberBounds = [[GMSCoordinateBounds alloc]init];
    lyftBounds = [[GMSCoordinateBounds alloc]init];
    bothBounds = [[GMSCoordinateBounds alloc]init];
    
//     previousData = [[NSMutableArray alloc]init];
//    
//    googlMapView = [[GMSMapView alloc]init];
//    
//    googlMapView.frame = self.view.bounds;
//
//    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:30.7046
//                                                            longitude:76.7179
//                                                                 zoom:13];
//    googlMapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.ViewMap.frame.size.width, self.ViewMap.frame.size.height) camera:camera];
//    googlMapView.myLocationEnabled = YES;
//    googlMapView.delegate = self;
//    [self.ViewMap addSubview:googlMapView];
    
    
    [super viewDidLoad];
   
    
    // Do any additional setup after loading the view.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    
    if (z == 0)
    {
        z++;
        CLLocation * currentLocation = [locations lastObject];
        
        
//        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.5505623
//                                                                longitude:121.7203213
//                                                                     zoom:13];
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currentLocation.coordinate.latitude
                                                                longitude:currentLocation.coordinate.longitude
                                                                     zoom:13];
        googlMapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.ViewMap.frame.size.width, self.ViewMap.frame.size.height) camera:camera];
        googlMapView.myLocationEnabled = YES;
        googlMapView.delegate = self;
        [self.ViewMap addSubview:googlMapView];
    }
    
    
    
}



-(void)updateLocation:(NSTimer*)timer
{
    if(_toggleBtn.on)
    {
//        [hud hideAnimated:YES];
        
        if([CLLocationManager locationServicesEnabled]&&
           [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
        {
            [self updateLocationAPI];
        }
        else
        {
            
            
            
            [self alertSetting ];
            
            
            
            if (y == 0)
            {
                y++;
                
                GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.741895
                                                                        longitude:73.989308
                                             
                                                                             zoom:0];
                googlMapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.ViewMap.frame.size.width, self.ViewMap.frame.size.height) camera:camera];
                 googlMapView.delegate = self;
                [self.ViewMap addSubview:googlMapView];
                
            }
        }
        
        
        
        
    }
    else
    {
        [googlMapView clear];
//        [previousData removeAllObjects];
        
    }
}

-(void)alertSetting
{
    if (rr == 0)
        {
            rr++;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please Enable your location for further use" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* Settings = [UIAlertAction actionWithTitle:@"Go to Setting" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                       {
                                           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                       }];
            
            UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:Cancel];
            [alertController addAction:Settings];
            
            [self presentViewController:alertController animated:YES completion:nil];

        }
    
   }

- (void)MapLoadView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    
    _locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
   
    i = 0;
    
    [_locationManager startUpdatingLocation];
    
}

- (void)viewWillAppear:(BOOL)animated
{
  
    previousData = [[NSMutableArray alloc]init];
    
    googlMapView = [[GMSMapView alloc]init];
    
    googlMapView.frame = self.view.bounds;

    
    NSDictionary *StatusDict = [[NSUserDefaults standardUserDefaults]objectForKey:@"Status_Response"];
    NSString *strStatus = [StatusDict valueForKey:@"status"];
    
    if ([strStatus isEqualToString:@"Offline"])
    {
        [_toggleBtn setOn:NO animated:YES];
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"status"];
    }
    else
    {
        [_toggleBtn setOn:YES animated:YES];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"status"];
    }
   
    BOOL status = [[NSUserDefaults standardUserDefaults]boolForKey:@"status"];
    
    if (status)
    {
        if([CLLocationManager locationServicesEnabled]&&
           [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
        {
            [self updateLocationAPI];
        }
        else
        {
            if (y == 0)
            {
                y++;
                
                GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.741895
                                                                        longitude:73.989308
                                             
                                                                             zoom:0];
                googlMapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.ViewMap.frame.size.width, self.ViewMap.frame.size.height) camera:camera];
                
                [self.ViewMap addSubview:googlMapView];
            }
        }
        
        
    }
    
    [self.view bringSubviewToFront:_btnMenu];
    [self MapLoadView];
    
    timer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                             target: self
                                           selector:@selector(updateLocation:)
                                           userInfo: nil repeats:YES];

    googlMapView.delegate = self;
    
    z = 0;
    
}



-(void)viewDidDisappear:(BOOL)animated
{
    [timer invalidate];
}

-(void)movemarker:(double)longitude latitude:(double)latitude marker:(GMSMarker*)marker
{
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    [CATransaction commit];
}

- (IBAction)cmdMenuBtn:(id)sender
{
    // Dismiss keyboard (optional)
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swicthBtn:(id)sender
{
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"status"];
//       [previousData removeAllObjects];
        [self updateStatusAPI:@"1"];
        
        if([CLLocationManager locationServicesEnabled]&&
           [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
        {
                [self updateLocationAPI];
        }
        else
        {
            if (y == 0)
            {
                y++;
                
                GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.741895
                                                                        longitude:73.989308
                                             
                                                                             zoom:0];
                googlMapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.ViewMap.frame.size.width, self.ViewMap.frame.size.height) camera:camera];
                
                [self.ViewMap addSubview:googlMapView];
            }
        }
        
       
    }
    else
    {
       
        [self updateStatusAPI:@"0"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"status"];
        [googlMapView clear];
//        NSLog(@"prev%lu",(unsigned long)previousData.count);
        
    }
    
    selectedId = nil;
    
}


#pragma MARK:- UPDATE STATUS API

-(void)updateStatusAPI:(NSString*)status
{
//    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    
    NSString *userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    
    NSDictionary * dict = @{
                            @"userId": userID,
                            @"status": status
                            };
    
    [[DataModel sharedDataManager] Api:UPDATE_STATUS_API Data:dict withBlock:^(id response, NSError *error)
     {
         if (error !=  nil)
         {
             
             
             [self ShowAlertOK:@"Try Again.."];
         }
         else
         {
             NSLog(@"%@",response);
             
            
             
         }
     }];

}


#pragma MARK:- GET_STATUS_API

-(void)GetStatusApi
{

    
    
    NSString *userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    
    NSDictionary * dict = @{
                            @"userId": userID
                            };
    
    
    [[DataModel sharedDataManager] Api:GET_STATUS_API Data:dict withBlock:^(id response, NSError *error)
     {
         if (error !=  nil)
         {
             [hud hideAnimated:YES];
             
             [self ShowAlertOK:@"Try Again.."];
         }
         else
         {
             NSLog(@"%@",response);
             
             NSString *status = [response valueForKey:@"status"];
             
             if ([status isEqualToString:@"Offline"])
             {
                 [_toggleBtn setOn:NO animated:YES];
                 
                 [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"status"];
             }
             else
             {
                  [_toggleBtn setOn:YES animated:YES];
                  [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"status"];
             }
             
             
             [hud hideAnimated:YES];
             
         }
     }];

}

#pragma MARK:- UPDATE_LOCATION_API

-(void)updateLocationAPI
{
    
    float Lat;
    float Long;
    GMSCoordinateBounds *bounds;

    
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
        Lat = _locationManager.location.coordinate.latitude;
        Long = _locationManager.location.coordinate.longitude;
    
    NSString *userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    
    NSDictionary * dict = @{
                            @"userId": userID,
                            @"lat":[NSString stringWithFormat:@"%f",Lat],
                            @"lng":[NSString stringWithFormat:@"%f",Long]
                            };
//
//    NSDictionary * dict = @{
//                            @"userId": userID,
//                            @"lat":@"38.5505623",
//                            @"lng":@"-121.7203213"
//                           };
    
    [[DataModel sharedDataManager] Api:UPDATE_LOCATION_API Data:dict withBlock:^(id response, NSError *error)
     {
         if (error !=  nil)
         {
             
             NSLog(@"error");
         }
         else
         {
             NSLog(@"%@",response);
             
             driversLocation = [[NSMutableArray alloc]init ];
             
             driversLocation = [response valueForKey:@"data"];
             
             NSMutableArray *removableIds = [[NSMutableArray alloc]init];
             
              GMSCoordinateBounds *bounds;
             
             BOOL isAnimate;
             BOOL isConatinIds = NO;
             int markerIndex = 0;
             
             NSString *Filtertype = [[NSUserDefaults standardUserDefaults]valueForKey:@"type"];
             
            [googlMapView clear];
             
             
              bounds = [[GMSCoordinateBounds alloc]init];
             
             if (previousData.count > 0)
             {
                for (NSDictionary *previusDict in previousData )
                {
                    for (int y = 0; y < driversLocation.count; y++)
                    {
                         if ([[driversLocation[y] valueForKey:@"id"] isEqualToString:[previusDict valueForKey:@"id"]])
                         {
                            isConatinIds = YES;
                            markerIndex = y;
                            break;
                         }
                    }
                        if (isConatinIds)
                        {
                            
                            NSString *type = [previusDict valueForKey:@"type"];
                            NSString *image;
                            double latitude = [[previusDict valueForKey:@"latitude"] doubleValue];
                            double longitude = [[previusDict valueForKey:@"longitude"] doubleValue];
                            
                             iconMarker = [[GMSMarker alloc] init];
                            
                             iconMarker.accessibilityLabel = [NSString stringWithFormat:@"%@",[previusDict valueForKey:@"id"]];
                            
                            
                            if ([type isEqualToString:Filtertype])
                            {
                            
                               
                                
                               
                                
                                iconMarker.map = googlMapView;
                                
                                iconMarker.position = CLLocationCoordinate2DMake(latitude, longitude);
                                
                                if ([type  isEqual: @"Uber"])
                                {
                                    image = UBER;
                                   
 
                                    bounds = [bounds includingCoordinate:iconMarker.position];
                                    UberBounds = [bounds includingCoordinate:iconMarker.position];
                                    NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
                                    NSData *imageData = [NSData dataWithContentsOfFile:path];
                                    
                                    iconMarker.icon = [UIImage imageWithData:imageData scale:3.0];
                                }
                                if ([type  isEqual: @"Lyft"])
                                {
                                    image = LYFT;
                                   

                                    bounds = [bounds includingCoordinate:iconMarker.position];
                                    lyftBounds = [bounds includingCoordinate:iconMarker.position];
                                    NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
                                    NSData *imageData = [NSData dataWithContentsOfFile:path];
                                    
                                    iconMarker.icon = [UIImage imageWithData:imageData scale:3.0];
                                    
                                }
                                if ([type  isEqual: @"Both"])
                                {
                                    image = BOTH;
                                    
                                   
                                    
                                    bounds = [bounds includingCoordinate:iconMarker.position];
                                    bothBounds = [bounds includingCoordinate:iconMarker.position];
                                    NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
                                    NSData *imageData = [NSData dataWithContentsOfFile:path];
                                    
                                    iconMarker.icon = [UIImage imageWithData:imageData scale:3.0];
                                }
                                
                                
                                
                                
                                
                               
                                
                                
                                if ([selectedId isEqualToString:[previusDict valueForKey:@"id"]])
                                {
                                    
                                    [googlMapView setSelectedMarker:iconMarker];
                                    
                                }
                                
                                if (([previusDict valueForKey:@"latitude"] != [driversLocation[markerIndex] valueForKey:@"latitude"] || [previusDict valueForKey:@"longitude"] != [driversLocation[markerIndex] valueForKey:@"longitude"])
                                    && [previusDict valueForKey:@"id"] == [driversLocation[markerIndex] valueForKey:@"id"] )
                                {
                                    NSLog(@"%@",previusDict);
                                    NSLog(@"%@",driversLocation[markerIndex]);
                                    
                                    
                                    iconMarker.position = CLLocationCoordinate2DMake(latitude, longitude);
                                    
                                    
                                    double lat = [[driversLocation[markerIndex] valueForKey:@"latitude"] doubleValue];
                                    double longi = [[driversLocation[markerIndex] valueForKey:@"longitude"] doubleValue];
                                    
                                    [self movemarker:longi latitude:lat marker:iconMarker];
                                    
                                }
                                else
                                {
                                    double lat = [[previusDict valueForKey:@"latitude"] doubleValue];
                                    double longi = [[previusDict valueForKey:@"longitude"] doubleValue];
                                    isAnimate = YES;
                                    iconMarker.position = CLLocationCoordinate2DMake(lat, longi);
                                }

                                

                            }
                            else
                            {
                                
                                if ([Filtertype isEqualToString:@"All"])
                                {
                                    
                                    NSString *type = [previusDict valueForKey:@"type"];
                                    NSString *image;
                                    
                                    double latitude = [[previusDict valueForKey:@"latitude"] doubleValue];
                                    double longitude = [[previusDict valueForKey:@"longitude"] doubleValue];
                                    
                                    
                                    
                                    iconMarker = [[GMSMarker alloc] init];
                                    
                                    
                                    iconMarker.map = googlMapView;
                                    
                                    iconMarker.position = CLLocationCoordinate2DMake(latitude, longitude);
                                    
                                    iconMarker.accessibilityLabel = [NSString stringWithFormat:@"%@",[previusDict valueForKey:@"id"]];
                                    
                                    
                                    if ([Filtertype isEqualToString:@"All"])
                                    {
                                        if ([type  isEqual: @"Uber"])
                                        {
                                            image = UBER;
                                             UberBounds = [bounds includingCoordinate:iconMarker.position];
                                            
                                        }
                                        if ([type  isEqual: @"Lyft"])
                                        {
                                            image = LYFT;
                                             lyftBounds = [bounds includingCoordinate:iconMarker.position];
                                        }
                                        if ([type  isEqual: @"Both"])
                                        {
                                            image = BOTH;
                                             bothBounds = [bounds includingCoordinate:iconMarker.position];
                                        }
                                        bounds = [bounds includingCoordinate:iconMarker.position];
                                        
                                    }
                                    
                                   allBounds = [bounds includingCoordinate:iconMarker.position];
                                    
                                    NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
                                    NSData *imageData = [NSData dataWithContentsOfFile:path];
                                    
                                    
                                    iconMarker.icon = [UIImage imageWithData:imageData scale:3.0];
                                    
                                    iconMarker.map = googlMapView;
                                    
                                    
                                    if ([selectedId isEqualToString:[previusDict valueForKey:@"id"]])
                                    {
                                        
                                        [googlMapView setSelectedMarker:iconMarker];
                                        
                                    }
                                    
                                    if (([previusDict valueForKey:@"latitude"] != [driversLocation[markerIndex] valueForKey:@"latitude"] || [previusDict valueForKey:@"longitude"] != [driversLocation[markerIndex] valueForKey:@"longitude"])
                                        && [previusDict valueForKey:@"id"] == [driversLocation[markerIndex] valueForKey:@"id"] )
                                    {
                                        
                                        
                                        
                                        iconMarker.position = CLLocationCoordinate2DMake(latitude, longitude);
                                        
                                        
                                        double lat = [[driversLocation[markerIndex] valueForKey:@"latitude"] doubleValue];
                                        double longi = [[driversLocation[markerIndex] valueForKey:@"longitude"] doubleValue];
                                        
                                        [self movemarker:longi latitude:lat marker:iconMarker];
                                        
                                    }
                                    else
                                    {
                                        double lat = [[previusDict valueForKey:@"latitude"] doubleValue];
                                        double longi = [[previusDict valueForKey:@"longitude"] doubleValue];
                                        isAnimate = YES;
                                        iconMarker.position = CLLocationCoordinate2DMake(lat, longi);
                                    }
                                    
                                    
                                }
                 
                            }
                            
       
                            
                        }
                        else
                        {
                            [removableIds addObject:[previusDict valueForKey:@"id"]];
                            
                        }
                    
                    
                    
                }
                 
                if (removableIds.count > 0)
                 {
                     for (int w = 0; w < removableIds.count; w++)
                     {
                         int index = 0;
                         
                         for ( int b = 0 ; b < previousData.count; b++)
                         {
                             if ([removableIds[w] isEqualToString:[previousData[b] valueForKey:@"id"]])
                             {
                                 index = b;
                                 break;
                             }
                         }
                         
                         [previousData removeObjectAtIndex:index];
                         
                      }
                 }
                 
                 [removableIds removeAllObjects];
                 
                 NSMutableArray *newIds = [[NSMutableArray alloc]init];
                 
                 for (NSDictionary *newdict in driversLocation)
                 {
                     BOOL newIdAvail = NO;
                     
                     for (int w = 0; w < previousData.count; w++)
                     {
                         if ([[newdict valueForKey:@"id"] isEqualToString:[previousData[w] valueForKey:@"id"]])
                         {
                             
                             newIdAvail = YES;
                             break;
                         }
                     }
                     
                     if (!newIdAvail) {
                         
                         [newIds addObject:newdict];
                     }
                     
                 }
                 
                 
                 
                 if (newIds.count > 0)
                 {
                     for (NSDictionary *ids in newIds)
                     {
                         NSString *type = [ids valueForKey:@"type"];
                         NSString *image;
                         
                         double latitude = [[ids valueForKey:@"latitude"] doubleValue];
                         double longitude = [[ids valueForKey:@"longitude"] doubleValue];
                         
                         
                         iconMarker = [[GMSMarker alloc] init];
                         
                         iconMarker.position = CLLocationCoordinate2DMake(latitude, longitude);
                         
                         
                         iconMarker.accessibilityLabel = [NSString stringWithFormat:@"%@",[ids valueForKey:@"id"]];
                         
                         
                         if ([Filtertype isEqualToString:@"All"])
                         {
                             if ([type  isEqual: @"Uber"])
                             {
                                 image = UBER;
                             }
                             if ([type  isEqual: @"Lyft"])
                             {
                                 image = LYFT;
                             }
                             if ([type  isEqual: @"Both"])
                             {
                                 image = BOTH;
                             }
                             bounds = [bounds includingCoordinate:iconMarker.position];
                         }
                         else
                         {
                             if ([type isEqualToString:Filtertype])
                             {
                                 if ([type  isEqual: @"Uber"])
                                 {
                                     image = UBER;
                                 }
                                 if ([type  isEqual: @"Lyft"])
                                 {
                                     image = LYFT;
                                 }
                                 if ([type  isEqual: @"Both"])
                                 {
                                     image = BOTH;
                                 }
                                 bounds = [bounds includingCoordinate:iconMarker.position];
                             }
                             
                         }
                         
                         
                         
                         NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
                         NSData *imageData = [NSData dataWithContentsOfFile:path];
                         
                         
                         iconMarker.icon = [UIImage imageWithData:imageData scale:3.0];
                         
                         iconMarker.map = googlMapView;
                     }
                     

                 }
                 
                 
                 BOOL zoom = [[NSUserDefaults standardUserDefaults] boolForKey:@"zoom"];
                 
                 if (zoom)
                 {
                     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"zoom"];
                     
                     [CATransaction begin];
                     [CATransaction setValue:[NSNumber numberWithFloat: 0.8] forKey:kCATransactionAnimationDuration];
                     
                     [googlMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
                     
                     [CATransaction commit];
                 }
                 
                 
             }
             else
             {
                 
                 for (NSDictionary *newDict in driversLocation)
                 {
                     NSString *type = [newDict valueForKey:@"type"];
                     NSString *image;
                     
                     double latitude = [[newDict valueForKey:@"latitude"] doubleValue];
                     double longitude = [[newDict valueForKey:@"longitude"] doubleValue];
                     
                  
                     
                     iconMarker = [[GMSMarker alloc] init];

                     iconMarker.position = CLLocationCoordinate2DMake(latitude, longitude);
                     
                     
                     iconMarker.accessibilityLabel = [NSString stringWithFormat:@"%@",[newDict valueForKey:@"id"]];
                     
                     
                     if ([Filtertype isEqualToString:@"All"])
                     {
                         if ([type  isEqual: @"Uber"])
                         {
                             image = UBER;
                             UberBounds = [bounds includingCoordinate:iconMarker.position];
                         }
                         if ([type  isEqual: @"Lyft"])
                         {
                             image = LYFT;
                             lyftBounds = [bounds includingCoordinate:iconMarker.position];
                         }
                         if ([type  isEqual: @"Both"])
                         {
                             image = BOTH;
                             bothBounds = [bounds includingCoordinate:iconMarker.position];
                         }
                         bounds = [bounds includingCoordinate:iconMarker.position];
                     }
                     
                     
                     
                     NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
                     NSData *imageData = [NSData dataWithContentsOfFile:path];
                     
                     
                     iconMarker.icon = [UIImage imageWithData:imageData scale:3.0];
                     
                     iconMarker.map = googlMapView;
                     
                     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"zoom"];
                 }
                 
                 BOOL zoom = [[NSUserDefaults standardUserDefaults] boolForKey:@"zoom"];
                 
                 if (zoom)
                 {
                     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"zoom"];
                     
                     [CATransaction begin];
                     [CATransaction setValue:[NSNumber numberWithFloat: 0.8] forKey:kCATransactionAnimationDuration];
                     
                     [googlMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
                     
                     [CATransaction commit];
                 }

                 
                }
             
             
             
         }
     }];
    
    for (NSDictionary *drivDict in driversLocation)
    {
        [previousData addObject:drivDict];
    }
   

}


- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    
    InfoWindow *customwinodw;
    
        NSString *lbl = [marker accessibilityLabel];
        
        int b = [lbl intValue];
        
        NSUInteger indexOfMarker = [[previousData valueForKey:@"id"] indexOfObject:lbl];
    
    customwinodw =  [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] lastObject];
    
//    if (selectedId==nil) {

        selectedId = [NSString stringWithFormat:@"%@",[previousData[indexOfMarker] valueForKey:@"id"]];
        
        prevoiusId = (int)indexOfMarker;
        
        name = [previousData[indexOfMarker] valueForKey:@"username"] ;
        driverId = [NSString stringWithFormat:@"%@",[previousData[indexOfMarker] valueForKey:@"id"]];
        customwinodw.name.text = name ;
        
        
        NSString *path = [NSString stringWithFormat:@"%@",[previousData[indexOfMarker] valueForKey:@"image"]];
        
        
        if (![path isEqualToString:@""] || path == nil)
        {
            NSURL *url = [NSURL URLWithString:path];
            
            [customwinodw.photo sd_setImageWithURL:url
                                  placeholderImage:[UIImage imageNamed:@"ic_user_icon.png"]
                                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                             [self saveImage:customwinodw.photo.image filename:[NSString stringWithFormat:@"%@.png",driverId]];
                                         }];
            
            
        }


    
    
    customwinodw.name.text = name ;
    
    customwinodw.photo.layer.cornerRadius = customwinodw.photo.frame.size.width/2;
     customwinodw.photo.layer.borderWidth = 2.0;
    customwinodw.photo.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:42/255 green:131/255 blue:208/255 alpha:1.0]);
     customwinodw.photo.layer.masksToBounds = YES;
    
    
   
    customwinodw.backIMage.layer.cornerRadius = 5;
    customwinodw.backIMage.layer.masksToBounds = YES;

    return customwinodw;
}

-(void)showImage
{
    
}


-(void)saveImage : (UIImage *)image filename:(NSString *)filename
{
//    UIImage *image = [UIImage imageNamed:@"Image.jpg"];
    NSString *stringPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"profileImage"];
    // New Folder is your folder name
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [data writeToFile:filename atomically:YES];
}


-(UIImage*)retrieveImageFromPhone:(NSString*)fileNamewhichtoretrieve

{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Get the docs directory
    
    NSString *documentsPath = [paths objectAtIndex:0];
    
    
    
    NSString *folderPath = [documentsPath   stringByAppendingPathComponent:@"profileImage"];  // subDirectory
    
    
    
    NSString *filePath = [folderPath stringByAppendingPathComponent:
                          
                          [fileNamewhichtoretrieve stringByAppendingFormat:
                           
                           @"%@.png"]];
    
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        
        return [[UIImage alloc] initWithContentsOfFile:filePath];
    
    else 
        
        return nil;
    
}



- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    
    MessagesViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    
   
    
    VC.name = name;
    VC.friendID = driverId;
    [self presentViewController:VC animated:NO
                     completion:nil];
    
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

- (CGFloat) pointPairToBearingDegrees:(CGPoint)startingPoint secondPoint:(CGPoint) endingPoint
{
    CGPoint originPoint = CGPointMake(endingPoint.x - startingPoint.x, endingPoint.y - startingPoint.y); // get origin point to origin by subtracting end from start
    float bearingRadians = atan2f(originPoint.y, originPoint.x); // get bearing in radians
    float bearingDegrees = bearingRadians * (180.0 / M_PI); // convert to degrees
    bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)); // correct discontinuity
    return bearingDegrees;
}


- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (selectedId != nil)
        selectedId = nil;


}



-(void)notificationcenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectedIdtoNil:)
                                                 name:@"setValue"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(zoomFunction:)
                                                 name:@"zoom"
                                               object:nil];

    
}

- (void) selectedIdtoNil:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"setValue"])
    {
        selectedId = nil;
        
    }
    
}


-(void)zoomFunction:(NSNotification *) notification
{
     NSString *Filtertype = [[NSUserDefaults standardUserDefaults]valueForKey:@"type"];
    
    
//    if ([[notification name] isEqualToString:@"zoom"])
//    {
//        
//        
//        [CATransaction begin];
//        [CATransaction setValue:[NSNumber numberWithFloat: 0.8] forKey:kCATransactionAnimationDuration];
//        
//        if ([Filtertype isEqualToString:@"Uber"])
//        {
//            [googlMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:UberBounds withPadding:30.0f]];
//        }
//        else if([Filtertype isEqualToString:@"Lyft"])
//        {
//            [googlMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:lyftBounds withPadding:30.0f]];
//        }
//        else if([Filtertype isEqualToString:@"Both"])
//        {
//            [googlMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bothBounds withPadding:30.0f]];
//        }
//        else
//        {
//            [googlMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:allBounds withPadding:30.0f]];
//        }
//        
//        [CATransaction commit];
//        
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"zoom"];
//        
//    }
//
//    
   
    
    
    
    
}
//
//- (void) zoomMapView:(NSNotification *) notification
//{
//    if ([[notification name] isEqualToString:@"zoom"])
//    {
//        
//        [CATransaction begin];
//        [CATransaction setValue:[NSNumber numberWithFloat: 0.8] forKey:kCATransactionAnimationDuration];
//        
//        [googlMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
//        
//        [CATransaction commit];
//        
//
//        
//    }
//    
//}


@end
