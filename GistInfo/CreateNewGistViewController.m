//
//  CreateNewGistViewController.m
//  GistInfo
//
//  Created by John Pham on 12/24/13.
//  Copyright (c) 2013 John Pham. All rights reserved.
//

#import "CreateNewGistViewController.h"
#import "Gist.h"

@interface CreateNewGistViewController ()

@end

@implementation CreateNewGistViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

//makes keyboard pop up right away
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelCN
{
    [self.delegate addItemViewControllerDidCancel:self];
}

- (IBAction)doneCN
{
    
    Gist *item = [[Gist alloc]init];
    
    item.text = self.textField.text;
    
    [self.delegate addItemViewController:self didFinishAddingItem:item];
}

-(NSIndexPath *)tableView:(UITableView *)tableView
 willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text
                         stringByReplacingCharactersInRange:range withString:string];
    if ([newText length] > 0) { self.doneBarButton.enabled = YES;
    } else { self.doneBarButton.enabled = NO;
    }
    return YES; }







@end
