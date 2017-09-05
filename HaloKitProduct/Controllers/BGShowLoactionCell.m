//
//  BGShowLoactionCell.m
//  HaloKitProduct
//
//  Created by 范博 on 2017/8/3.
//  Copyright © 2017年 范博. All rights reserved.
//

#import "BGShowLoactionCell.h"
#import "BGImgView.h"

@implementation BGShowLoactionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_showLocationBtn setImage:[BGImgView imageWithIcon:@"\U0000e659" inFont:@"iconfont" size:20 color: [UIColor blueColor]] forState:UIControlStateNormal];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showLocationAct:(id)sender {//&#xe658;
    
    [_showLocationBtn setImage:[BGImgView imageWithIcon:@"\U0000e658" inFont:@"iconfont" size:20 color: [UIColor blueColor]] forState:UIControlStateNormal];

}
@end
