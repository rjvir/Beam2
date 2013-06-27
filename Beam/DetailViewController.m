//
//  DetailViewController.m
//  beam
//
//  Created by Raj Vir on 5/20/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import "DetailViewController.h"
#import <Firebase/Firebase.h>
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "RVMessages.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    _f = [[Firebase alloc] initWithUrl:[NSString stringWithFormat: @"https://rjvir.firebaseio.com/%@", self.detailItem]];
    
    // Write data to Firebase
    
    if (self.detailItem) {
        self.navigationItem.title = self.detailItem;
    }
    
//    [self.chatText becomeFirstResponder];
    // Read data and react to changes
//    [_f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        self.chatText.text = snapshot.value;
//        
//        [self.chatTable reloadData];
//    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_m.messages objectForKey:self.threadId] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Chat";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    NSDictionary *message = [[_m.messages objectForKey:self.threadId] objectAtIndex:indexPath.row];
    cell.textLabel.text = message[@"user"];
    cell.detailTextLabel.text = message[@"message"];
    return cell;
}

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView {
//    NSMutableArray *a = [_m.messages objectForKey:self.threadId];
    
    
//    NSLog(@"%d", [a count]);
    
    return [[_m.messages objectForKey:self.threadId] count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row {
    //[[_m.messages objectForKey:self.threadId] objectAtIndex:indexPath.row]
    NSDictionary *message = [[_m.messages objectForKey:self.threadId] objectAtIndex:[[_m.messages objectForKey:self.threadId ] count] - row - 1];
    
    NSBubbleData *heyBubble = [NSBubbleData dataWithText:message[@"message"] date:[NSDate dateWithTimeIntervalSinceNow:-300] type:([message[@"user"] isEqualToString:self.name])?BubbleTypeMine:BubbleTypeSomeoneElse];
//    NSLog(@"%@", message[@"message"]);
    return heyBubble;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.chatMessages = [[NSMutableArray alloc] init];
//    [_f observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        [self.chatText becomeFirstResponder];
//        [self scrollToBottom];
//    }];
//    
    self.navigationItem.title = self.recName;
    _m.delegate = self;
//    self.name = @"raj";
    _f = [[Firebase alloc] initWithUrl:[NSString stringWithFormat: @"https://rjvir.firebaseio.com/threads/%@", self.threadId]];
//    [_f observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
//        [self.chatMessages insertObject:snapshot.value atIndex:0];
//        [self.chatTable reloadData];
//        [self scrollToBottom];
//    }];
//    
//    [_f observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
//        int index = 0;
//        for(NSDictionary *val in self.chatMessages){
//            if([val[@"from"] isEqualToString:snapshot.value[@"from"]]){
//                [self.chatMessages removeObject:val];
//                [self.chatMessages insertObject:snapshot.value atIndex:index];
//                break;
//            }
//            index++;
//        }
//        [self.chatTable reloadData];
//        [self scrollToBottom];
//    }];
    
//    [_f observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
//        [self.chatMessages removeObject:snapshot.value];
//        [self.chatTable reloadData];
//        [self scrollToBottom];
//    }];
    
    self.currentNode = nil;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.chatTable reloadData];
//    [self.chatText becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.chatText becomeFirstResponder];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.chatTable addGestureRecognizer:gestureRecognizer];
    NSLog(@"appeared!");
}

- (void) hideKeyboard {
    [self.chatText resignFirstResponder];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSLog(@"Keyboard was shown!");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat kbInt = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:kbInt animations:^{
        CGRect frame = self.chatTable.frame;
        NSLog(@"%f", frame.size.height);
        frame.size.height -= kbSize.height;
        self.chatTable.frame = frame;
    }];
    [self scrollToBottom];

}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = self.chatTable.frame;
        frame.size.height += kbSize.height;
        self.chatTable.frame = frame;
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView {
    if(self.currentNode == nil){
        self.currentNode = [_f childByAutoId];
    }
    
    [self.currentNode setValue:@{@"user":self.name, @"message":textView.text}];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if([text isEqualToString:@"\n"]) {
        self.currentNode = nil;
        self.chatText.text = @"";
        _date = [NSDate date];
        return NO;
    }
    NSTimeInterval timeInterval = [_date timeIntervalSinceNow];
    if((timeInterval*-1) > 2) {
        self.chatText.text = @"";
        self.currentNode = [_f childByAutoId];
    }
    
    _date = [NSDate date];
    return YES;
}

- (IBAction)frButton:(id)sender {
    [self.chatText becomeFirstResponder];
}

-(void)sizeKeyboardSmall {
    
}

- (void)scrollToBottom {
//    NSLog(@"scrolled to bottom");
    if([[_m.messages objectForKey: self.threadId] count] > 0) {
        NSIndexPath* ipath = [NSIndexPath indexPathForRow: [[_m.messages objectForKey:self.threadId] count]-1 inSection: 0];
        [self.chatTable scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
    }
}

- (void)receivedData{
    [self.chatTable reloadData];
    [self scrollToBottom];
}

@end
