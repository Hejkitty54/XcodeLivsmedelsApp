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
- (IBAction)getData:(id)sender {
    
    
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



-(void) getDetailWithNumber:(int)number{
    
  
    
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
                NSString* fett = [nutrientValues objectForKey:@"fat"];
                NSString* vitamin = [nutrientValues objectForKey:@"vitaminC"];
                
                //ShowViewController* s = [[ShowViewController alloc]init];
                [ShowViewController singletonSVC].protein.text= [NSString stringWithFormat:@"%@",protein];
                [ShowViewController singletonSVC].fat.text= [NSString stringWithFormat:@"%@",fett];
                [ShowViewController singletonSVC].vitamin.text= [NSString stringWithFormat:@"%@",vitamin];
                [[ShowViewController singletonSVC].view reloadInputViews];
                
                
                //[LivsmedelTableViewController singletonTVC].cell.foodName.text=energi;
                //NSDictionary* nutritions = @{@"number":[NSString stringWithFormat:@"%lu", number],@"energi":energi,
                // @"protein":protein,@"fat":fett,@"vitamin":vitamin};
                //[[LivsmedelTableViewController singletonTVC].energiData addObject:nutritions];
                
                //[LivsmedelTableViewController singletonTVC].cell.energi.text=energi;
                
                //[[LivsmedelTableViewController singletonTVC].tableView reloadData];
                
            });
            
        }];
    [task resume];
    
}

-(void) getDetailWithNumberForCell:(int)number{
    
    
    
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
                                                   
                                            
                                                    [LivsmedelTableViewController singletonTVC].cell.energi.text=[NSString stringWithFormat:@"%@",energi];
                                                    
                                                    [LivsmedelTableViewController singletonTVC].cell.protein.text= [NSString stringWithFormat:@"%@",protein];
                                                    [[LivsmedelTableViewController singletonTVC].view reloadInputViews];
                                                    
                                                    
                                                    //[[LivsmedelTableViewController singletonTVC].tableView reloadData];
                                                    
                                                });
                                                
                                            }];
    [task resume];
    
}


-(void) testReturn:(NSString*)str{
    
    self.testString = str;
}

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
