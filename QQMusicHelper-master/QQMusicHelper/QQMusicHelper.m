//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//
//  QQMusicHelper.m
//  QQMusicHelper
//
//  Created by tangxianhai on 2018/5/4.
//  Copyright © 2018年 tangxianhai. All rights reserved.
//

#import "QQMusicHelper.h"
#import "substrate.h"

@class DownLoadTask;

static BOOL (*origin_DownLoadTask_checkHaveRightToDownload_rate)(DownLoadTask*,SEL,id,int);
static BOOL new_DownLoadTask_checkHaveRightToDownload_rate(DownLoadTask* self,SEL _cmd,id a3, int a4) {
    NSLog(@"QQMusicHelper助手 ---------- hook checkHaveRightToDownload is ok");
    return YES;
}

static int (*origin_GetFlexBOOL)(int64_t a1, int64_t a2, int64_t a3, int64_t a4, int64_t a5, int64_t a6, int64_t a7, int64_t a8);
static int new_GetFlexBOOL(int64_t a1, int64_t a2, int64_t a3, int64_t a4, int64_t a5, int64_t a6, int64_t a7, int64_t a8) {
    NSLog(@"QQMusicHelper助手 ---------- hook GetFlexBOOL is ok");
    return 1;
}

static void __attribute__((constructor)) initialize(void) {
    MSHookMessageEx(objc_getClass("DownLoadTask"),  NSSelectorFromString(@"checkHaveRightToDownload:rate:"), (IMP)&new_DownLoadTask_checkHaveRightToDownload_rate, (IMP*)&origin_DownLoadTask_checkHaveRightToDownload_rate);
    MSImageRef image = MSGetImageByName("/Applications/QQMusic.app/Contents/MacOS/QQMusic");
    void *_GetFlexBOOL = MSFindSymbol(image, "_GetFlexBOOL");
    MSHookFunction(_GetFlexBOOL, &new_GetFlexBOOL, (void *)&origin_GetFlexBOOL);
}
