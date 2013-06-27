//
//  RVMessages.h
//  beam
//
//  Created by Raj Vir on 5/25/13.
//  Copyright (c) 2013 Raj Vir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@protocol FireBaseDelegate <NSObject>

-(void)receivedData;

@end

@interface RVMessages : NSObject {
    __unsafe_unretained id<FireBaseDelegate> delegate;
}

@property (strong, nonatomic) NSMutableDictionary *messages;
@property (strong, nonatomic) NSMutableArray *threads;
@property (strong, nonatomic) Firebase *f;
@property (assign) id<FireBaseDelegate> delegate;
-(id) initFirebase:(NSString *)name;
@end
