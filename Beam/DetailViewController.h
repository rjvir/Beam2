//
//  DetailViewController.h
//  beam
//
//  Created by Raj Vir on 5/20/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "RVMessages.h"

@interface DetailViewController : UIViewController<UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, UIBubbleTableViewDataSource, FireBaseDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UITextView *chatText;
@property (strong, nonatomic) Firebase *f;
@property (strong, nonatomic) Firebase *currentNode;
@property (strong, nonatomic) IBOutlet UIBubbleTableView *chatTable;
@property (strong, nonatomic) NSMutableArray *chatMessages;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *recName;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) RVMessages *m;
@property (strong, nonatomic) NSString *threadId;

-(void)receivedData;

@end