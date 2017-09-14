//
//  loginController.h
//  movie app
//
//  Created by mohamed mahmoud zead on 9/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface loginController : UIViewController



@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pass;
- (IBAction)login:(id)sender;
- (IBAction)signup:(id)sender;
@property const char *myDbpath;
@property (strong , nonatomic) NSString *myDatabasePath;
@property (nonatomic) sqlite3 *contactDB;
@property (strong, nonatomic) NSString *myDocsDir;
@property NSUserDefaults *userDefault;
@property (weak, nonatomic) IBOutlet UIButton *mylogin;


@end
