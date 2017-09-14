//
//  TableViewController.m
//  movie app
//
//  Created by mohamed mahmoud zead on 9/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "TableViewController.h"
#import <AFNetworking.h>
#import <JSONModel.h>
#import "model.h"
#import <sqlite3.h>
#import "JETSDBConnection.h"
#import "model.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "check.h"
#import "loginController.h"
#import "loginController.h"
#import "ViewController.h"

@interface TableViewController ()
{
    NSArray *rawJSON;
    JETSDBConnection *DB;
    loginController *log;
   // check *chk;
}
@property (strong, nonatomic) model *photosModel;
@property NSMutableArray *array;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _chk=[check new];
    [self fetchPhotos];
    DB=[JETSDBConnection new];
    nmodel=[model new];
    
    // push in database
        for(int i=0;i<[rawJSON count];i++)
    {
        
        NSNumber *num=[rawJSON[i]objectForKey:@"rating"];
        float d=[num doubleValue];
        [nmodel setTitle:[rawJSON[i]objectForKey:@"title"]];
        [nmodel setImage:[rawJSON[i]objectForKey:@"image"]];
        [nmodel setGenre:[rawJSON[i]objectForKey:@"genre"]];
        [nmodel setRating:d];
        [nmodel setReleaseYear:[rawJSON[i]objectForKey:@"releaseYear"]];
        [DB addRow:nmodel];

               
    }
    UIBarButtonItem *logout = [[UIBarButtonItem alloc]initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self action:@selector(Logout)];
    [self.navigationItem setRightBarButtonItem:logout];
    [self.navigationItem setLeftBarButtonItem:nil];
    [self.navigationItem setLeftBarButtonItem :nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchPhotos {
    NSURL *photosURL = [NSURL URLWithString:@"https://api.androidhive.info/json/movies.json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:photosURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        rawJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
    }] resume];

}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = nil;
    self.navigationItem.hidesBackButton = YES;
    
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
    // This is just Programatic method you can also do that by xib !
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu",(unsigned long)[DB.retriveRows count]);
    return [DB.retriveRows count] ;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        
    }
    
//    
//    NSData *image=[[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:[rawJSON[indexPath.row] objectForKey:@"image"]]];
//    
    
    NSLog(@"%@",[rawJSON[indexPath.row] objectForKey:@"image"]);
    
//    UIImageView *rating = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"small.png"]];
//    cell.accessoryView = rating;
    UIFont *myFont = [ UIFont fontWithName: [UIFont familyNames][9] size: 18.0 ];
    cell.textLabel.font  = myFont;
    model *m =[model new];
     m=[DB retriveRows][indexPath.row];
    
    cell.textLabel.text =m.title;
    NSLog(@"%@",m.releaseYear);
//    
    float num=m.rating;
    
//
 cell.detailTextLabel.text=[NSString stringWithFormat:@"%.1f",num];
   cell.detailTextLabel.font=[ UIFont fontWithName: [UIFont familyNames][27] size: 15.0 ];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [cell.imageView  sd_setImageWithURL:[NSURL URLWithString:[rawJSON[indexPath.row] objectForKey:@"image"]]
        placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
  
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   
    UIStoryboard *str=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _chk=[str instantiateViewControllerWithIdentifier:@"iden"];
    [self.navigationController pushViewController:_chk animated:YES];
   NSNumber *num= [rawJSON[indexPath.row]objectForKey:@"rating"];
    float f =[num floatValue];
       NSLog(@"%@",[NSString stringWithFormat:@"%.1f",f]);
    
    
    [_chk setMyTitle:[rawJSON[indexPath.row]objectForKey:@"title"]];
    NSLog(@"%@",[rawJSON[indexPath.row]objectForKey:@"genre"][0]);

    [_chk setMyGn:[rawJSON[indexPath.row]objectForKey:@"genre"][0]];

    if([[rawJSON[indexPath.row]objectForKey:@"genre"]count]==2)
    {
        
        [_chk setMyGn1:[rawJSON[indexPath.row]objectForKey:@"genre"][1]];
    }
    if([[rawJSON[indexPath.row]objectForKey:@"genre"] count]==3)
    {
        [_chk setMyGn1:[rawJSON[indexPath.row]objectForKey:@"genre"][1]];
        
         [_chk setMyGn2:[rawJSON[indexPath.row]objectForKey:@"genre"][2]];
    }
    [_chk setMyYear:[NSString stringWithFormat:@"%@",[rawJSON[indexPath.row]objectForKey:@"releaseYear"]]];
    [_chk setMyRate:(@"%.1f",f)];
    [_chk setImag:[rawJSON[indexPath.row]objectForKey:@"image"]];
    
    
//    [chk.imageView  sd_setImageWithURL:[NSURL URLWithString:[rawJSON[indexPath.row] objectForKey:@"image"]]
//           placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//
}
-(void)Logout{
    [self.navigationController popToRootViewControllerAnimated:YES];
    _userDefault = [NSUserDefaults standardUserDefaults];
    [_userDefault setBool:NO forKey:@"flag"];
    [_userDefault synchronize];
    
}

@end
