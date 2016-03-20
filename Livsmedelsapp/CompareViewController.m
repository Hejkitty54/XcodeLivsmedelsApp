//
//  CompareViewController.m
//  Livsmedelsapp
//
//  Created by ITHS on 2016-03-09.
//  Copyright © 2016 Kozue Wendén. All rights reserved.
//

#import "CompareViewController.h"
#import "LivsmedelTableViewController.h"


@interface CompareViewController ()
@property (weak, nonatomic) IBOutlet UITableView *compareTv;
@property (weak, nonatomic) IBOutlet UITextField *first;
@property (weak, nonatomic) IBOutlet UITextField *second;
@property NSMutableArray* data;
@property (weak, nonatomic) IBOutlet GKBarGraph *graph;
@property (nonatomic) NSMutableArray* dataForGraph;
@property(nonatomic)NSArray* labels;
@end

@implementation CompareViewController

+(CompareViewController*)singletonCVC{
    
    static CompareViewController *theCVC = nil;
    
    if(!theCVC){
        theCVC = [[super allocWithZone:nil]init];
    }
    
    return theCVC;
}

+(id) allocWithZone:(NSZone *)zone{
    return [self singletonCVC];
}
-(NSMutableArray*)firstData{

    if (!_firstData) {
        _firstData =[[NSMutableArray alloc]init];
    }
    return _firstData;
}

-(NSMutableArray*)dataForGraph{
    
    if (!_dataForGraph) {
        _dataForGraph =[[NSMutableArray alloc]init];
    }
    return _dataForGraph;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.compareTv.dataSource = self;
    
    self.data = [LivsmedelTableViewController singletonTVC].aWholeData;
    
    
    //graph
    self.graph.dataSource =self;
    
    self.labels = @[@"water", @"fat", @"protein", @"water", @"fat", @"protein"];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//for tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //get cell
    UITableViewCell *tvcell = [tableView dequeueReusableCellWithIdentifier: @"cid"];
    
    if (tvcell == nil) {
        tvcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier: @"cid"];
    }
    
    // get one food's name
    NSDictionary* oneFood = self.data[[indexPath row]];
    NSString *getFoodName = [oneFood objectForKey:@"name"];
    
    // show name on each cell
    tvcell.textLabel.text = getFoodName;
   
    
    // set tap recognizer
    tvcell.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAndGetName:)];
    [tvcell addGestureRecognizer:tap];
    
    
    return tvcell;
    
}


-(void)tapAndGetName:(UIGestureRecognizer *)gesture {
    
    CGPoint pos = [gesture locationInView:self.compareTv];
    
    NSIndexPath *indexPath = [self.compareTv indexPathForRowAtPoint:pos];
    
    UITableViewCell *cell = [self.compareTv cellForRowAtIndexPath:indexPath];
    
    //get number for the food
    NSDictionary* d =self.data[[indexPath row]];
    NSString* number = [d objectForKey:@"number"];
    
    NSLog(@"something? %@ number? %@",cell.textLabel.text,number);
    
    [self chooseName:(NSString*)cell.textLabel.text number:[number integerValue]];
}

// set name on label when user touch one food(set info also)
-(void)chooseName:(NSString*)name  number:(NSInteger)number {
    
    DataViewController* d = [[DataViewController alloc]init];
    
    
    if ((self.first.text.length>0 && self.second.text.length>0)) {
        NSLog(@"deletes food and new food");
    }
    
    else if (self.first.text.length==0 && self.second.text.length==0) {
        
        self.first.text = name;
        [d getFirstInfoWithNumber:(int)number];
        
    } else if([self.first.text isEqualToString:name] || [self.second.text isEqualToString:name]){

            NSLog(@"you can not choose same name");
    
    } else if (self.first.text.length>0 && self.second.text.length==0){
        
        self.second.text=name;
        [d getSecondInfoWithNumber:(int)number];
        
    } else if (self.second.text.length>0 && self.first.text.length==0){
        
        self.first.text=name;
        [d getFirstInfoWithNumber:(int)number];
        
    }
    
}
- (IBAction)compare:(id)sender {
    
    NSLog(@"first data is %@ ...",self.firstData);
    
    NSLog(@"second data is %@ ...",self.secondData);
    
    self.dataForGraph=@[].mutableCopy;
    
    
    if(self.first.text.length > 0 && self.second.text.length > 0){
    
        for (int i =0; i < self.firstData.count; i++) {
            [self.dataForGraph addObject:[self.firstData objectAtIndex:i]];
        }
        for (int i =0; i < self.secondData.count; i++) {
            [self.dataForGraph addObject:[self.secondData objectAtIndex:i]];
        }
        
        NSLog(@"both is %@ ...",self.dataForGraph);
        
        [self.graph draw];
    
    }else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                       message:@"You have to choose two foods"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [self.view endEditing:YES];
    
}

- (IBAction)clearSecond:(id)sender {
    self.second.text=@"";
}
- (IBAction)clearFirst:(id)sender {
    self.first.text=@"";
}

//for graph
- (NSInteger)numberOfBars{
    return self.dataForGraph.count;
}
- (NSNumber *)valueForBarAtIndex:(NSInteger)index{
    
    return [self.dataForGraph objectAtIndex:index];
}
-(NSString *)titleForBarAtIndex:(NSInteger)index{
    

    return [self.labels objectAtIndex:index];
}

- (UIColor *)colorForBarAtIndex:(NSInteger)index {
    id colors = @[[UIColor colorWithRed:0.55 green:0.70 blue:0.95 alpha:1.0],
                  [UIColor colorWithRed:0.96 green:0.72 blue:0.36 alpha:1.0],
                  [UIColor colorWithRed:0.95 green:0.40 blue:0.40 alpha:1.0],
                  [UIColor colorWithRed:0.55 green:0.70 blue:0.95 alpha:1.0],
                  [UIColor colorWithRed:0.96 green:0.72 blue:0.36 alpha:1.0],
                  [UIColor colorWithRed:0.95 green:0.40 blue:0.40 alpha:1.0]
                  ];
    return [colors objectAtIndex:index];
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
