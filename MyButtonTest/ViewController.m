//
//  ViewController.m
//  MyButtonTest
//
//  Created by Игорь Веденеев on 22.10.15.
//  Copyright © 2015 Igor Vedeneev. All rights reserved.
//

#import "ViewController.h"
#import "KGResizebleButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KGResizebleButton* btn = [KGResizebleButton buttonWithType: UIButtonTypeCustom];
    btn.frame = CGRectMake(200, 100, 100, 30);
    btn.titleForNormalState = @"asd";
    NSLog(@"1st");
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
