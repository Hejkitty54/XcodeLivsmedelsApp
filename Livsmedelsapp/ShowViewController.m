//
//  ShowViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-02-28.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "ShowViewController.h"
#import "DataViewController.h"
#import "FavoriteTableViewController.h"

@interface ShowViewController ()
@property (weak, nonatomic) IBOutlet UILabel *star;

@end

@implementation ShowViewController{
    int num;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    
    
    CGPoint touchPosition = [sender locationInView:self.view];
    
    float diffX = touchPosition.x - self.star.center.x;
    float diffY = touchPosition.y - self.star.center.y;
    float distance = sqrt(diffX*diffX + diffY*diffY);
    float t = distance/300.0f;
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:t];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.star.center = touchPosition;
    
    [UIView commitAnimations];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataViewController* d =[[DataViewController alloc]init];
    
    // get a number from saved dictionary @{name number}
    num = [[self.oneFood objectForKey:@"number"] intValue];
    
    // shows detail
    [d getDetailWithNumber:num uiVC:self];
    
    
    //set unit
    NSDictionary* getProteinUnit;
    NSDictionary* getFatUnit;
    NSDictionary* getVitaminCUnit;
    NSDictionary* getSaltUnit;
    NSDictionary* getZinkUnit;
    
    
    for(NSDictionary* dict in self.aWholeDataUnit)
    {
        if([[dict objectForKey:@"slug"] isEqualToString: @"protein"])
        {
            getProteinUnit= dict;
        }
        if([[dict objectForKey:@"slug"] isEqualToString: @"fat"])
        {
            getFatUnit= dict;
        }
        if([[dict objectForKey:@"slug"] isEqualToString: @"vitaminC"])
        {
            getVitaminCUnit= dict;
        }
        if([[dict objectForKey:@"slug"] isEqualToString: @"salt"])
        {
            getSaltUnit= dict;
        }
        if([[dict objectForKey:@"slug"] isEqualToString: @"zink"])
        {
            getZinkUnit= dict;
        }
    }
    
    self.proteinUnit.text = [getProteinUnit objectForKey:@"unit"];
    self.fatUnit.text = [getFatUnit objectForKey:@"unit"];
    self.vitaminCUnit.text =[getVitaminCUnit objectForKey:@"unit"];
    self.saltUnit.text =[getSaltUnit objectForKey:@"unit"];
    self.zinkUnit.text =[getZinkUnit objectForKey:@"unit"];
    
    
    //camera
    UIImage *cachedImage = [UIImage imageWithContentsOfFile:[self imagePath]];
    
    if (cachedImage) {
        self.foodImg.image = cachedImage;
    } else {
        NSLog(@"No image found");
    }
    
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(M_PI / 180) * 360];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.star.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
   
    
}


- (IBAction)isFavorite:(id)sender {
    
    NSDictionary* foodObject = @{@"name":self.title,@"number":[NSString stringWithFormat:@"%d",num]};
  
    // if favorite is on it is added to favorites list in Favorite table view.
    if (self.isFavorite.on) {
        
        if (![[FavoriteTableViewController singletonFav].favorites containsObject:foodObject]) {
            
            [[FavoriteTableViewController singletonFav].favorites addObject:foodObject];
            
            [[FavoriteTableViewController singletonFav].tableView reloadData];
            
            NSLog(@"favorite %@ is added",self.title);
        } else{
            // pop up ? in label?
            NSLog(@"%@ is already added to favorite",self.title);
        }
    } else {
        
        if ([[FavoriteTableViewController singletonFav].favorites containsObject:foodObject]) {
              
              [[FavoriteTableViewController singletonFav].favorites removeObject:foodObject];
              [[FavoriteTableViewController singletonFav].tableView reloadData];
          }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)takePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
}
- (IBAction)choosePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.foodImg setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    BOOL succes = [imageData writeToFile:[self imagePath] atomically:YES];
    
    if (succes) {
        NSLog(@"saved");
    }else {
        NSLog(@"failed to save");
    }
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString*)imagePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    
    return [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.title]];
    
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
