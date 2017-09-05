//
//  CZBottomMenu.m
//  B01.底部旋转菜单
//
//  Created by apple on 15-1-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZBottomMenu.h"

#define AnimiationDuration 0.45
#define delta 50 //按钮间的间距

@interface CZBottomMenu()
/**
 *  Items存放三个隐藏按钮
 */
@property(nonatomic,strong)NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;
- (IBAction)mainBtnClick:(id)sender;

@end

@implementation CZBottomMenu
{
    BOOL show;

}
-(NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    
    return _items;
}

+(instancetype)buttomMenu{

    return [[[NSBundle mainBundle] loadNibNamed:@"CZBottomMenu" owner:nil options:nil] lastObject];
}


#pragma mark 对象是从xib/storybard加载的时候，就会调用这个方法
-(id)initWithCoder:(NSCoder *)aDecoder{
    NSLog(@"%s",__func__);
    if(self = [super initWithCoder:aDecoder ]){
        [self initItems];
    }
    
    return self;
}

#pragma mark 初始化三个隐藏的按钮
-(void)initItems{
    [self addBtnWithBgImage:@"蓝色" tag:0];
    [self addBtnWithBgImage:@"黄色" tag:1];
    [self addBtnWithBgImage:@"绿色" tag:2];
    [self addBtnWithBgImage:@"玫红" tag:3];
    [self addBtnWithBgImage:@"深蓝" tag:4];
    show = NO;
    
}
/**
 *  通过一张图片来添加按钮
 *
 */
-(void)addBtnWithBgImage:(NSString *)bgImage tag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    btn.tag = tag;
    [self.items addObject:btn];
    [self addSubview:btn];
    
    
}

#pragma mark 设置三个隐藏按钮的尺寸和位置
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //所有隐藏按钮的大小是一样
    CGRect btnBounds = CGRectMake(0, 0, 43, 43);
    
    //遍历三个隐藏的按钮
    for (UIButton *btn in self.items) {
        btn.bounds = btnBounds;
        btn.center = self.mainBtn.center;
    }
    
    //把 "红色按钮" 置顶
    [self bringSubviewToFront:self.mainBtn];

}



- (IBAction)mainBtnClick:(id)sender {
    show = !show;
    
    
    [self showItems:show];
    
}

-(void)showItems:(BOOL)show{
    
    NSLog(@"主按钮中心点 %@",NSStringFromCGPoint(self.mainBtn.center));
    NSLog(@"主按钮的图层的position %@",NSStringFromCGPoint(self.mainBtn.layer.position));
    
    // 实现 items 的 显示位置
    for (UIButton *btn in self.items) {
        // 2.创建动画
        // 2.1创建组组动画
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = AnimiationDuration;
        
        // 2.2 添加一个 ”平移动画“
        CAKeyframeAnimation *positionAni = [CAKeyframeAnimation animation];
        positionAni.keyPath = @"position";
        
        // 2.3 添加一个 ”旋转的动画“
        CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
        rotationAni.keyPath = @"transform.rotation";
        
        //重新设置每个按钮的x值
        CGFloat btnCenterX = self.mainBtn.center.x;
        CGFloat btnCenterY = self.mainBtn.center.y + (btn.tag + 1) * delta;

        // 最终显示的位置
        CGPoint showPosition = CGPointMake(btnCenterX, btnCenterY);
        NSLog(@"主按钮中心点 %@",NSStringFromCGPoint(showPosition));

        //设置 "平移动画: 的 路径
        NSValue *value1 = [NSValue valueWithCGPoint:self.mainBtn.center];
        NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(btnCenterX, btnCenterY * 0.5)];
        NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(btnCenterX, btnCenterY * 1.1)];
        NSValue *value4 = [NSValue valueWithCGPoint:showPosition];
        positionAni.values = @[value1,value2,value3,value4];
        //添加子动画
        group.animations = @[positionAni];
        //执行组动画
        [btn.layer addAnimation:group forKey:nil];
        //显示
    
        if (show) {
            //设置 旋转的路径
            btn.center = showPosition;
        }else{
            //隐藏
            
            //设置 "平移动画: 的 路径
            positionAni.values = @[value4,value3,value2,value1];
            btn.center = self.mainBtn.center;
            rotationAni.values = @[@0,@(M_PI * 2),@(0),@(-M_PI * 2)];
        }
    }
    
    
    
    
}
@end
