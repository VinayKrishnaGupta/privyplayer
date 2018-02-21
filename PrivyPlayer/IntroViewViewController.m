//
//  IntroViewViewController.m
//  PrivyPlayer
//
//  Created by RSTI E-Services on 20/02/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

#import "IntroViewViewController.h"
#import <EAIntroView/EAIntroView.h>

@interface IntroViewViewController ()<EAIntroDelegate>


@end

@implementation IntroViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Seamless Video Playback";
    page1.titleFont = [UIFont fontWithName:@"Georgia-BoldItalic" size:22];
    page1.desc = @"Watch Your Favorite Videos Anywhere";
    page1.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    page1.titlePositionY = 220;
    page1.descPositionY = 200;
  //  page1.bgImage = [UIImage imageNamed:@"VideoIcon"];
   
   
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"Watch Exclusive Videos";
    page2.desc = @"We Brings Some Exclusive Videos for You";
    page2.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
    //page2.bgImage = [UIImage imageNamed:@"VideoIcon"];
    page2.titleFont = [UIFont fontWithName:@"Georgia-BoldItalic" size:22];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]];
    page2.titlePositionY = 220;
    page2.descPositionY = 200;
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"Share Videos With Your Friends";
    page3.desc = @"Liked a Video, Don't Forget to Share";
    page3.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
   // page3.bgImage = [UIImage imageNamed:@"VideoIcon"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3"]];
    page3.titleFont = [UIFont fontWithName:@"Georgia-BoldItalic" size:22];
    page3.titlePositionY = 220;
    page3.descPositionY = 200;

    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"Upload Unlimited Videos Free";
    page4.desc = @"Upload Some Videos to Share With World";
    page4.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
    //page4.bgImage = [UIImage imageNamed:@"VideoIcon"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4"]];
    page4.titleFont = [UIFont fontWithName:@"Georgia-BoldItalic" size:22];
    page4.titlePositionY = 220;
    page4.descPositionY = 200;

    EAIntroView *myIntroView = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    [myIntroView setDelegate:self];
    [myIntroView showInView:self.view animateDuration:3];
   
    
    
    // Do any additional setup after loading the view.
}

- (void)introWillFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    NSLog(@"Intro Will Finish");
   [self performSegueWithIdentifier:@"signUpVC" sender:nil];
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
