//
//  ShowViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-02-28.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "ShowViewController.h"
#import "DataViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController



+(ShowViewController*)singletonSVC{
    
    static ShowViewController *theSVC = nil;
    
    if(!theSVC){
        theSVC = [[super allocWithZone:nil]init];
    }
    
    return theSVC;
}

+(id) allocWithZone:(NSZone *)zone{
    return [self singletonSVC];
}

-(id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataViewController* d =[[DataViewController alloc]init];
    
    //self.protein.text = [NSString stringWithFormat:@"%@",[self.oneFood objectForKey:@"number"]];
    
    
    int num = [[self.oneFood objectForKey:@"number"] intValue];
    NSLog(@"numnuum is %d",num);

    [d getDetailWithNumber:num];
    
    
    // Do any additional setup after loading the view.
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
