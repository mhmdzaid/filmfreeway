//
//  JETSDBConnection.h
//  movie app
//
//  Created by mohamed mahmoud zead on 9/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "model.h"
@interface JETSDBConnection : NSObject
@property NSString *DBPath;
@property (nonatomic) sqlite3 *DBCon;
@property NSString *DBStat;
-(void) refreshDB;
-(void) addRow:(model*) movieRow;
-(NSMutableArray*) retriveRows;


@end
