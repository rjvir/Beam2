//
//  MasterViewController.h
//  beam
//
//  Created by Raj Vir on 5/20/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVMessages.h"

@interface MasterViewController : UITableViewController<FireBaseDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userLabel;
@property (strong, nonatomic) RVMessages *m;
@property (strong, nonatomic) Firebase *f;
@property (strong, nonatomic) NSString *username;

-(void)receivedData;

@end