//
//  IVButton.h
//  button
//
//  Created by Игорь Веденеев on 22.10.15.
//  Copyright © 2015 Igor Vedeneev. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface KGResizebleButton : UIButton

@property (nonatomic, copy) IBInspectable NSString* titleForNormalState;
@property (nonatomic, copy) IBInspectable NSString* titleForPressedState;

@property (nonatomic, strong) IBInspectable UIColor* titleColorForNormalState;
@property (nonatomic, strong) IBInspectable UIColor* titleColorForPressedState;
@property (nonatomic, strong) IBInspectable UIColor* backgroundColorForNormalState;
@property (nonatomic, strong) IBInspectable UIColor* backgroundColorForPressedState;
@property (nonatomic, strong) IBInspectable UIColor* borderColorForNormalState;
@property (nonatomic, strong) IBInspectable UIColor* borderColorForPressedState;

@property (nonatomic, strong) IBInspectable UIImage* imageForNormalState;
@property (nonatomic, strong) IBInspectable UIImage* imageForPressedState;
@property (nonatomic, strong) IBInspectable UIImage* imageForHighlitedState;

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;

@property (assign) BOOL isPressed;

@end
