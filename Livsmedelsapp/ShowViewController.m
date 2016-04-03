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
@property NSDictionary* foodObject;
@end

@implementation ShowViewController{
    int num;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataViewController* d =[[DataViewController alloc]init];
    
    // gets a number of this food from saved dictionary
    num = [[self.oneFood objectForKey:@"number"] intValue];
    
    // shows detail
    [d getDetailWithNumber:num uiVC:self];
    
    //sets units
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
    
    UIBarButtonItem *camera = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                               target:self
                               action:@selector(photo:)];
    [[UIBarButtonItem appearance] setTintColor:[UIColor orangeColor]];
    
    // sets a camera icon on the navigation bar
    self.navigationItem.rightBarButtonItem = camera;
    
    // sets foodObject
    self.foodObject = @{@"name":self.title,@"number":[NSString stringWithFormat:@"%d",num]};
    
    NSInteger length = [FavoriteTableViewController singletonFav].favorites.count;
    // if this food is in favorite list switch button will be ON.
    for (int i =0; i < length ; i++){
        if ([[FavoriteTableViewController singletonFav].favorites containsObject:self.foodObject]){
            [self.isFavorite setOn:YES];
        }
    }
}


- (IBAction)isFavorite:(id)sender {
    
    if (self.isFavorite.on) {
        // adds foodObject to favorite list
        if (![[FavoriteTableViewController singletonFav].favorites containsObject:self.foodObject]) {
            
            [[FavoriteTableViewController singletonFav].favorites addObject:self.foodObject];
            
            [[FavoriteTableViewController singletonFav].tableView reloadData];
            
            //shows a message
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Message"
                                                                           message:[NSString stringWithFormat:@"%@ is added to favorite list",self.title]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        } 
    } else {
        // deletes foodObject from favorite list.
        if ([[FavoriteTableViewController singletonFav].favorites containsObject:self.foodObject]) {
              
              [[FavoriteTableViewController singletonFav].favorites removeObject:self.foodObject];
              [[FavoriteTableViewController singletonFav].tableView reloadData];
            
            //shows a message
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Message"
                                                                           message:[NSString stringWithFormat:@"%@ is removed from favorite list",self.title]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
          }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photo:(id)sender {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Camera"
                                                                   message:@"You can choose from"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* takePhoto = [UIAlertAction actionWithTitle:@"Take photo" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                                                  
                                                                  UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                                                                  picker.delegate = self;
                                                                  [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
                                                                  [self presentViewController:picker animated:YES completion:NULL];
                                                              } else{
                                                                  
                                                                  //shows a message
                                                                  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Message"
                                                                                                                                 message:@"You don't have a camera."
                                                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                                                                  
                                                                  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                                                        handler:^(UIAlertAction * action) {}];
                                                                  
                                                                  [alert addAction:defaultAction];
                                                                  [self presentViewController:alert animated:YES completion:nil];
                                                              }
                                                          
                                                          }];
    UIAlertAction* choosePhoto = [UIAlertAction actionWithTitle:@"Choose from library" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          
                                                              UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                                                              picker.delegate = self;
                                                              picker.allowsEditing = YES;
                                                              [self presentViewController:picker animated:YES completion:nil];
                                                          
                                                          }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {}];
    
    [alert addAction:takePhoto];
    [alert addAction:choosePhoto];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
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
