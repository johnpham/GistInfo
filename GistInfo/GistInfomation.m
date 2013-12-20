//
//  GistInfomation.m
//  GistInfo
//
//  Created by John Pham on 12/16/13.
//  Copyright (c) 2013 John Pham. All rights reserved.
//

#import "GistInfomation.h"



@interface GistInfomation ()

@property (strong,nonatomic) NSURLSession *session;
@property (strong,nonatomic) NSMutableArray *description;

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
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSString *userPasswordString = [NSString stringWithFormat:@"johnpham:2007gti"];
        NSData * userPasswordData = [userPasswordString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64EncodedCredential = [userPasswordData base64EncodedStringWithOptions:0];
        NSString *authString = [NSString stringWithFormat:@"Basic %@", base64EncodedCredential];
        NSLog(@"Basic number two %@", base64EncodedCredential);
                [defaultConfigObject setHTTPAdditionalHeaders:@{@"Authorization": authString}];
        self.session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        //init description array
        self.description = [[NSMutableArray alloc]init];
    }
    return self;
}


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
