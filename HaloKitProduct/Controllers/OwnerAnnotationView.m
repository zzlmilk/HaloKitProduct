//
//  OwnerAnnotationView.m
//  可点
//
//  Created by 何小弟 on 16/7/31.
//  Copyright © 2016年 赵东明. All rights reserved.
//

#import "OwnerAnnotationView.h"
#import "DogView.h"

@implementation OwnerAnnotationView

-(id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        DogView *dogView = [[[NSBundle mainBundle] loadNibNamed:@"DogView" owner:nil options:nil] lastObject];
        [self addSubview:dogView];
    }
    return self;
}

@end
