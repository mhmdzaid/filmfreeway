//
//  loginController.m
//  movie app
//
//  Created by mohamed mahmoud zead on 9/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "loginController.h"
#import "TableViewController.h"
#import "check.h"
@interface loginController ()
{
    UIAlertController *alert ;
    TableViewController *table;
}
@end

@implementation loginController
- (void)viewDidLoad {
    [super viewDidLoad];
    _mylogin.layer.cornerRadius=10.5;
    // Do any additional setup after loading the view.
    table=[TableViewController new];
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    _myDocsDir = dirPaths[0];
    
    // Build the path to the database file
    _myDatabasePath= [[NSString alloc]
                      initWithString: [_myDocsDir stringByAppendingPathComponent:
                                       @"project.db"]];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"back.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [[UIColor colorWithPatternImage:image] colorWithAlphaComponent:0.7];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [_userName setText: @""];
    [_pass setText:@""];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    _myDbpath = [_myDatabasePath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(_myDbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT NAME FROM PROJECT WHERE NAME = \"%@\" AND PASSWORD = \"%@\"",_userName.text,_pass.text];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                [self.navigationController pushViewController:[TableViewController new] animated:YES];
                _userDefault = [NSUserDefaults standardUserDefaults];
                [_userDefault setBool:YES forKey:@"flag"];
                [_userDefault synchronize];
            }
            else{
                alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Wrong username or password" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:yesButton];
                [self presentViewController:alert animated:YES completion:nil];
                
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    
}



- (IBAction)signup:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
