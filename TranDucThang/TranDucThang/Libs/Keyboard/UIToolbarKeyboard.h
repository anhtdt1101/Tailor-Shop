//
//  UIToolbarKeyboard.h
//  BIDCBank
//
//  Created by ChungNV on 9/10/15.
//  Copyright (c) 2015 Pham Tuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIToolbarKeyboard : UIToolbar

@property (nonatomic, copy) void(^prevAction)();
@property (nonatomic, copy) void(^nextAction)();
@property (nonatomic, copy) void(^doneAction)();
@property (nonatomic, copy) void(^doneOtherAction)();

@property (nonatomic , strong) UIBarButtonItem * vBtPrev;
@property (nonatomic , strong) UIBarButtonItem * vBtNext;
@property (nonatomic , strong) UIBarButtonItem * vBtDone;

+(UIToolbarKeyboard *) create;

@end
