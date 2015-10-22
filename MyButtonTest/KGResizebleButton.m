//
//  IVButton.m
//  button
//
//  Created by Игорь Веденеев on 22.10.15.
//  Copyright © 2015 Igor Vedeneev. All rights reserved.
//

#import "KGResizebleButton.h"

@interface KGResizebleButton ()

@property (nonatomic, strong) NSLayoutConstraint* buttonWidthConstraint;

@end

static const NSTimeInterval kAnimationDuration = 0.35f;

@implementation KGResizebleButton

#pragma mark - Initialization

- (id) initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder: aDecoder]){
        if (self.buttonType != UIButtonTypeCustom){
            @throw[NSException exceptionWithName:@"Unsupported button type"
                                          reason:@"Only UIButtonTypeCustom() supported"
                                        userInfo:nil];
        }
        
        [self defaultParametersForButton];
    }
    
    //self = [IVButton buttonWithType:UIButtonTypeCustom];
    
    
    
    return self;
}

+ (instancetype) buttonWithType:(UIButtonType)buttonType {
    
    KGResizebleButton *button = [super buttonWithType:buttonType];
    [button defaultParametersForButton];
   
    return button;
}

- (void) awakeFromNib {
    
     //[self defaultParametersForButton];
    [self setTitle:self.titleForNormalState forState:UIControlStateNormal];
}

- (void) didMoveToWindow {
    [super didMoveToWindow];
    
    //[self setTitle:self.titleForNormalState forState:UIControlStateNormal];
    [self finalSetupForButton];
}

#warning  Почитай как правильно делать сабкласс кнопки и из каких методов вызывать какие настройки

- (void) defaultParametersForButton {
    
    self.isPressed = NO;
    [self configureImages];
    [self configureTitles];
    [self configureButtonApperiance];
}

- (void) finalSetupForButton {
    
    [self setImage:self.imageForHighlitedState forState:UIControlStateHighlighted];
    [self setImage:self.imageForNormalState forState:UIControlStateNormal];

    [self setBackgroundColor: self.backgroundColorForNormalState];
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self setTitle:self.titleForNormalState forState:UIControlStateNormal];
    [self setTitleColor:self.titleColorForNormalState forState:UIControlStateNormal];
    
}

- (void) configureImages {
    
    self.imageForNormalState = [UIImage imageNamed:@"star"];
    self.imageForPressedState = [UIImage imageNamed:@"star_white"];
    self.imageForHighlitedState = [UIImage imageNamed:@"star_black"];
    
    [self setImage:self.imageForHighlitedState forState:UIControlStateHighlighted];
    [self setImage:self.imageForNormalState forState:UIControlStateNormal];
}

- (void) configureTitles {
    
    self.titleForNormalState = @"Normal";
    self.titleForPressedState = @"Pressed";
    
    self.titleColorForNormalState = [UIColor grayColor];
    self.titleColorForPressedState = [UIColor whiteColor];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self setTitle:self.titleForNormalState forState:UIControlStateNormal];
    [self setTitleColor:self.titleColorForNormalState forState:UIControlStateNormal];
}

- (void) configureButtonApperiance {
    
    self.backgroundColorForNormalState = [UIColor whiteColor];
    self.backgroundColorForPressedState = [UIColor greenColor];
    self.borderColorForNormalState = [UIColor colorWithWhite:0.2f alpha:0.5f];
    [self setBackgroundColor: self.backgroundColorForNormalState];
    
    self.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -2.5f, 0, 0);
    self.layer.borderColor = self.borderColorForNormalState.CGColor;
    self.adjustsImageWhenHighlighted = NO;
    self.cornerRadius = 2;
    self.borderWidth = 1;
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerRadius;
    
    
    self.buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:0
                                                             multiplier:1.0f
                                                               constant:[self buttonWidthForTitle:self.currentTitle]];
    
    [self addTarget:self
             action:@selector(configureWithAnimation)
   forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - Configure button states

- (void)configureWithAnimation {
    
    self.isPressed = !self.isPressed;
    
    if (self.isPressed) {
        
        [self layoutIfNeeded];
        self.buttonWidthConstraint.constant = [self buttonWidthForTitle:self.titleForPressedState];
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self configureButtonForPressedState];
            [self layoutIfNeeded];
        }];
        
    } else {
        
        [self layoutIfNeeded];
        self.buttonWidthConstraint.constant = [self buttonWidthForTitle:self.titleForNormalState];
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self configureButtonForNormalState];
            [self layoutIfNeeded];
            
        }];
    }
}

- (void) configureButtonForPressedState {
    
    //NSLog(@"%@", self.titleForPressedState);
    [self setTitle:self.titleForPressedState forState:UIControlStateNormal];
    [self setImage:self.imageForPressedState forState:UIControlStateNormal];
    [self setTitleColor:self.titleColorForPressedState forState:UIControlStateNormal];
    [self setImage:self.imageForPressedState forState:UIControlStateNormal];
    [self setTintColor: [UIColor whiteColor]];
    
    self.backgroundColor = self.backgroundColorForPressedState;
    self.layer.borderWidth = 0;
}

- (void) configureButtonForNormalState {
    
    [self setTitle:self.titleForNormalState forState:UIControlStateNormal];
    [self setImage:self.imageForNormalState forState:UIControlStateNormal];
    [self setTitleColor:self.titleColorForNormalState forState:UIControlStateNormal];
    [self setImage:self.imageForNormalState forState:UIControlStateNormal];
    [self setTintColor: [UIColor lightGrayColor]];
    
    self.backgroundColor = self.backgroundColorForNormalState;
    self.layer.borderWidth = self.borderWidth;
    //self.layer.cornerRadius = self.cornerRadius;
}

#pragma mark - Calculating Width

- (CGFloat) buttonWidthForTitle:(NSString*) title{
    
    CGFloat buttonWidthInsets = self.contentEdgeInsets.left + self.contentEdgeInsets.right + self.imageView.frame.size.width + self.titleEdgeInsets.left;
    CGFloat titleWidth = [self widthForText: title withFont: self.titleLabel.font];
    return buttonWidthInsets + titleWidth;
}

- (CGFloat) widthForText:(NSString*) title withFont:(UIFont *) fontType {
    
    NSAttributedString* attributedString = nil;
    UIFont* font = fontType;
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, -1);
    shadow.shadowBlurRadius = 0.5;
    
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentLeft];
    
    NSDictionary* attributes =
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     paragraph, NSParagraphStyleAttributeName,
     shadow, NSShadowAttributeName, nil];
    
    
    attributedString = [[NSAttributedString alloc] initWithString:title attributes:attributes];
    
    CGRect rect = CGRectIntegral([attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX , CGFLOAT_MAX)
                                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                context:nil]);
    
    return CGRectGetWidth(rect);
    
}

@end
