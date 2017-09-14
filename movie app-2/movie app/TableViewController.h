//
//  TableViewController.h
//  movie app
//
//  Created by mohamed mahmoud zead on 9/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "check.h"
#import <sqlite3.h>
#import "loginController.h"
#import "model.h"

@interface TableViewController : UITableViewController
{
     model *nmodel;
}
@property NSUserDefaults *userDefault;
@property check *chk;
@property loginController *loginontroller;
@end
