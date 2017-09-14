
//  JETSDBConnection.m
//  movie app
//  Created by mohamed mahmoud zead on 9/11/17.
//  Copyright © 2017 Mac. All rights reserved.

#import "JETSDBConnection.h"

@implementation JETSDBConnection

- (id)init
{
    self = [super init];
    if (self) {
        
        //- that is the step NO_1 -//
        // retrive all the avilable paths in the phone to store the DB
        // then get the first path and append it by the name of the DB
        
        NSArray *myAvilable = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _DBPath = [[NSString alloc] initWithString:[[myAvilable objectAtIndex:0] stringByAppendingPathComponent:@"ttt.db"]];
       
        NSLog(@"that is the path %@\n", _DBPath);
        //- that is the step NO_2 -//
        // first i will try to connect on the DB if succeded i will.
        // the caching table.
        
        NSLog(@"that is the value of my path %@", _DBPath);
        NSLog(@"that is the value of my connection %d", sqlite3_open([_DBPath UTF8String], &_DBCon));
        if (sqlite3_open([_DBPath UTF8String], &_DBCon) == SQLITE_OK ) {
            
            NSLog(@"connection happened");
            // create the sql statement
            _DBStat = @"CREATE TABLE IF NOT EXISTS MOVIES (ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT UNIQUE,IMAGE TEXT, RATING  FLOAT,RELEASEYEAR TEXT)";
            // execute the sql statement
            char *errorMsg;
            if (sqlite3_exec(_DBCon, [_DBStat UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
                NSLog(@"failed to create table get that error %s", errorMsg);
            }
            sqlite3_close(_DBCon);
        } else {
            NSLog(@"failed to connect to the DB");
        }
    }
    return self;
}
//# the end of init function #//

-(void)refreshDB {
    if (sqlite3_open([_DBPath UTF8String], &_DBCon) == SQLITE_OK) {
        _DBStat = @"DROP TABLE MOVIES";
        char *errorMsg;
        if (sqlite3_exec(_DBCon, [_DBStat UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            NSLog(@"failed to create table get that error %s", errorMsg);
        }
        sqlite3_close(_DBCon);
    } else {
        NSLog(@"failed to connect to the DB");
    }
}

//- addRaw function -//
// this func take an object of type movie and
// put the detail of it in the data base
-(void)addRow:(model *)movieRow {
    if (sqlite3_open([_DBPath UTF8String], &_DBCon) == SQLITE_OK) {
        _DBStat = [NSString stringWithFormat:@"INSERT INTO MOVIES (TITLE,IMAGE,RATING,RELEASEYEAR)VALUES (\"%@\", \"%@\", \"%f\", \"%@\")",[movieRow title] ,[movieRow image], [movieRow rating], [movieRow releaseYear]];
        
        // to add in any table i use this mechanisme
        // not like creating a table
        /* ....the mechanizm explaination....
         - at first i create my sql statement.
         - then i use the func sqlite3_prepare_v2.
         - then i use the func sqlite3_step.
         - then i use finalize method to commit the editing.*/
        
        sqlite3_stmt *mySqlStmt;
        sqlite3_prepare_v2(_DBCon, [_DBStat UTF8String], -1, &mySqlStmt, nil);
        
        if (sqlite3_step(mySqlStmt) == SQLITE_DONE) {
            NSLog(@"you have just added a new row");
        } else {
            NSLog(@"couldn't add the new row");
        }
        sqlite3_finalize(mySqlStmt);
        sqlite3_close(_DBCon);
    } else {
        NSLog(@"failed to connect to the DB");
        
    }
    
}

//# the end of addRow function #//
-(NSMutableArray *)retriveRows {
    NSMutableArray *movies = [NSMutableArray new];
    model *myMovie;
    sqlite3_stmt *mySqlStmt;
    if (sqlite3_open([_DBPath UTF8String], &_DBCon) == SQLITE_OK) {
        _DBStat = @"SELECT TITLE,IMAGE,RATING,RELEASEYEAR FROM MOVIES";
        if (sqlite3_prepare_v2(_DBCon, [_DBStat UTF8String], -1, &mySqlStmt, nil) == SQLITE_OK) {
            while (sqlite3_step(mySqlStmt) == SQLITE_ROW) {
                myMovie = [model new];
                myMovie.title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(mySqlStmt, 0)];
                myMovie.image=[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(mySqlStmt, 1)];
                myMovie.rating = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(mySqlStmt, 2)] floatValue];
                myMovie.releaseYear=[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(mySqlStmt, 3)];
                [movies addObject:myMovie];
            }
        } else {
            NSLog(@"failed at retriving");
        }
    } else {
        NSLog(@"failed to open DB at retriving");
    }
//The End of DataBase
    return movies;
}
@end
