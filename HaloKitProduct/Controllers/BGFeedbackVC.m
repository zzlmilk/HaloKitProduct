//
//  BGFeedbackVC.m
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/11.
//  Copyright © 2017年 范博. All rights reserved.
//

#import "BGFeedbackVC.h"
#import "HttpRequest.h"
#define GZScreenWidth [UIScreen mainScreen].bounds.size.width

@interface BGFeedbackVC ()<UITextViewDelegate>



@end

@implementation BGFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(GZScreenWidth * 0.3, 20, GZScreenWidth * 0.4, 44)];
    [self.view addSubview:la];
    la.text = @"意见反馈";
    self.title = @"意见反馈";
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.GZplaceholder = @"请输入少于200字的介绍";
    [self.view addSubview:_textView];
    
    _numLabel.textAlignment = NSTextAlignmentRight;
    _numLabel.text = @"0/200";
    _numLabel.backgroundColor = [UIColor whiteColor];
    self.tijiaoBtn.layer.cornerRadius = 2;
    self.tijiaoBtn.layer.masksToBounds = true;
    self.tijiaoBtn.alpha = 0.5;
    self.tijiaoBtn.enabled = false;
}


//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    self.tijiaoBtn.alpha = 1;
    self.tijiaoBtn.enabled = true;

    NSInteger wordCount = textView.text.length;
    self.numLabel.text = [NSString stringWithFormat:@"%ld/200",(long)wordCount];
    [self wordLimit:textView];
}

#pragma mark 超过30字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 200) {
        NSLog(@"%ld",text.text.length);
        self.textView.editable = YES;
    }
    else{
        self.textView.editable = NO;
        
    }
    return nil;
}





- (IBAction)tijiaoBtn:(id)sender {
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];

    [[HttpRequest sharedInstance] POSTHeader:@"http://api.halokit.cn:7070/halokit/v2/user/feedback" dict:@{@"text":self.textView.text} AndHeader:token succeed:^(id data) {
        NSLog(@"ssssssss:%@",data);
        [self.navigationController popViewControllerAnimated:true];
    } failure:^(NSError *error) {
        NSLog(@"ssssssss:%@",error);

        
    }];
    
}


@end
