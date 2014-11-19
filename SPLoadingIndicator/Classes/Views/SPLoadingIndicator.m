//
//  SPLoadingIndicator.m
//  SpinnerView
//
//  Created by Jan on 18/11/14.
//  Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPLoadingIndicator.h"


const CGFloat SPLoadingIndicatorCornerRadiusRatio = 8;

// How smaller the circle's width is compared to the rounded view width
const CGFloat SPLoadingIndicatorCircleWidthRatio = 2;
const CGFloat SPCircleViewCircleWidth = 0.7f;

@interface SPLoadingIndicator ()

@property(nonatomic, strong) UIView *outerCircleView;
@property(nonatomic, strong) CAShapeLayer *outerCircleLayer;

@end


IB_DESIGNABLE
@implementation SPLoadingIndicator


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSubViews];

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    self.backgroundColor = [UIColor colorWithRed:0.243 green:0.243 blue:0.243 alpha:0.7];


    CGRect boundsOfSelf = self.bounds;

    self.outerCircleView.frame = CGRectMake(
            CGRectGetWidth(boundsOfSelf) / (SPLoadingIndicatorCircleWidthRatio * 2.0f),
            CGRectGetHeight(boundsOfSelf) / (SPLoadingIndicatorCircleWidthRatio * 2.0f),
            CGRectGetWidth(boundsOfSelf) / SPLoadingIndicatorCircleWidthRatio,
            CGRectGetHeight(boundsOfSelf) / SPLoadingIndicatorCircleWidthRatio
    );

    //
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.cornerRadius = CGRectGetWidth(boundsOfSelf) / SPLoadingIndicatorCornerRadiusRatio;
    self.clipsToBounds = YES;

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // circle

    CGFloat radius = (SPLoadingIndicatorCircleWidthRatio * 2.0f);

    CGPoint centerPoint = CGPointMake(
            CGRectGetWidth(rect) / radius,
            CGRectGetHeight(rect) / radius);


    CGRect boundsOfSelf = self.bounds;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                              radius:CGRectGetWidth(boundsOfSelf) / radius
                                                          startAngle:(CGFloat) ((2.5 * M_PI) / 2)
                                                            endAngle:(CGFloat) (-(M_PI) / 2)
                                                           clockwise:NO];
    [self.outerCircleLayer setPath:[circlePath CGPath]];
}

#pragma mark - Private

#pragma mark - View / Layer Setup

- (void)setupSubViews
{

    // View container for the circle layer
    self.outerCircleView = [[UIView alloc] initWithFrame:CGRectZero];

    // Circle layer
    self.outerCircleLayer = [CAShapeLayer layer];
    self.outerCircleLayer.lineWidth = SPCircleViewCircleWidth;
    self.outerCircleLayer.fillColor = [UIColor clearColor].CGColor;
    self.outerCircleLayer.strokeColor = [UIColor colorWithWhite:1.0f alpha:0.5f].CGColor;


    CABasicAnimation *animation = [self setupRotationAnimation];

    [self.outerCircleView.layer addAnimation:animation forKey:@"rotationAnimation"];
    [self.outerCircleView.layer addSublayer:self.outerCircleLayer];

    [self addSubview:self.outerCircleView];
}


- (CABasicAnimation *)setupRotationAnimation
{
    NSTimeInterval animationDuration = 1;
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.toValue = @(M_PI * 2.0f);
    animation.duration = animationDuration;
    animation.timingFunction = linearCurve;
    animation.removedOnCompletion = NO;
    animation.repeatCount = INFINITY;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    return animation;
}

@end
