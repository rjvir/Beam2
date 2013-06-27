//
//  UsernameViewController.m
//  beam
//
//  Created by Raj Vir on 5/28/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import "UsernameViewController.h"

@interface UsernameViewController ()

@end

@implementation UsernameViewController

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MasterViewController *c = [[segue destinationViewController] visibleViewController];
    c.username = self.username.text;
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        DetailViewController *c = [segue destinationViewController];
//        c.name = self.userLabel.text;
//        c.threadId = [[_m.threads objectAtIndex:indexPath.row] objectForKey:@"id"];
//        c.m = _m;
//    }
}

@end
