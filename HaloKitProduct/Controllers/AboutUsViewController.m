//
//  AboutUsViewController.m
//  可点
//
//  Created by jimZT on 16/10/19.
//  Copyright © 2016年 赵东明. All rights reserved.
//

#import "AboutUsViewController.h"
#import "BGAboutUsCell.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
    self.title =  @"关于我们";//Current version
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"BGAboutUsCell" bundle:nil] forCellReuseIdentifier:@"BGAboutUsCell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGAboutUsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BGAboutUsCell"];
    return cell;
}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 333;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    
}


//一进来就调用查询当前版本的号码
-(void)request
{
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=1114713303"];
//    NSString *appName = @"可点"; // @"app的名称"
//    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@&country=CN&entity=software", appName];

    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlStr]];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:nil];
    
    NSArray *infoContent = [jsonData objectForKey:@"results"];
    NSString *version = [[infoContent objectAtIndex:0] objectForKey:@"version"];
//    [_verisionBtn setTitle:version forState:UIControlStateNormal];
    
}

//返回到关于我们
- (IBAction)back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
