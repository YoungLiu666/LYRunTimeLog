//
//  ViewController.m
//  LYRunTimeLog
//
//  Created by liuyang on 2017/8/10.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "ViewController.h"
#import "SecondController.h"
@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    self.title = @"runtime埋点";
    [self.textField addTarget:self action:@selector(onTextfieldbegin:)forControlEvents:UIControlEventEditingDidBegin];
    [self.textField addTarget:self action:@selector(onTextfieldend:)forControlEvents:UIControlEventEditingDidEnd];
}

- (IBAction)btnClick:(id)sender {
    SecondController * sController = [[SecondController alloc]init];
    [self.navigationController pushViewController:sController animated:YES];
}

-(void)onTextfieldbegin:(UITextField*)sender{
    NSLog(@"sender");
}

-(void)onTextfieldend:(UITextField*)sender{
    NSLog(@"sender");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取数据
    NSString * fieldSumTime  = [userDefaults objectForKey:@"fieldSumTime"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:fieldSumTime
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark UITextFiledDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
