//
//  model.h
//  movie app
//
//  Created by mohamed mahmoud zead on 9/10/17.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIImage+GIF.h>
@interface model : JSONModel
@property (strong, nonatomic) NSString *title;
@property (strong ,nonatomic) NSString *image;
@property float rating;
@property (strong ,nonatomic) NSNumber *releaseYear;
@property (strong ,nonatomic) NSArray  *genre;

@end
