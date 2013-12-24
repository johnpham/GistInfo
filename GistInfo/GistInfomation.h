//
//  GistInfomation.h
//  GistInfo
//
//  Created by John Pham on 12/16/13.
//  Copyright (c) 2013 John Pham. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "Gist.h"

@interface GistInfomation : UITableViewController


@property (nonatomic, strong)Gist *editGist;


- (IBAction)cancel;
- (IBAction)done;

@end
