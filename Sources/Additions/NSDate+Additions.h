//
// NSDate+Additions.h
//
// Based on: https://github.com/erica/NSDate-Extensions
//

#import <Foundation/Foundation.h>


@interface NSDate (Additions)

// Relative dates from the current date
+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)hours;
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)minutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)minutes;

// Comparing dates
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)date;
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isSameWeekAsDate:(NSDate *)date;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isSameMonthAsDate:(NSDate *)date;
- (BOOL)isThisMonth;
- (BOOL)isLastMonth;
- (BOOL)isSameYearAsDate:(NSDate *)date;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;
- (BOOL)isEarlierThanDate:(NSDate *)date;
- (BOOL)isLaterThanDate:(NSDate *)date;
- (BOOL)isInFuture;
- (BOOL)isInPast;

// Date roles
- (BOOL)isTypicallyWorkday;
- (BOOL)isTypicallyWeekend;

// Adjusting dates
- (NSDate *)dateWithYear:(NSInteger)year;
- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateBySubtractingYears:(NSInteger)years;
- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateBySubtractingMonths:(NSInteger)months;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateBySubtractingDays:(NSInteger)days;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)dateAtStartOfDay;
- (NSDate *)dateAtStartOfHour;

// Retrieving intervals
- (NSInteger)minutesAfterDate:(NSDate *)date;
- (NSInteger)minutesBeforeDate:(NSDate *)date;
- (NSInteger)hoursAfterDate:(NSDate *)date;
- (NSInteger)hoursBeforeDate:(NSDate *)date;
- (NSInteger)daysAfterDate:(NSDate *)date;
- (NSInteger)daysBeforeDate:(NSDate *)date;

// Decomposing dates
@property (nonatomic,assign,readonly) NSInteger nearestHour;
@property (nonatomic,assign,readonly) NSInteger hour;
@property (nonatomic,assign,readonly) NSInteger minute;
@property (nonatomic,assign,readonly) NSInteger seconds;
@property (nonatomic,assign,readonly) NSInteger day;
@property (nonatomic,assign,readonly) NSInteger month;
@property (nonatomic,assign,readonly) NSInteger week;
@property (nonatomic,assign,readonly) NSInteger weekday;
@property (nonatomic,assign,readonly) NSInteger ordinalWeekday;
@property (nonatomic,assign,readonly) NSInteger year;

@end
