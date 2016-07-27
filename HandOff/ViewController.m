//
//  ViewController.m
//  HandOff
//
//  Created by Alex on 16/7/26.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSUserActivityDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (nonatomic ,strong) NSUserActivity *userActivity;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _userActivity = [[NSUserActivity alloc]initWithActivityType:@"com.alex.handoffdemo"];
    _userActivity.title = @"文字共享";
    _userActivity.delegate = self;
    [_userActivity setWebpageURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    //再写一个mac app没必要 用url的话 mac chrome会打开这个url 可以自己定制网页
    _userActivity.userInfo = @{};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchTestButton:(id)sender {
    [_userActivity becomeCurrent];
    _userActivity.needsSave = YES;
}
- (IBAction)touchCopyButton:(id)sender {
    [[UIPasteboard generalPasteboard]setString:_inputTextView.text];
}

- (void)userActivityWillSave:(NSUserActivity *)userActivity{
    NSDictionary *dic = @{@"text":_inputTextView.text};
    [userActivity addUserInfoEntriesFromDictionary:dic];

}

- (IBAction)touchBackGroundView:(id)sender {
    [_inputTextView resignFirstResponder];
}

- (void)restoreUserActivityState:(NSUserActivity *)activity{
    NSDictionary *dic = activity.userInfo;
    self.inputTextView.text = [dic objectForKey:@"text"];
}

@end
