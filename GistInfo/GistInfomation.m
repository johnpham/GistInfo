//
//  GistInfomation.m
//  GistInfo
//
//  Created by John Pham on 12/16/13.
//  Copyright (c) 2013 John Pham. All rights reserved.
//

#import "GistInfomation.h"

@interface GistInfomation ()

@end

@implementation GistInfomation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Tells the delegate that a download task has finished downloading.
//-(void)URLSession:(NSURLSession *)session
//     downloadTask:(NSURLSessionDownloadTask *)downloadTask
//didFinishDownloadingToURL:(NSURL *)location
//{
//    // use code above from completion handler
//}
//
////Periodically informs the delegate about the download’s progress.
//- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
//      didWriteData:(int64_t)bytesWritten
// totalBytesWritten:(int64_t)totalBytesWritten
//totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
//    
//}
//
////Tells the delegate that the download task has resumed downloading.
//- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
// didResumeAtOffset:(int64_t)fileOffset
//expectedTotalBytes:(int64_t)expectedTotalBytes {
//    
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",self.editGist.gistId);

    //put stuff here!
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
