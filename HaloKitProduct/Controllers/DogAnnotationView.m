//
//  DogAnnotationView.m
//  可点
//
//  Created by 赵东明 on 16/5/30.
//  Copyright © 2016年 赵东明. All rights reserved.
//

#import "DogAnnotationView.h"
#import "DogView.h"


@implementation DogAnnotationView

-(id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        DogView *dogView = [[[NSBundle mainBundle] loadNibNamed:@"DogView" owner:nil options:nil] lastObject];
        [self addSubview:dogView];
    }
    return self;
}

@end
