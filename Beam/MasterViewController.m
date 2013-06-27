//
//  MasterViewController.m
//  beam
//
//  Created by Raj Vir on 5/20/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "RVMessages.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    // Dispose of any resources that can be recreated.
    _f = [[Firebase alloc] initWithUrl:@"https://rjvir.firebaseio.com/"];
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
//    [_objects insertObject:@"room1" atIndex:0];
//    [self.tableView reloadData];
    
//    RVMessages *yo = [[RVMessages alloc] initFirebase];
    _m = [[RVMessages alloc] initFirebase:self.username];
    _m.delegate = self;
    
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    NSLog(@"%@", _objects[0]);
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%d", [_m.threads count]);
    return [_m.threads count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

//    NSString *object = _objects[indexPath.row];
    cell.textLabel.text = [[_m.threads objectAtIndex:indexPath.row] objectForKey:@"name"];
    if([[_m.messages objectForKey:[[_m.threads objectAtIndex:indexPath.row] objectForKey:@"id"]] count] > 0){
        cell.detailTextLabel.text = [[[_m.messages objectForKey:[[_m.threads objectAtIndex:indexPath.row] objectForKey:@"id"]] objectAtIndex:0] objectForKey:@"message"];
    }

    return cell;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 40;
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)receivedData {
//    NSLog(@"yoo");
    [self.tableView reloadData];
//NSLog(@"%@", [[[_m.messages objectForKey:@"-IvZJJKEIqKAB1cp3Aj9"] objectAtIndex:0] objectForKey:@"user"]);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = _objects[indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
        DetailViewController *c = [segue destinationViewController];
        c.name = self.username;
        c.recName = [[_m.threads objectAtIndex:indexPath.row] objectForKey:@"name"];
        c.threadId = [[_m.threads objectAtIndex:indexPath.row] objectForKey:@"id"];
        c.m = _m;
    }
}

- (IBAction)plusPressed:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"New Chat" message:@"Enter a username" delegate:self cancelButtonTitle:@"Go!" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}
- (IBAction)composePressed:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"New Chat" message:@"Enter a username" delegate:self cancelButtonTitle:@"Go!" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *recName = [[alertView textFieldAtIndex:0] text];
    Firebase *fh = [[_f childByAppendingPath:@"threads"] childByAutoId];
//    [fh setValue:@""];
    NSString *tid = [fh name];
    [[_f childByAppendingPath:[NSString stringWithFormat:@"users/%@/threads/%@", self.username, recName]] setValue:tid];
    [[_f childByAppendingPath:[NSString stringWithFormat:@"users/%@/threads/%@", recName, self.username]] setValue:tid];
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
    NSLog(@"%@", tid);
}


@end