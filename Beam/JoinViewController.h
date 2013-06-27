//
//  JoinViewController.h
//  beam
//
//  Created by Raj Vir on 5/24/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface JoinViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) Firebase *f;
@property (strong, nonatomic) Firebase *fh;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@end
