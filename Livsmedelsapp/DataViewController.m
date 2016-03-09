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
     self.testString=@"";
    // Do any additional setup after loading the view.
}

- (IBAction)getName:(id)sender {
    
    
    [self.view endEditing:YES];
    
    NSString *s = [NSString stringWithFormat:@"http://www.matapi.se/foodstuff?query=%@",self.searchTerm.text];
    
    //NSString *escaped = [s stringByAddingPercentEncodingWithAllowedCharacters:];
    
    NSURL *url = [NSURL URLWithString:s];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                
        
        if (error) {
            NSLog(@"Error: %@",error);
            return;
        }

                                                
        NSError *jsonParseError = nil;
        
        
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
        
        
        if(jsonParseError){
            NSLog(@"failed data : %@",jsonParseError);
            return;
            
        }
        // get all info about fisk
        NSLog(@"%@",result);
                                                
            // shows all names which has "fisk" in name
             dispatch_async(dispatch_get_main_queue(), ^{

                 
                 for( id obj in result){
                     //get each name
                     NSString* name = [obj objectForKey:@"name"];
                     
                     NSLog(@"%@",name);
                     
                     
                     
                     //get each detaljer
                     NSString* number = [obj objectForKey:@"number"];
                     
                     //[self getDetailWithNumber: number.intValue];
                     
                     NSLog(@"%@",number);
                     
                 }
             
             });
            
        }];
    [task resume];
}

-(void) sendDetailWithNumber:(int)number{
    
    [self.view endEditing:YES];
    
    NSString *s = [NSString stringWithFormat:@"http://www.matapi.se/foodstuff/%d",number];
    
    //NSString *escaped = [s stringByAddingPercentEncodingWithAllowedCharacters:];
    
    NSURL *url = [NSURL URLWithString:s];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                
                                                
                                                if (error) {
                                                    NSLog(@"Error: %@",error);
                                                    return;
                                                }
                                                
                                                
                                                NSError *jsonParseError = nil;
                                                
                                                
                                                NSDictionary *detail = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
                                                
                                                
                                                if(jsonParseError){
                                                    NSLog(@"failed data : %@",jsonParseError);
                                                    return;
                                                    
                                                }
                                                NSLog(@"what we got: %@",detail);
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    // get each detaljer
                                                    
                                                    NSDictionary* nutrientValues = [detail objectForKey:@"nutrientValues"];
                                                    NSLog(@" nutrition is %@",nutrientValues);
                                                    NSString* energi = [nutrientValues objectForKey:@"energyKj"];
                                                    NSLog(@" energi is %@",energi);
                                                    NSString* protein = [nutrientValues objectForKey:@"protein"];
                                              
                                                    
                                                    NSDictionary* nutrition =@{@"Energi":energi,@"Protein":protein};
                                                    
                                                    [[LivsmedelTableViewController singletonTVC].aWholeDataNutritions addObject:nutrition];
                                                  
                                                    [[LivsmedelTableViewController singletonTVC].view reloadInputViews];
                                            
                                                    
                                                });
                                                
                                            }];
    [task resume];
    
}


// show protein and energi i ShowViewController
-(void) getDetailWithNumber:(int)number uiVC:(UIViewController*)vc{
    
    [self.view endEditing:YES];
    
    NSString *s = [NSString stringWithFormat:@"http://www.matapi.se/foodstuff/%d",number];
    
    //NSString *escaped = [s stringByAddingPercentEncodingWithAllowedCharacters:];
    
    NSURL *url = [NSURL URLWithString:s];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
            if (error) { NSLog(@"Error: %@",error); return; }
            
            
            NSError *jsonParseError = nil;
            
            
            NSDictionary *detail = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
            
            
            if(jsonParseError){
                NSLog(@"failed data : %@",jsonParseError);
                return;
                
            }
             NSLog(@"what we got: %@",detail);
            dispatch_async(dispatch_get_main_queue(), ^{
                // get each detaljer
                
                NSDictionary* nutrientValues = [detail objectForKey:@"nutrientValues"];
                NSLog(@" nutrition is %@",nutrientValues);
                NSString* energi = [nutrientValues objectForKey:@"energyKj"];
                NSLog(@" energi is %@",energi);
                NSString* protein = [nutrientValues objectForKey:@"protein"];
                NSString* fett = [nutrientValues objectForKey:@"fat"];
                NSString* vitamin = [nutrientValues objectForKey:@"vitaminC"];
                
                ShowViewController* svc = (ShowViewController*)vc;
                FavoriteDetailViewController* fvc = (FavoriteDetailViewController*)vc;
                
                    if ([vc isKindOfClass:[ShowViewController class]]) {
                        
                        svc.protein.text= [NSString stringWithFormat:@"%@",protein];
                        svc.fat.text= [NSString stringWithFormat:@"%@",fett];
                        svc.vitamin.text= [NSString stringWithFormat:@"%@",vitamin];
                        NSLog(@"körs här?");
                    
                    } else if ([vc isKindOfClass:[FavoriteDetailViewController class]]){
                    
                        fvc.detail.text =[NSString stringWithFormat:@"%@",nutrientValues];
                    NSLog(@"och körs här?");
                    
                    }
                
            });
            
        }];
    [task resume];
    
}

// sets energi and protein for every cell in LivsmedelTableViewContoller
-(void) getDetailWithNumberForCell:(int)number cell:(CustomTableViewCell*)cell {
    
    [self.view endEditing:YES];
    
    NSString *s = [NSString stringWithFormat:@"http://www.matapi.se/foodstuff/%d",number];
    
    //NSString *escaped = [s stringByAddingPercentEncodingWithAllowedCharacters:];
    
    NSURL *url = [NSURL URLWithString:s];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
                                                
            
            if (error) {
                NSLog(@"Error: %@",error);
                return;
            }
            
            
            NSError *jsonParseError = nil;
            
            
            NSDictionary *detail = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
            
            
            if(jsonParseError){
                NSLog(@"failed data : %@",jsonParseError);
                return;
                
            }
            //NSLog(@"what we got: %@",detail);
            dispatch_async(dispatch_get_main_queue(), ^{
                // get each detaljer
                
                NSDictionary* nutrientValues = [detail objectForKey:@"nutrientValues"];
                NSLog(@" nutrition is %@",nutrientValues);
                NSString* energi = [nutrientValues objectForKey:@"energyKj"];
                NSLog(@" energi is %@",energi);
                NSString* protein = [nutrientValues objectForKey:@"protein"];
               
                // skicka med cell istället för singleton
                cell.energi.text=[NSString stringWithFormat:@"%@",energi];
      
                cell.protein.text= [NSString stringWithFormat:@"%@",protein];
                
                 NSLog(@"test if there is protein %@ %@",[LivsmedelTableViewController singletonTVC].cell.protein.text,[NSString stringWithFormat:@"%@",protein]);
                
                [[LivsmedelTableViewController singletonTVC].cell reloadInputViews];
                
            });
            
        }];
    [task resume];
    
}

// get all data from internet and save it in NSMutable array i LivsmedelTableViewController
-(void)getAllData{

    [self.view endEditing:YES];
    
    NSURL *url = [NSURL URLWithString:@"http://www.matapi.se/foodstuff?nutrient"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                
        if (error) {
            NSLog(@"Error: %@",error);
            return;
        }
        
        NSError *jsonParseError = nil;
        
        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
        
        if(jsonParseError){
            NSLog(@"failed data : %@",jsonParseError);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
          
            [LivsmedelTableViewController singletonTVC].aWholeData=result.mutableCopy;
            [[LivsmedelTableViewController singletonTVC].tableView reloadData];
            
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
