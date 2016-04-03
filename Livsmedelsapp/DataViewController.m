//
//  DataTestViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-02.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchTerm;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// gets all data from matAPI and saves it in NSMutable array i LivsmedelTableViewController
-(void)getAllData{
    
    NSURL *url = [NSURL URLWithString:@"http://www.matapi.se/foodstuff?nutrient"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                if (error) { NSLog(@"Error: %@",error); return;}
                                                
                                                NSError *jsonParseError = nil;
                                                
                                                NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
                                                
                                                if(jsonParseError){
                                                    NSLog(@"failed to parse data : %@",jsonParseError);
                                                    return;
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [LivsmedelTableViewController singletonTVC].aWholeData=result.mutableCopy;
                                                    [[LivsmedelTableViewController singletonTVC].tableView reloadData];
                                                    
                                                });
                                            }];
    [task resume];
}

// gets all units from matAPI and sets it to aWholedataUnit i LivsmedelTableViewController and FavoriteTableViewController.
-(void)getUnit{
    
    NSString *s = [NSString stringWithFormat:@"http://www.matapi.se/nutrient"];
    NSURL *url = [NSURL URLWithString:s];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                if (error) { NSLog(@"Error: %@",error); return;}
                                                
                                                NSError *jsonParseError = nil;
                                                
                                                NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
                                                
                                                if(jsonParseError){
                                                    NSLog(@"failed to parse data : %@",jsonParseError);
                                                    return;
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    
                                                    [LivsmedelTableViewController singletonTVC].aWholeDataUnit=result.mutableCopy;
                                                    [[LivsmedelTableViewController singletonTVC].tableView reloadData];
                                                    [FavoriteTableViewController singletonFav].aWholeDataUnit=result.mutableCopy;
                                                    [[FavoriteTableViewController singletonFav].tableView reloadData];
                                                    
                                                });
                                                
                                            }];
    
    [task resume];
    
}

// sets energi and protein for every cell in LivsmedelTableViewContoller
-(void) getDetailWithNumberForCell:(int)number cell:(CustomTableViewCell*)cell {
    
    NSString *s = [NSString stringWithFormat:@"http://www.matapi.se/foodstuff/%d",number];
    NSURL *url = [NSURL URLWithString:s];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                if (error) { NSLog(@"Error: %@",error); return;}
                                                
                                                NSError *jsonParseError = nil;
                                                
                                                NSDictionary *detail = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
                                                
                                                if(jsonParseError){
                                                    NSLog(@"failed to parse data : %@",jsonParseError);
                                                    return;
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    // gets each details
                                                    NSDictionary* nutrientValues = [detail objectForKey:@"nutrientValues"];
                                                    NSString* energi = [nutrientValues objectForKey:@"energyKj"];
                                                    NSString* protein = [nutrientValues objectForKey:@"protein"];
                                                    
                                                    // in a case number is too huge
                                                    if ([NSString stringWithFormat:@"%@",protein].length > 4) {
                                                        protein = [[NSString stringWithFormat:@"%@",protein] substringToIndex:4];
                                                    }
                                                    
                                                    // sets data
                                                    cell.energi.text=[NSString stringWithFormat:@"%@",energi];
                                                    cell.protein.text= [NSString stringWithFormat:@"%@",protein];
                                                    
                                                    [[LivsmedelTableViewController singletonTVC].cell reloadInputViews];
                                                });
                                                
                                            }];
    [task resume];
}

