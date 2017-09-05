//
//  BGFAQVC.m
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/11.
//  Copyright © 2017年 范博. All rights reserved.
//

#import "BGFAQVC.h"

@interface BGFAQVC ()

@end

@implementation BGFAQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FAQ";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


@end
