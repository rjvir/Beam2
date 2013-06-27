//
//  SplashViewController.m
//  beam
//
//  Created by Raj Vir on 5/24/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import "SplashViewController.h"
#import <Firebase/Firebase.h>
#import "JoinViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (IBAction)goPressed:(id)sender {
    [self.activityIndicator startAnimating];
    Firebase* numberRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://rjvir.firebaseio.com/numbers/%@", self.number.text]];
    //    [[usernameRef childByAppendingPath:self.username.text]
    [numberRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [self.activityIndicator stopAnimating];
        if([snapshot.value isEqual:[NSNull null]]){
            //follow segue to Join View Controller
            [self performSegueWithIdentifier: @"pickUsername" sender: self];
            NSLog(@"null number: %@", snapshot.value);
        } else {
            //follow segue to Message List View Controller
            [self performSegueWithIdentifier: @"loadList" sender: self];
            NSLog(@"%@", snapshot.value);
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pickUsername"]) {
//        NSLog(@"%@", self.number.text);
        JoinViewController *j = [segue destinationViewController];
        j.number = self.number.text;
    }
}

@end
