//
//  check.h
//  movie app
//
//  Created by mohamed mahmoud zead on 9/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface check : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *movietitle;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *gn;
@property (weak, nonatomic) IBOutlet UILabel *gnn1;
@property (weak, nonatomic) IBOutlet UILabel *gnn2;

@property NSString *myTitle,*myYear,*myGn,*myGn1,*myGn2,*imag;
@property float myRate;

@end
