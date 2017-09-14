//
//  ViewController.h
//  movie app
//
//  Created by mohamed mahmoud zead on 9/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>



@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirm;
- (IBAction)signup:(id)sender;
@property (strong, nonatomic) NSString *docsDir;
@property const char *dbpath;
@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property NSUserDefaults *userDefault;
@property (weak, nonatomic) IBOutlet UIButton *mysignup;


@end

