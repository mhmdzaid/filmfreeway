//
//  check.m
//  movie app
//
//  Created by mohamed mahmoud zead on 9/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "check.h"
#import "TableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <HCSStarRatingView.h>
@interface check ()

@end

@implementation check

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:_rate.frame];
    starRatingView.maximumValue = 10;
    starRatingView.minimumValue = 0;
    starRatingView.tintColor = [UIColor blueColor];
    [starRatingView setEnabled:false
     ];
    starRatingView.allowsHalfStars = YES;
    starRatingView.value = [self myRate];
    [self.view addSubview:starRatingView];
    
   _movietitle.text = _myTitle;
    _gn.text = _myGn;
    _year.text =_myYear;
    _gnn1.text = _myGn1;
    _gnn2.text=_myGn2;
    [_imageView  sd_setImageWithURL:[NSURL URLWithString:_imag]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
