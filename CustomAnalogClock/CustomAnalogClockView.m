//
//  CustomAnalogClockView.m
//  CustomAnalogClock
//
//  Created by Elton Mendes Vieira Junior on 3/4/15.
//  Copyright (c) 2015 Mendes. All rights reserved.
//

#import "CustomAnalogClockView.h"

@interface CustomAnalogClockView ()

@property (nonatomic, strong) CAShapeLayer *hourShapeLayer;
@property (nonatomic, strong) CAShapeLayer *minuteShapeLayer;
@property (nonatomic, strong) CAShapeLayer *secondShapeLayer;
@property (nonatomic, strong) NSDate *currentTime;
@property (nonatomic, strong) NSTimer *currentTimer;

#pragma mark - Inspectables Properties
@property (nonatomic) IBInspectable BOOL didMarkSeconds;
@property (nonatomic) IBInspectable CGFloat hourSize;
@property (nonatomic) IBInspectable CGFloat minuteSize;
@property (nonatomic) IBInspectable CGFloat secondSize;
@property (nonatomic,strong) IBInspectable UIColor *hourColor;
@property (nonatomic,strong) IBInspectable UIColor *minuteColor;
@property (nonatomic,strong) IBInspectable UIColor *secondColor;
@end

@implementation CustomAnalogClockView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    
    CAShapeLayer *shapeClockLayer = [CAShapeLayer layer];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    shapeClockLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeClockLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeClockLayer.lineWidth = 4;
    shapeClockLayer.path = path.CGPath;
    
    self.hourShapeLayer = [CAShapeLayer layer];
    self.hourShapeLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(-2, -self.hourSize, 4, self.hourSize)].CGPath;
    self.hourShapeLayer.fillColor = self.hourColor.CGColor;
    self.hourShapeLayer.position = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    [shapeClockLayer addSublayer:self.hourShapeLayer];

    self.minuteShapeLayer = [CAShapeLayer layer];
    self.minuteShapeLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -self.minuteSize, 2, self.minuteSize)].CGPath;
    self.minuteShapeLayer.fillColor = self.minuteColor.CGColor;
    self.minuteShapeLayer.position = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    [shapeClockLayer addSublayer:self.minuteShapeLayer];
    [self.layer addSublayer:shapeClockLayer];
    
    if(self.didMarkSeconds){
        self.secondShapeLayer = [CAShapeLayer layer];
        self.secondShapeLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, -self.secondSize, 1, self.secondSize)].CGPath;
        self.secondShapeLayer.fillColor = self.secondColor.CGColor;
        self.secondShapeLayer.position = CGPointMake(rect.size.width / 2, rect.size.height / 2);
        [shapeClockLayer addSublayer:self.secondShapeLayer];
        [self.layer addSublayer:shapeClockLayer];
    }
    
    
    if(!_currentTime){
        _currentTime = [NSDate new];
        [self setTime:_currentTime];
    }
}
#pragma mark - Public Methods

- (void)startTimer {
    if(![_currentTimer isValid]){
        _currentTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        [_currentTimer fire];
    }
}
- (void)stopTimer {
    [_currentTimer invalidate];
}

- (void)setTime:(NSDate *)time {

    if(time)
        _currentTime = time;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:time];
    self.hourShapeLayer.affineTransform = CGAffineTransformMakeRotation(components.hour / 12.0 * 2.0 * M_PI);
    self.minuteShapeLayer.affineTransform = CGAffineTransformMakeRotation(components.minute / 60.0 * 2.0 * M_PI);
    self.secondShapeLayer.affineTransform = CGAffineTransformMakeRotation(components.second / 60.0 * 2.0 * M_PI);
}


#pragma mark - Private Methods

- (void)updateTime:(NSTimer *)timer {
    [self setTime:[NSDate new]];
}



@end
