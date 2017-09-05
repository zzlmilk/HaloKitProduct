//
//  ZTSlider.m
//  可点
//
//  Created by jimZT on 16/10/27.
//  Copyright © 2016年 赵东明. All rights reserved.
//

#define SelectViewBgColor   [UIColor colorWithRed:110/255.0 green:117/255.0 blue:156/255.0 alpha:1.0]
#define defaultViewBgColor  [UIColor colorWithRed:110/255.0 green:117/255.0 blue:156/255.0 alpha:0.5]

#define LiuXSlideWidth      (self.bounds.size.width)
#define LiuXSliderHight     (self.bounds.size.height)

#define LiuXSliderTitle_H   (LiuXSliderHight*0.4)

#define CenterImage_W       8.0

#define LiuXSliderLine_W    (LiuXSlideWidth-CenterImage_W)
#define LiuXSLiderLine_H    6.0
#define LiuXSliderLine_Y    (LiuXSliderHight-LiuXSliderTitle_H - 1)


#define CenterImage_Y       (LiuXSliderLine_Y+(LiuXSLiderLine_H/2))

#import "ZTSlider.h"

@interface ZTSlider()
{
    CGFloat _pointX;
    NSInteger _sectionIndex;//当前选中的那个
    CGFloat _sectionLength;//根据数组分段后一段的长度
    UILabel *_selectLab;
    UILabel *_leftLab;
    UILabel *_rightLab;
}

/**
 *  必传，范围（0到（array.count-1））
 */
@property (nonatomic,assign)CGFloat defaultIndex;
/**
 *  必传，传入节点数组
 */
//@property (nonatomic,strong)NSArray *titleArray;
/**
 *  首，末位置的title
 */
@property (nonatomic,strong)NSArray *firstAndLastTitles;
/**
 *  传入图片
 */
@property (nonatomic,strong)UIImage *sliderImage;
@property (nonatomic,strong)UIView *selectView;
@property (strong,nonatomic)UIView *defaultView;
@property (nonatomic,strong)UIImageView *centerImage;
@end

@implementation ZTSlider

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray firstAndLastTitles:(NSArray *)firstAndLastTitles defaultIndex:(CGFloat)defaultIndex sliderImage:(UIImage *)sliderImage
{
    if (self = [super initWithFrame:frame]) {
        _pointX       = 0;
        _sectionIndex = 0;
        self.backgroundColor = [UIColor clearColor];
        //userInteractionEnabled=YES;代表当前视图可交互，该视图不响应父视图手势
        //UIView的userInteractionEnabled默认是YES，UIImageView默认是NO
        _defaultView = [[UIView alloc] initWithFrame:CGRectMake(CenterImage_W/2, 3 +  LiuXSliderLine_Y - 1, LiuXSlideWidth-CenterImage_W, 1.5)];
        _defaultView.backgroundColor=defaultViewBgColor;
        _defaultView.layer.cornerRadius=LiuXSLiderLine_H/2;
        _defaultView.userInteractionEnabled=NO;
        [self addSubview:_defaultView];
        
        _selectView=[[UIView alloc] initWithFrame:CGRectMake(CenterImage_W/2, 3 + LiuXSliderLine_Y - 0.5, LiuXSlideWidth-CenterImage_W, 2)];
        _selectView.backgroundColor= SelectViewBgColor;
        _selectView.layer.cornerRadius=LiuXSLiderLine_H/2;
        _selectView.userInteractionEnabled=NO;
        [self addSubview:_selectView];
        
        _centerImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CenterImage_W, CenterImage_W)];
        _centerImage.center=CGPointMake(0, CenterImage_Y);
        _centerImage.userInteractionEnabled=NO;
        _centerImage.alpha=1;
        [self addSubview:_centerImage];
        
        _selectLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        _selectLab.textColor=[UIColor lightGrayColor];
        _selectLab.font=[UIFont systemFontOfSize:12];
        _selectLab.textAlignment=1;
        
        [self addSubview:_selectLab];
        
        self.titleArray = titleArray;
        self.defaultIndex = defaultIndex;
        self.firstAndLastTitles=firstAndLastTitles;
        self.sliderImage=sliderImage;
    }
    return self;
}

-(void)setDefaultIndex:(CGFloat)defaultIndex
{
    
    CGFloat withPress = defaultIndex / 200;
    //设置默认位置
    CGRect rect = [_selectView frame];
    rect.size.width = withPress *LiuXSliderLine_W;
    _selectView.frame = rect;
    _pointX = withPress * LiuXSliderLine_W;
    _sectionIndex = defaultIndex;
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _sectionLength = (LiuXSliderLine_W /200);
}

