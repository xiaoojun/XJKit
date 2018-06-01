//
//  XJMacro.h
//  Pods
//
//  Created by 汤小军 on 2018/5/31.
//

#ifndef XJMacro_h
#define XJMacro_h

//常用对象宏
#define XJNotificationCenter  [NSNotificationCenter defaultCenter]
#define XJUserDefaults           [NSUserDefaults standardUserDefaults]
#define XJSharedApplication  [UIApplication sharedApplication]
#define XJMainBundle             [NSBundle mainBundle]
#define XJMainScreen              [UIScreen mainScreen]
#define XJDevice                      [UIDevice currentDevice]

#define XJColorWithRGB(r,g,b,a)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define XJAppDelegate ((AppDelegate *)    [[UIApplication sharedApplication] delegate])
#define XJApplicationWindow                     [UIApplication sharedApplication].delegate.window


//屏幕常用宽度
#define XJDeviceWidth       ([[UIScreen mainScreen] bounds].size.width)
#define XJDeviceHeight      ([[UIScreen mainScreen] bounds].size.height)
#define XJIsIphoneX           ((XJDeviceHeight == 812)?YES:NO)

// 包括了状态栏的高度
#define XJNavHeight  (XJIsIphoneX ? 88 : 64)
#define XJStatusHeight (XJIsIphoneX ? 44 : 20)
#define XJBottomSafeMargin (XJIsIphoneX ? 34 : 0)
#define XJTopSafeMargin (XJIsIphoneX ? 24 : 0)

//字体
#define XJFont(size)       [UIFont systemFontOfSize:size]
#define XJWeakSelf(var)   __weak typeof(var) weakSelf = var
#define XJStrongSelf(var) __strong typeof(var) strongSelf = var















#endif /* XJMacro_h */
