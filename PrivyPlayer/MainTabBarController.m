//
//  MainTabBarController.m
//  PrivyPlayer
//
//  Created by RSTI E-Services on 14/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    tabBarItem1.title = @"Home";
    tabBarItem2.title = @"History";
    tabBarItem3.title = @"Recent";
    tabBarItem4.title = @"More";
    UIImage *image1 = [[UIImage imageNamed:@"homeicon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [tabBarItem1 setImage:image1];
    
    tabBarItem2.image = [[UIImage imageNamed:@"historyicon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    tabBarItem3.image = [[UIImage imageNamed:@"recentuploadicon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem4.image = [[UIImage imageNamed:@"profileicon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    NSShadow *shadow = [NSShadow new];
    //    [shadow setShadowColor : [UIColor colorWithWhite:1.0f alpha:0.750f]];
    //    [shadow setShadowOffset : CGSizeMake(1.0f, 1.0f)];
    for (UITabBarItem* item in self.tabBar.items)
    {
        [item setImageInsets: UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName : [UIFont fontWithName:@"AmericanTypewriter-SemiBold" size:12.0f],
                                                        NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                                        }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName : [UIFont fontWithName:@"Helvetica Neue" size:12.0f],
                                                        NSForegroundColorAttributeName : [UIColor whiteColor],
                                                        
                                                        }
                                             forState:UIControlStateSelected];
    
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
