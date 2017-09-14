
//  ViewController.m
//  movie app
//  Created by mohamed mahmoud zead on 9/10/17.
//  Copyright © 2017 Mac. All rights reserved.

#import "ViewController.h"
#import "TableViewController.h"
#import "check.h"

@interface ViewController (){
    UIAlertController *alert ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mysignup.layer.cornerRadius=10.5;
    _userDefault = [NSUserDefaults standardUserDefaults];
    
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    _docsDir = dirPaths[0];
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [_docsDir stringByAppendingPathComponent:
                                      @"project.db"]];
    
    _dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(_dbpath, &_contactDB) == SQLITE_OK)
    {
        
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS PROJECT (NAME TEXT PRIMARY KEY, PASSWORD TEXT , CONFIRM TEXT)";
        
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Failed to open Database" preferredStyle:UIAlertControllerStyleAlert];
            
        }
        sqlite3_close(_contactDB);
    } else {
        alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Failed to open/create Database" preferredStyle:UIAlertControllerStyleAlert];
        
    }
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"back.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [[UIColor colorWithPatternImage:image] colorWithAlphaComponent:0.7];
    // _userDefault =  [NSUserDefaults standardUserDefaults];
    //[_userDefault boolForKey:@"flag"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    if([_userDefault boolForKey:@"flag"]==YES){
        //   UIViewController *view =[self.storyboard instantiateViewControllerWithIdentifier:@"myTable"];
        //    [self presentViewController:view animated:YES completion:nil];
        [self.navigationController pushViewController:[TableViewController new] animated:YES];
        self.navigationItem.hidesBackButton = nil;
        self.navigationItem.hidesBackButton = YES;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [_user setText:@""];
    [_password setText:@""];
    [_confirm setText:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signup:(id)sender {
    const char *mydbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwyzABCDEFGHIJKLMMNOPQRSTUVWXYZ0123456789 _"]invertedSet];
    if([_password.text rangeOfCharacterFromSet:set].location == NSNotFound && [_user.text rangeOfCharacterFromSet:set].location == NSNotFound ){
        if(_password.text.length>=8){
            
        
    
    if (sqlite3_open(mydbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO PROJECT (NAME,PASSWORD,CONFIRM)  VALUES (\"%@\",\"%@\",\"%@\")",
                               _user.text,_password.text,_confirm.text];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            // UIViewController *view =[self.storyboard instantiateViewControllerWithIdentifier:@"myTable"];
            // [self presentViewController:view animated:YES completion:nil];
            if([self checkPasswordMatch]==YES){
                [self.navigationController pushViewController:[TableViewController new] animated:YES];
            }
            else{
                alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"password doesn't match " preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:yesButton];
                [self presentViewController:alert animated:YES completion:nil];
            }
        } else {
            alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"wrong user name or password" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }}
    else{
        alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter at least 8 Digits and Characters" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }}
    else{
        alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Check if it's a Special Charaters" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
        

    }
        
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


-(BOOL)checkPasswordMatch{
    if([_password.text isEqualToString:_confirm.text]){
        [self registerNewUser];
        return YES;
    }
    return NO;
}

-(void)registerNewUser{
    [self.navigationController pushViewController:[TableViewController new] animated:YES];
    [_userDefault setBool:YES forKey:@"flag"];
    [_userDefault synchronize];
    alert = [UIAlertController alertControllerWithTitle:@"success" message:@"Successfully registered" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