-(void)setFirstAndLastTitles:(NSArray *)firstAndLastTitles
{
    
    _leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 80, LiuXSliderTitle_H)];
    _leftLab.font = [UIFont systemFontOfSize:10];
    _leftLab.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
    _leftLab.text = [firstAndLastTitles firstObject];
    [self addSubview:_leftLab];
    
    _rightLab = [[UILabel alloc] initWithFrame:CGRectMake(LiuXSlideWidth - 80, 25, 80, LiuXSliderTitle_H)];
    _rightLab.font = [UIFont systemFontOfSize:10];
    _rightLab.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1.0];
    _rightLab.text = [firstAndLastTitles lastObject];
    _rightLab.textAlignment = 2;
    [self addSubview:_rightLab];
}

-(void)setSliderImage:(UIImage *)sliderImage
{
    
    _centerImage.image = sliderImage;
    [self refreshSlider];
}

#pragma mark -- UIColor Touch
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    [self changePointX:touch];
    _pointX = _sectionIndex * (_sectionLength);
    [self refreshSlider];
    [self labelEnlargeAnimation];
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
    [self refreshSlider];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
    _pointX=(_sectionIndex) * _sectionLength;
    if (self.block) {
        
        
        if(_sectionIndex>= 200){
            self.block((long)200 * 10);
        }else if(_sectionIndex== 0) {
            self.block((long) 100);
        }else{
            self.block((long)_sectionIndex * 10 + 100);

        }
    }
    [self refreshSlider];
    [self labelLessenAnimation];

}

-(void)changePointX:(UITouch *)touch{
    CGPoint point = [touch locationInView:self];
    _pointX=point.x;
    NSLog(@"_pointX_pointX_pointX:%f",_pointX );
    if (point.x<0) {
        _pointX=0;
    }else if (point.x>LiuXSliderLine_W){
        _pointX=LiuXSliderLine_W;
    }
    //四舍五入计算选择的节点
    _sectionIndex=(int)roundf(_pointX/_sectionLength);
    //NSLog(@"pointx=(%f),(%ld),(%f)",point.x,(long)_sectionIndex,_pointX);
    
}

-(void)refreshSlider{

    
    //_selectLab.center=CGPointMake(_pointX, 3);
//    if (_sectionIndex == 15) {
//        _sectionIndex = 14;
//    }
    
    if(_sectionIndex>= 200){
        _selectLab.text=[NSString stringWithFormat:@"%ld",(long)200 * 10];

    }else if(_sectionIndex== 0) {
        
        _selectLab.text=[NSString stringWithFormat:@"%ld",(long) 100];

    }else{
        _selectLab.text=[NSString stringWithFormat:@"%ld",(long)_sectionIndex * 10 + 100];

    }
    NSLog(@"_sectionIndex_sectionIndex_sectionIndex:%ld", (long)_sectionIndex);
    if (_sectionIndex==0) {
        _sectionIndex = 10;
        _leftLab.hidden=YES;
        _selectLab.center=CGPointMake(_pointX, 5);
    }else if (_sectionIndex>= 200) {
        _rightLab.hidden=YES;
        _sectionIndex = 200;
        _selectLab.center=CGPointMake(_pointX, 5);
    }else{
        _leftLab.hidden=NO;
        _rightLab.hidden=NO;
        _selectLab.center=CGPointMake(_pointX, 5);
    }
    
    if (_pointX < 1) {
        _pointX = CenterImage_W/2;
        _centerImage.center=CGPointMake(_pointX, CenterImage_Y);
        CGRect rect = [_selectView frame];
        rect.size.width=0;
        _selectView.frame=rect;
    }else{
        _pointX=_pointX+CenterImage_W/2;
        _centerImage.center=CGPointMake(_pointX, CenterImage_Y);
        CGRect rect = [_selectView frame];
        rect.size.width=_pointX-CenterImage_W/2;
        _selectView.frame=rect;
    }

    
}

-(void)labelEnlargeAnimation{
    [UIView animateWithDuration:.1 animations:^{
        [_selectLab.layer setValue:@(1.4) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)labelLessenAnimation{
    [UIView animateWithDuration:.1 animations:^{
        [_selectLab.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        
    }];
}


@end
