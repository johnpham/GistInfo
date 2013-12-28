//
//  CreateNewGistViewController.h
//  GistInfo
//
//  Created by John Pham on 12/24/13.
//  Copyright (c) 2013 John Pham. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreateNewGistViewController;
@class Gist;

@protocol  CreateNewGistViewControllerDelegate<NSObject>

- (void)addItemViewControllerDidCancel:
(CreateNewGistViewController *)controller;

- (void)addItemViewController:
(CreateNewGistViewController *)controller
          didFinishAddingItem:(Gist *)item;

@end



@interface CreateNewGistViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@property (nonatomic, weak) id <CreateNewGistViewControllerDelegate> delegate;


- (IBAction)cancelCN;
- (IBAction)doneCN;


@end
