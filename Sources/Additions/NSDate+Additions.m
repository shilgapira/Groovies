//
// NSDate+Additions.m
//
// Based on: https://github.com/erica/NSDate-Extensions
//

#import "NSDate+Additions.h"


static const NSTimeInterval kSecondsInMinute = 60;
static const NSTimeInterval kSecondsInHour = 3600;
static const NSTimeInterval kSecondsInDay = 86400;
static const NSTimeInterval kSecondsInWeek = 604800;


static const NSCalendarUnit kDateComponents = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit;


@implementation NSDate (Additions)

#pragma mark Relative Dates

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days {
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days {
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)dateTomorrow {
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday {
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours {
    NSTimeInterval ti = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsInHour * hours;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
    return date;
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)hours {
    NSTimeInterval ti = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsInHour * hours;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
    return date;
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)minutes {
    NSTimeInterval ti = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsInMinute * minutes;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
    return date;
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)minutes {
    NSTimeInterval ti = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsInMinute * minutes;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
    return date;
}

#pragma mark Comparing Dates

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)date {
    NSDateComponents *c1 = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    NSDateComponents *c2 = [NSCalendar.currentCalendar components:kDateComponents fromDate:date];
    return (c1.year == c2.year) && (c1.month == c2.month) && (c1.day == c2.day);
}

- (BOOL)isToday {
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow {
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday {
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)isSameWeekAsDate:(NSDate *)date {
    NSDateComponents *c1 = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    NSDateComponents *c2 = [NSCalendar.currentCalendar components:kDateComponents fromDate:date];

    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (c1.week != c2.week) {
        return NO;
    }

    // Must have a time interval under 1 week. Thanks @aclark
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    
    return fabs(ti) < kSecondsInWeek;
}

- (BOOL)isThisWeek {
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek {
    NSTimeInterval ti = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsInWeek;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
    return [self isSameWeekAsDate:date];
}

- (BOOL)isLastWeek {
    NSTimeInterval ti = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsInWeek;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
    return [self isSameWeekAsDate:date];
}

- (BOOL)isSameMonthAsDate:(NSDate *)date {
    NSDateComponents *c1 = [NSCalendar.currentCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *c2 = [NSCalendar.currentCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
    return (c1.month == c2.month) && (c1.year == c2.year);
}

- (BOOL)isThisMonth {
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL)isLastMonth {
    NSDateComponents *c = [NSCalendar.currentCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:[NSDate date]];
    c.month = c.month - 1;
    NSDate *date = [NSCalendar.currentCalendar dateFromComponents:c];
    return [self isSameMonthAsDate:date];
}

- (BOOL)isSameYearAsDate:(NSDate *)date {
    NSDateComponents *c1 = [NSCalendar.currentCalendar components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *c2 = [NSCalendar.currentCalendar components:NSYearCalendarUnit fromDate:date];
    return c1.year == c2.year;
}

- (BOOL)isThisYear {
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear {
    NSDateComponents *c1 = [NSCalendar.currentCalendar components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *c2 = [NSCalendar.currentCalendar components:NSYearCalendarUnit fromDate:[NSDate date]];
    return c1.year == c2.year + 1;
}

- (BOOL)isLastYear {
    NSDateComponents *c1 = [NSCalendar.currentCalendar components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *c2 = [NSCalendar.currentCalendar components:NSYearCalendarUnit fromDate:[NSDate date]];
    return c1.year == c2.year - 1;
}

- (BOOL)isEarlierThanDate:(NSDate *)date {
    return [self compare:date] == NSOrderedAscending;
}

- (BOOL)isLaterThanDate:(NSDate *)date {
    return [self compare:date] == NSOrderedDescending;
}

- (BOOL)isInFuture {
    return [self isLaterThanDate:[NSDate date]];
}

- (BOOL)isInPast {
    return [self isEarlierThanDate:[NSDate date]];
}

#pragma mark Roles

- (BOOL)isTypicallyWeekend {
    NSDateComponents *c = [NSCalendar.currentCalendar components:NSWeekdayCalendarUnit fromDate:self];
    return (c.weekday == 1) || (c.weekday == 7);
}

- (BOOL)isTypicallyWorkday {
    return ![self isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *)dateWithYear:(NSInteger)year {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    c.year = year;
    return [NSCalendar.currentCalendar dateFromComponents:c];
}

- (NSDate *)dateByAddingYears:(NSInteger)years {
    NSDateComponents *c = [NSDateComponents new];
    c.year = years;
    NSDate *date = [NSCalendar.currentCalendar dateByAddingComponents:c toDate:self options:0];
    return date;
}

- (NSDate *)dateBySubtractingYears:(NSInteger)years {
    return [self dateByAddingYears:(-1 * years)];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months {
    NSDateComponents *c = [NSDateComponents new];
    c.month = months;
    NSDate *date = [NSCalendar.currentCalendar dateByAddingComponents:c toDate:self options:0];
    return date;
}

- (NSDate *)dateBySubtractingMonths:(NSInteger)months {
    return [self dateByAddingMonths:(-1 * months)];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSTimeInterval ti = [self timeIntervalSinceReferenceDate] + kSecondsInDay * days;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
    return date;
}

- (NSDate *)dateBySubtractingDays:(NSInteger)days {
    return [self dateByAddingDays:(-1 * days)];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours {
    NSTimeInterval ti = [self timeIntervalSinceReferenceDate] + kSecondsInHour * hours;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
    return date;
}

- (NSDate *)dateBySubtractingHours:(NSInteger)hours {
    return [self dateByAddingHours:(-1 * hours)];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes {
    NSTimeInterval ti = [self timeIntervalSinceReferenceDate] + kSecondsInMinute * minutes;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
    return date;
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes {
    return [self dateByAddingMinutes:(-1 * minutes)];
}

- (NSDate *)dateAtStartOfDay {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    c.hour = 0;
    c.minute = 0;
    c.second = 0;
    return [NSCalendar.currentCalendar dateFromComponents:c];
}

- (NSDate *)dateAtStartOfHour {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    c.minute = 0;
    c.second = 0;
    return [NSCalendar.currentCalendar dateFromComponents:c];
}

#pragma mark Retrieving Intervals

- (NSInteger)minutesAfterDate:(NSDate *)date {
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    return (NSInteger) (ti / kSecondsInMinute);
}

- (NSInteger)minutesBeforeDate:(NSDate *)date {
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    return (NSInteger) (ti / kSecondsInMinute);
}

- (NSInteger)hoursAfterDate:(NSDate *)date {
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    return (NSInteger) (ti / kSecondsInHour);
}

- (NSInteger)hoursBeforeDate:(NSDate *)date {
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    return (NSInteger) (ti / kSecondsInHour);
}

- (NSInteger)daysAfterDate:(NSDate *)date {
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    return (NSInteger) (ti / kSecondsInDay);
}

- (NSInteger)daysBeforeDate:(NSDate *)date {
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    return (NSInteger) (ti / kSecondsInDay);
}

#pragma mark Decomposing Dates

- (NSInteger)nearestHour {
    NSTimeInterval ti = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsInMinute * 30;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
    NSDateComponents *c = [NSCalendar.currentCalendar components:NSHourCalendarUnit fromDate:date];
    return c.hour;
}

- (NSInteger)hour {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    return c.hour;
}

- (NSInteger)minute {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    return c.minute;
}

- (NSInteger)seconds {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    return c.second;
}

- (NSInteger)day {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    return c.day;
}

- (NSInteger)month {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    return c.month;
}

- (NSInteger)week {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    return c.week;
}

- (NSInteger)weekday {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    return c.weekday;
}

- (NSInteger)ordinalWeekday {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    return c.weekdayOrdinal;
}

- (NSInteger)year {
    NSDateComponents *c = [NSCalendar.currentCalendar components:kDateComponents fromDate:self];
    return c.year;
}

@end
