//
//  DKModalImageBrowser.m
//
//  Created by Daniel on 3/21/14.
//
//


#import "DKModalImageBrowser.h"
#import "DKImageBrowser.h"


@implementation DKModalImageBrowser

- (id)init {
    self.imageBrowser = [[DKImageBrowser alloc] init];
    
    if (self = [super initWithRootViewController:self.imageBrowser]) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DKModalActionDone)];
        
        self.imageBrowser.navigationItem.rightBarButtonItem = doneButton;
        self.imageBrowser.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.224 green:0.286 blue:0.671 alpha:1] ;
        
        //self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:26/255.0f green:188/255.0f blue:156/255.0f alpha:1.0f];
        self.imageBrowser.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        
    }
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    
    self.imageBrowser.title = self.title;
}


- (void)DKModalActionDone {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
