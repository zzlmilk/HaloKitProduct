//
//  BGImgView.m
//  HaloKitProduct
//
//  Created by 范博 on 2017/8/3.
//  Copyright © 2017年 范博. All rights reserved.
//

#import "BGImgView.h"

@implementation BGImgView

+ (UIImage*)imageWithIcon:(NSString*)iconCode inFont:(NSString*)fontName size:(NSUInteger)size color:(UIColor*)color {
    CGSize imageSize = CGSizeMake(size, size);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    label.font = [UIFont fontWithName:fontName size:size];
    label.text = iconCode;
    if(color){
        label.textColor = color;
    }
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    return retImage;
}

@end
