
#import "CircleCounter.h"

#define SECONDS_ADJUSTMENT 1000
#define TIMER_INTERVAL .01 // 1/100 FPS

@interface CircleCounter() {
    NSUInteger numAdjustedSecondsCompleted;
    NSUInteger numAdjustedSecondsCompletedIncrementor;
    NSUInteger numAdjustedSecondsTotal;
    NSUInteger numSeconds;
    CGFloat endSeconds;
}
@end

@implementation CircleCounter

#pragma mark - Public methods

- (void)baseInit {
    self.backgroundColor = [UIColor clearColor];

    self.circleColor = [UIColor redColor];
    self.circleTimerWidth = CIRCLE_TIMER_WIDTH;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }

    return self;
}

- (void)startWithSeconds:(NSInteger)seconds endSecond:(CGFloat)endSecond withColor:(UIColor *)backColor{
    if (seconds < 1) {
        return;
    }

    if (self.didStart && !self.didFinish) {
        return;
    }

    numSeconds = seconds;
    numAdjustedSecondsCompleted = 0;
    numAdjustedSecondsCompletedIncrementor = seconds;
    numAdjustedSecondsTotal = seconds * SECONDS_ADJUSTMENT;

    endSeconds = endSecond * SECONDS_ADJUSTMENT * ((M_PI/2) + 0.066f);
    self.circleBackgroundColor = backColor;

    _didStart = YES;
    _didFinish = NO;
    [self resume];
}

- (void)resume {
    if (!self.didStart || self.isRunning) {
        return;
    }

    _isRunning = YES;
    [self update];
}

- (void)stop {
    _isRunning = NO;
}

- (void)reset {
    [self stop];
    numAdjustedSecondsCompleted = 0;
    _didFinish = NO;
    _didStart = NO;
    [self setNeedsDisplay];
}

#pragma mark - Private methods

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    float radius = CGRectGetWidth(rect)/2.0f - self.circleTimerWidth/2.0f;
    float angleOffset = M_PI_2;

    // Draw the background of the circle.
    CGContextSetLineWidth(context, self.circleTimerWidth);
    CGContextBeginPath(context);
    
    CGContextAddArc(context,
                    CGRectGetMidX(rect),
                    CGRectGetMidY(rect),
                    radius,
                    M_PI - 1,
                    1,
                    0);
    
    CGContextSetStrokeColorWithColor(context, [self.circleBackgroundColor CGColor]);
    CGContextStrokePath(context);

    // Draw the remaining amount of timer circle.
    CGContextSetLineWidth(context, self.circleTimerWidth);
    CGContextBeginPath(context);

    CGFloat startAngle = (((CGFloat)numAdjustedSecondsCompleted) /
                          ((CGFloat)numAdjustedSecondsTotal)*M_PI - angleOffset) - angleOffset - 1;

    CGFloat endAngle = 1;

    CGContextAddArc(context,
                    CGRectGetMidX(rect), CGRectGetMidY(rect),
                    radius,
                    startAngle,
                    endAngle,
                    0);
    
    CGContextSetStrokeColorWithColor(context, [self.circleColor CGColor]);
    CGContextStrokePath(context);
}

- (void)update {
    if (self.isRunning) {
        numAdjustedSecondsCompleted += numAdjustedSecondsTotal / (numSeconds / TIMER_INTERVAL);
        //NSLog(@"numAdjustedSecondsCompleted==> %lu, endSeconds==> %f",(unsigned long)numAdjustedSecondsCompleted, endSeconds);
        if (numAdjustedSecondsCompleted >= endSeconds) {
            // finished
            numAdjustedSecondsCompleted = endSeconds - 1;
            [self stop];
            _didFinish = YES;
            
            // alert delegate method that it finished
            if ([self.delegate respondsToSelector:@selector(circleCounterTimeDidExpire:)]) {
                [self.delegate circleCounterTimeDidExpire:self];
            }
        } else {
            // in progress
            [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL
                                             target:self
                                           selector:@selector(update)
                                           userInfo:nil
                                            repeats:NO];
        }
        [self setNeedsDisplay];
    }
}

@end
