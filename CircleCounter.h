
#import <UIKit/UIKit.h>

// Defaults
#define CIRCLE_COLOR_DEFAULT [UIColor colorWithRed:239/255.0f green:101/255.0f blue:48/255.0f alpha:1]
#define CIRCLE_BACKGROUND_COLOR_DEFAULT [UIColor colorWithWhite:.85f alpha:1]
#define CIRCLE_TIMER_WIDTH 8.0f

@protocol CircleCounterDelegate;

@interface CircleCounter : UIView

/// The receiver of all counter delegate callbacks.
@property (nonatomic, strong) id<CircleCounterDelegate> delegate;

/// The color of the circle indicating the remaining amount of time - default is CIRCLE_COLOR_DEFAULT.
@property (nonatomic, strong) UIColor *circleColor;

/// The color of the circle indicating the expired amount of time - default is CIRCLE_BACKGROUND_COLOR_DEFAULT.
@property (nonatomic, strong) UIColor *circleBackgroundColor;

/// The thickness of the circle color - default is CIRCLE_TIMER_WIDTH.
@property (nonatomic, assign) CGFloat circleTimerWidth;

/// Indicates if the circle counter did start the countdown and animation.
@property (nonatomic, assign, readonly) BOOL didStart;

/// Indicates if the circle counter is currently counting down and animating.
@property (nonatomic, assign, readonly) BOOL isRunning;

/// Indicates if the circle counter finishing counting down and animating.
@property (nonatomic, assign, readonly) BOOL didFinish;

/**
 * Begins the count down and starts the animation. This has no effect if the counter
 * isRunning. If a counter didFinish, you may restart it again by calling this method.
 *
 * @param seconds the length of the countdown timer
 */
- (void)startWithSeconds:(NSInteger)seconds endSecond:(CGFloat)endSecond withColor:(UIColor *)backColor;

/**
 * Pauses the countdown timer and stops animation. This only has an effect if the
 * counter isRunning.
 */
- (void)stop;

/**
 * Continues the countdown timer and resumes animation. This only has an effect if the
 * counter is not running.
 */
- (void)resume;

/**
 * Stops the counter and pauses animation as if it were at the initial, pre-started, state.
 * After reset is called, didStart, isRunning, and didFinish will all be NO.
 * You may start the timer again with startWithSeconds:.
 */
- (void)reset;

@end


@protocol CircleCounterDelegate <NSObject>

/**
 * Alerts the delegate when the timer expires. At this point, counter animation is completed too.
 *
 * @param circleCounter the counter that just expired in time
 */
@optional
- (void)circleCounterTimeDidExpire:(CircleCounter *)circleCounter;

@end