// sets and shows nutritional values in ShowViewController or FavoriteDetailViewController
-(void) getDetailWithNumber:(int)number uiVC:(UIViewController*)vc{
    
    NSString *s = [NSString stringWithFormat:@"http://www.matapi.se/foodstuff/%d",number];
    NSURL *url = [NSURL URLWithString:s];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                if (error) { NSLog(@"Error: %@",error); return; }
                                                
                                                NSError *jsonParseError = nil;
                                                
                                                NSDictionary *detail = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
                                                
                                                if(jsonParseError){
                                                    NSLog(@"failed to parse data : %@",jsonParseError);
                                                    return;
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    // gets each details
                                                    NSDictionary* nutrientValues = [detail objectForKey:@"nutrientValues"];
                                                    
                                                    NSString* protein = [nutrientValues objectForKey:@"protein"];
                                                    NSString* fett = [nutrientValues objectForKey:@"fat"];
                                                    NSString* vitamin = [nutrientValues objectForKey:@"vitaminC"];
                                                    NSString* salt = [nutrientValues objectForKey:@"salt"];
                                                    NSString* zink = [nutrientValues objectForKey:@"zink"];
                                                    
                                                    // in a case number is too huge
                                                    if ([NSString stringWithFormat:@"%@",fett].length > 4) {
                                                        fett = [[NSString stringWithFormat:@"%@",fett] substringToIndex:4];
                                                    } else if ([NSString stringWithFormat:@"%@",protein].length > 4) {
                                                        protein = [[NSString stringWithFormat:@"%@",protein] substringToIndex:4];
                                                    }
                                                    
                                                    ShowViewController* svc = (ShowViewController*)vc;
                                                    FavoriteDetailViewController* fvc = (FavoriteDetailViewController*)vc;
                                                    
                                                    if ([vc isKindOfClass:[ShowViewController class]]) {
                                                        
                                                        svc.protein.text= [NSString stringWithFormat:@"%@",protein];;
                                                        svc.fat.text= [NSString stringWithFormat:@"%@",fett];
                                                        svc.vitamin.text= [NSString stringWithFormat:@"%@",vitamin];
                                                        svc.salt.text = [NSString stringWithFormat:@"%@",salt];
                                                        svc.zink.text = [NSString stringWithFormat:@"%@",zink];
                                                        
                                                        // calculates healthy value
                                                        float n = [protein floatValue] + [vitamin floatValue] - [salt floatValue];
                                                        svc.calculate.text = [[NSString stringWithFormat:@"%f",n] substringToIndex:4];
                                                        
                                                    } else if ([vc isKindOfClass:[FavoriteDetailViewController class]]){
                                                        
                                                        fvc.protein.text= [NSString stringWithFormat:@"%@",protein];
                                                        fvc.fat.text= [NSString stringWithFormat:@"%@",fett];
                                                        fvc.vitaminC.text= [NSString stringWithFormat:@"%@",vitamin];
                                                        fvc.salt.text = [NSString stringWithFormat:@"%@",salt];
                                                        fvc.zink.text = [NSString stringWithFormat:@"%@",zink];
                                                        
                                                        // calculates healthy value
                                                        float n = [protein floatValue]+[vitamin floatValue]-[salt floatValue];
                                                        fvc.healthy.text = [[NSString stringWithFormat:@"%f",n] substringToIndex:4];
                                                    }
                                                });
                                            }];
    [task resume];
}

// gets a data of left side graph and sets it in CompareViewController
-(void) getFirstInfoWithNumber:(int)number{
    
    NSString *s = [NSString stringWithFormat:@"http://www.matapi.se/foodstuff/%d",number];
    NSURL *url = [NSURL URLWithString:s];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                if (error) { NSLog(@"Error: %@",error); return;}
                                                
                                                NSError *jsonParseError = nil;
                                                
                                                NSDictionary *detail = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
                                                
                                                if(jsonParseError){
                                                    NSLog(@"failed to parse data : %@",jsonParseError);
                                                    return;
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    // gets each details
                                                    NSDictionary* nutrientValues = [detail objectForKey:@"nutrientValues"];
                                                    
                                                    NSString* water = [nutrientValues objectForKey:@"water"];
                                                    NSString* fat = [nutrientValues objectForKey:@"fat"];
                                                    NSString* salt = [nutrientValues objectForKey:@"salt"];
                                                    
                                                    [CompareViewController singletonCVC].firstData = @[water,fat,salt].mutableCopy;
                                                });
                                                
                                            }];
    [task resume];
    
}

-(void) getSecondInfoWithNumber:(int)number{
    
    NSString *s = [NSString stringWithFormat:@"http://www.matapi.se/foodstuff/%d",number];
    NSURL *url = [NSURL URLWithString:s];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                if (error) { NSLog(@"Error: %@",error); return;}
                                                
                                                NSError *jsonParseError = nil;
                                                
                                                NSDictionary *detail = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
                                                
                                                if(jsonParseError){
                                                    NSLog(@"failed to parse data : %@",jsonParseError);
                                                    return;
                                                }
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    // gets each details
                                                    NSDictionary* nutrientValues = [detail objectForKey:@"nutrientValues"];
                                                    
                                                    NSString* water = [nutrientValues objectForKey:@"water"];
                                                    NSString* fat = [nutrientValues objectForKey:@"fat"];
                                                    NSString* salt = [nutrientValues objectForKey:@"salt"];
                                                    
                                                    [CompareViewController singletonCVC].secondData = @[water,fat,salt].mutableCopy;
                                                    
                                                });
                                                
                                            }];
    [task resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
