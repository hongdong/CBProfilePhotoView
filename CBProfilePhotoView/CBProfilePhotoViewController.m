//
//  CBProfilePhotoViewController.m
//  CBProfilePhotoView
//
//  Created by CHEN BO on 7/7/14.
//  Copyright (c) 2014 airbob.github.io. All rights reserved.
//

#import "CBProfilePhotoViewController.h"

@interface CBProfilePhotoViewController (){
    NSArray * imageArray;
    NSMutableArray * dataArray;
    
}

@end

@implementation CBProfilePhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //this is a static array of the pictures availabe in local
    imageArray = [[NSArray alloc]initWithObjects:
                  @"profile1.png",
                  @"profile2.png",
                  @"profile3.png",
                  @"profile4.png",
                  @"profile5.png",
                  @"profile6.png",
                  nil];
    //this is the data source of the collection view, it will change based on user behaviors
    dataArray = [[NSMutableArray alloc]initWithObjects:
                 @"profile1.png",
                 @"profile2.png",
                 @"profile3.png",
                 @"profile4.png",
                 @"profile5.png",
                 @"profile6.png",
                 @"plus.png",
                 nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CBProfilePhotoViewCell *myCell = [collectionView
                                 dequeueReusableCellWithReuseIdentifier:@"profilePhotoCell"
                                 forIndexPath:indexPath];
    
    NSString * imageName = [dataArray objectAtIndex:[indexPath row]];
    [myCell.profilePhoto setImage:[UIImage imageNamed:imageName]];
    myCell.profilePhoto.tag = [indexPath row];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    myCell.profilePhoto .userInteractionEnabled = YES;
    [myCell.profilePhoto  addGestureRecognizer:singleTap];
    myCell.closeButton.tag = [indexPath row];
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Edit"])
    {
        [myCell.closeButton setHidden:YES];
    }
    else {
        if ([indexPath row] != (dataArray.count - 1)){
            [myCell.closeButton setHidden:NO];
        }
        else {
            [myCell.closeButton setHidden:YES];
        }
        
    }
    
    [myCell.closeButton addTarget:self action:@selector(deletePhoto:)
     forControlEvents:UIControlEventTouchUpInside];
    return myCell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 8, 10, 8);
}


- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    if (index == (dataArray.count -1) )
    {
        NSLog(@"implement your method here, for plus action");
        //here we just add a random image from local
        NSString *tempImageName = [imageArray objectAtIndex:(arc4random() % [imageArray count])];
        [dataArray insertObject:tempImageName atIndex:[dataArray count] - 1];
        [self.collectionView reloadData];
    }
    else {
        NSLog(@"implement your method here, for normal image action");
        //show a photo browser if it is normal photo
        DKModalImageBrowser *modalImageBrowser = [[DKModalImageBrowser alloc] init];
        // note: use modalImageBrowser.imageBrowser to set data source, customize
        NSMutableArray *browserArray = [[NSMutableArray alloc] initWithObjects:
                                     [UIImage imageNamed:@"profile1.png"],
                                     [UIImage imageNamed:@"profile2.png"],
                                     [UIImage imageNamed:@"profile3.png"],
                                     [UIImage imageNamed:@"profile4.png"],
                                     [UIImage imageNamed:@"profile5.png"],
                                     [UIImage imageNamed:@"profile6.png"],
                                     nil];
        modalImageBrowser.imageBrowser.DKImageDataSource = browserArray;
        [self presentViewController:modalImageBrowser animated:YES completion:nil];
        
    }
    
}

- (void)deletePhoto: (UIButton *)sender{
    [dataArray removeObjectAtIndex:sender.tag];
    [self.collectionView reloadData];
}


- (IBAction)editProfilePhoto:(UIBarButtonItem *)sender {

    
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Edit"])
    {
        self.navigationItem.rightBarButtonItem.title= @"Done";
        for(CBProfilePhotoViewCell *cell in self.collectionView.visibleCells)
        {
            
            NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
            if ([indexPath row] != (dataArray.count - 1)){
                [cell.closeButton setHidden:NO];
            }
        }
    }
    else {
        self.navigationItem.rightBarButtonItem.title= @"Edit";
        [self.collectionView reloadData];
    }
}
@end
