//
//  QQHelperSettingWindow.m
//  QQRedPackHelper
//
//  Created by tangxianhai on 2018/3/14.
//  Copyright © 2018年 tangxianhai. All rights reserved.
//

#import "QQHelperSettingWindow.h"

@implementation QQHelperSettingWindow {
    QQHelperSegmentedControl *segmentedCr;
    RedPackView *redPackSettingView;
    OtherView *otherSettingView;
}

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingStoreType defer:(BOOL)flag {
    self = [super initWithContentRect:contentRect styleMask:style backing:backingStoreType defer:flag];
    if (self != nil) {
        [self subviewsInit];
    }
    return self;
}

- (void)subviewsInit {
    segmentedCr = [QQHelperSegmentedControl segmentedControlWithLabels:@[@"红包设置",@"其他设置"] trackingMode:NSSegmentSwitchTrackingSelectOne target:self action:NSSelectorFromString(@"selectSegmentCr:")];
    [segmentedCr workInit];
    [self.contentView addSubview:segmentedCr];

    redPackSettingView = [[RedPackView alloc] initWithFrame:NSZeroRect];
    redPackSettingView.hidden = NO;

    otherSettingView = [[OtherView alloc] initWithFrame:NSZeroRect];
    otherSettingView.hidden = YES;

    [self.contentView addSubview:redPackSettingView];
    [self.contentView addSubview:otherSettingView];

}

- (void)layoutIfNeeded {
    [segmentedCr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(10);
        make.centerX.mas_equalTo(self.contentView);
    }];

    [redPackSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(segmentedCr.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-10);
    }];

    [otherSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(redPackSettingView).with.insets(NSEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [super layoutIfNeeded];
}

- (void)selectSegmentCr:(QQHelperSegmentedControl *)Cr {
    if (Cr.selectedSegment == 0) {
        redPackSettingView.hidden = NO;
        otherSettingView.hidden = YES;
    } else {
        redPackSettingView.hidden = YES;
        otherSettingView.hidden = NO;
    }
}

@end
