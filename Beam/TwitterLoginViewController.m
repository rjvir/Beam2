//
//  TwitterLoginViewController.m
//  Beam
//
//  Created by Raj Vir on 7/15/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import "TwitterLoginViewController.h"

@interface TwitterLoginViewController ()

@end

@implementation TwitterLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // _accountStore = [[ACAccountStore alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginPressed:(id)sender {
    Firebase* ref = [[Firebase alloc] initWithUrl:@"https://rjvir.firebaseio.com"];
    FirebaseSimpleLogin* authClient = [[FirebaseSimpleLogin alloc] initWithRef:ref];

//    [authClient createUserWithEmail:@"raj@rjvir.com" password:@"yoyoyo"
//                 andCompletionBlock:^(NSError* error, FAUser* user) {
//         
//         if (error != nil) {
//             // There was an error creating the account
//         } else {
//             
//             
//             // We created a new user account
//         }
//     }];
    
    [authClient loginToTwitterAppWithId:@"ISABcSecur65EyT3rceNWA"
    multipleAccountsHandler:^int(NSArray *usernames) {
                    
        // If you do not wish to authenticate with any of these usernames, return NSNotFound.
        NSLog(@"%@", usernames);
        return 1;
    } withCompletionBlock:^(NSError *error, FAUser *user) {
//        NSLog(@"%@", user.thirdPartyUserData[@"username"]);
        if (error != nil) {
            NSLog(@"Error Authenticating");
        } else {
            self.username = user.thirdPartyUserData[@"username"];
            
        }
    }];

}

@end
