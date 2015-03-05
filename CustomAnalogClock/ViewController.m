//
//  ViewController.m
//  CustomAnalogClock
//
//  Created by Elton Mendes Vieira Junior on 3/4/15.
//  Copyright (c) 2015 Mendes. All rights reserved.
//

#import "ViewController.h"
#import "CustomAnalogClockView.h"

typedef enum : NSUInteger {
    Hour,
    Minute,
    Second,
} TimeType;

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet CustomAnalogClockView *customAnalogClockView;
@property (weak, nonatomic) IBOutlet UIPickerView *datePickerView;

@property (nonatomic,strong) NSMutableArray * hourArray;
@property (nonatomic,strong) NSMutableArray * minuteAndSecondArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.hourArray = [NSMutableArray new];
    self.minuteAndSecondArray = [NSMutableArray new];
    for (int hour = 1; hour <= 12; hour ++ ) {
        [self.hourArray addObject:@(hour)];
    }
    for (int minutes = 1; minutes <= 60; minutes ++ ) {
        [self.minuteAndSecondArray addObject:@(minutes)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker View Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case Hour:
            return 12;
            break;
        case Minute:
            return 60;
            break;
        case Second:
            return 60;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case Hour:
            return [NSString stringWithFormat:@"%@",self.hourArray[row]];
            break;
        case Minute:
            return [NSString stringWithFormat:@"%@",self.minuteAndSecondArray[row]];
            break;
        case Second:
            return [NSString stringWithFormat:@"%@",self.minuteAndSecondArray[row]];
            break;
        default:
            return @"";
            break;
    }
}

#pragma mark - IBActions
- (IBAction)updateTimer:(id)sender {
    [self.customAnalogClockView stopTimer];
    NSDateComponents *comps = [[NSDateComponents alloc] init];

    NSInteger hourIndex = [self.datePickerView selectedRowInComponent:Hour];
    NSInteger hour = [self.hourArray[hourIndex] integerValue];
    NSInteger minuteIndex = [self.datePickerView selectedRowInComponent:Minute];
    NSInteger minute = [self.minuteAndSecondArray[minuteIndex] integerValue];
    NSInteger secondIndex = [self.datePickerView selectedRowInComponent:Second];
    NSInteger second = [self.minuteAndSecondArray[secondIndex] integerValue];
    [comps setHour:hour];
    [comps setMinute:minute];
    [comps setSecond:second];
    [self.customAnalogClockView setTime:[[NSCalendar currentCalendar] dateFromComponents:comps]];
}

- (IBAction)startTimerAction:(id)sender {
    [self.customAnalogClockView startTimer];
}

- (IBAction)stopTimerAction:(id)sender {
    [self.customAnalogClockView stopTimer];
}

@end
