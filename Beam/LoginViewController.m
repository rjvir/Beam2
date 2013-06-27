//
//  LoginViewController.m
//  beam
//
//  Created by Raj Vir on 5/23/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import "LoginViewController.h"
#import <Firebase/Firebase.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)LoginButtonPressed:(id)sender {
    // And then we write data to his first and last name locations:
//    if(usernameRef){
//        usernameRef = nil;
//    }
    Firebase* usernameRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://rjvir.firebaseio.com/numbers/%@", self.username.text]];
//    [[usernameRef childByAppendingPath:self.username.text]
    
    [usernameRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if([snapshot.value isEqual:[NSNull null]]){
            NSLog(@"%@", snapshot.value);
            NSLog(@"available!");
            NSLog(@"empty");
        } else {
            NSLog(@"%@", snapshot.value);
            NSLog(@"available!");
            NSLog(@"not empty");
        }
    }];
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

@end
