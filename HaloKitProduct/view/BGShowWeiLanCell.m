//
//  BGShowWeiLanCell.m
//  HaloKitProduct
//
//  Created by 范博 on 2017/8/3.
//  Copyright © 2017年 范博. All rights reserved.
//

#import "BGShowWeiLanCell.h"
#import "BGImgView.h"
@implementation BGShowWeiLanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_showWeiLanBtn setImage:[BGImgView imageWithIcon:@"\U0000e659" inFont:@"iconfont" size:20 color: [UIColor blueColor]] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showWeiLanAct:(id)sender {
    [_showWeiLanBtn setImage:[BGImgView imageWithIcon:@"\U0000e658" inFont:@"iconfont" size:20 color: [UIColor blueColor]] forState:UIControlStateNormal];
}
@end
