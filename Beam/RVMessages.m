 //
//  RVMessages.m
//  beam
//
//  Created by Raj Vir on 5/25/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import "RVMessages.h"
#import <Firebase/Firebase.h>

@implementation RVMessages
@synthesize delegate;

-(id)init {
    return [super init];
}

-(id) initFirebase:(NSString *)name {
    self.messages = [[NSMutableDictionary alloc] init];
    self.threads = [[NSMutableArray alloc] init];
    _f = [[Firebase alloc] initWithUrl:@"https://rjvir.firebaseio.com/"];
    
//    [self.messages setObject:[[NSMutableArray alloc] initWithObjects:@"yo", @"fo", nil] forKey:@"234"];
    
//    NSLog(@"%f", [[NSDate date] timeIntervalSince1970]);
//    [[[_f childByAppendingPath:@"users/raj/threads"] childByAutoId] setValue:@"-IvZJJKEIqKAB1cp3Aj9"];
//    [[[_f childByAppendingPath:@"users/raj/threads"] childByAutoId] setValue:@"-IvZLetFVW0EIscxI55X"];
//    [[[[_f childByAppendingPath:@"users/raj/threads"] childByAppendingPath:@"raj"] childByAutoId] setValue:@{@"user": @"raj", @"message": @"yo 2"}];
    NSLog(@"%@", name);
    [[_f childByAppendingPath:[NSString stringWithFormat:@"users/%@/threads", name]] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
//        NSLog(@"%@", snapshot.name);
        FDataSnapshot *snap = snapshot;
        [self.threads insertObject:@{@"id": snapshot.value, @"name":snapshot.name} atIndex:0];
        [self.messages setObject:[[NSMutableArray alloc] init] forKey:snapshot.value];
        [[_f childByAppendingPath:[NSString stringWithFormat:@"threads/%@", snapshot.value]] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
            [[self.messages objectForKey:snap.value] insertObject:snapshot.value atIndex:0];
            [delegate receivedData];
        }];
        
        [[_f childByAppendingPath:[NSString stringWithFormat:@"threads/%@", snapshot.value]] observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
            //NSLog(@"%@", snap.value);
            
            int index = 0;
            for(NSDictionary *val in [self.messages objectForKey:snap.value]){
//                NSLog(@"%@", snapshot.value);
                if([val[@"user"] isEqualToString:snapshot.value[@"user"]]){
                    [[self.messages objectForKey:snap.value] removeObject:val];
                    [[self.messages objectForKey:snap.value] insertObject:snapshot.value atIndex:index];
                    break;
                }
                index++;
            }
            [delegate receivedData];
        }];
        [delegate receivedData];

        
    }];
    //setValue:@{@"user_id": @"wilma", @"text": @"Hello"}];
    
    

    return [self init];
}

@end

//    [_f observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        [self.chatText becomeFirstResponder];
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
