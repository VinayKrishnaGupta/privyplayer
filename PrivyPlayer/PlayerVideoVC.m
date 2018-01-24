//
//  PlayerVideoVC.m
//  PrivyPlayer
//
//  Created by RSTI E-Services on 23/01/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

#import "PlayerVideoVC.h"



@interface PlayerVideoVC () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *myWebView;



@end

@implementation PlayerVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _myWebView.delegate = self;
    
    NSString *url= @"https://gig.gs/videos/360p/9514810031.mp4";
    
    self.myWebView.allowsInlineMediaPlayback = YES;
    self.myWebView.scrollView.bounces = NO;
    self.myWebView.mediaPlaybackRequiresUserAction = NO;
    
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
   
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
