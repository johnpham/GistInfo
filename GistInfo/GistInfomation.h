//
//  GistInfomation.h
//  GistInfo
//
//  Created by John Pham on 12/16/13.
//  Copyright (c) 2013 John Pham. All rights reserved.
//

#import <UIKit/UIKit.h> 

@interface GistInfomation : UIViewController <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate,UIDocumentInteractionControllerDelegate>
//create property NSString that will contain the gist id

@property (nonatomic, strong)NSString *gistId;

@end
