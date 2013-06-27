//
//  JoinViewController.m
//  beam
//
//  Created by Raj Vir on 5/24/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import "JoinViewController.h"

@interface JoinViewController ()

@end

@implementation JoinViewController

//- (void)setNumber:(NSString *)number {
//    self.number = number;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)textLabelDidChange:(id)sender {
    [_fh removeAllObservers];
    _fh = nil;
    if(![self.usernameField.text isEqual:@""]){
        _fh = [_f childByAppendingPath:self.usernameField.text];
        NSLog(@"number: %@", self.number);
        [_fh observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            if([snapshot.value isEqual:[NSNull null]]){
                NSLog(@"Null!: %@", snapshot.value);
                //            NSLog(@"available: %@", snapshot.value);
            } else {
                NSLog(@"Not null?");
                //            NSLog(@"not available: %@", snapshot.value);
            }
        }];
        NSLog(@"text view did change");
    }
//    [_fh removeAllObservers];
//    _fh = nil;
//    _fh = [_f childByAppendingPath:self.usernameField.text];
//    [_fh observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        if([snapshot.value isEqual:[NSNull null]]){
//            NSLog(@"available: %@", snapshot.value);
//        } else {
//            NSLog(@"not available: %@", snapshot.value);
//        }
//    }];
//    NSLog(@"%@", self.usernameField.text);
}

- (void)textViewDidChange:(UITextView *)textView {
//    [_f removeAllObservers];
//    [_f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        if([snapshot.value isEqual:[NSNull null]]){
//            NSLog(@"available: %@", snapshot.value);
//        } else {
//            NSLog(@"not available: %@", snapshot.value);
//        }
//    }];

//    if(self.currentNode == nil){
//        self.currentNode = [_f childByAutoId];
//    }
//    
//    [self.currentNode setValue:@{@"from":self.name, @"text":textView.text}];
    
    //    [self.currentNode setValue:self.name forKey:@"name"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _f = [[Firebase alloc] initWithUrl:@"https://rjvir.firebaseio.com/users/"];
//    NSLog(@"%@", self.usernameField.text);

//    NSLog(@"%@", self.number);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
