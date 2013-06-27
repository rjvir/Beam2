//
//  SplashViewController.h
//  beam
//
//  Created by Raj Vir on 5/24/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface SplashViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *number;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
