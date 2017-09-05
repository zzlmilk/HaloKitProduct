//
//  BGFeedbackVC.h
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/11.
//  Copyright © 2017年 范博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZTextView.h"

@interface BGFeedbackVC : UIViewController
@property (weak, nonatomic) IBOutlet GZTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
- (IBAction)tijiaoBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tijiaoBtn;

@end
