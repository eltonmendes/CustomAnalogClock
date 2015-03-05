//
//  CustomAnalogClockView.h
//  CustomAnalogClock
//
//  Created by Elton Mendes Vieira Junior on 3/4/15.
//  Copyright (c) 2015 Mendes. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface CustomAnalogClockView : UIView

- (void)setTime:(NSDate *)time;
- (void)startTimer;
- (void)stopTimer;


@end
