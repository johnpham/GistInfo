//
//  Gist.h
//  GistInfo
//
//  Created by John Pham on 12/18/13.
//  Copyright (c) 2013 John Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gist : NSObject
@property(nonatomic,strong)NSString *gistId;
@property(nonatomic,strong)NSString *description;
@property(nonatomic,strong)NSString *forkUrl;
@property(nonatomic,strong)NSString *push;

@property (nonatomic, copy) NSString *text;

@end
