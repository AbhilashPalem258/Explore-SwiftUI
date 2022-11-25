//
//  PersonObjCVC.m
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 07/11/22.
//

#import "PersonObjCVC.h"
#import "Explore_SwiftUI-Swift.h"

@interface PersonObjCVC ()

@end

@implementation PersonObjCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor brownColor]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(dismiss:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor blackColor]];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    Employees *s = [[Employees alloc] init];
    
    
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(91, 15, 300, 40)];
    fromLabel.text = [s getEmployeeNames];
    [self.view addSubview:fromLabel];
}

- (void)dismiss:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
