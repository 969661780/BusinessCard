//
//  MTFillInMoodViewController.m
//  BusinessCard
//
//  Created by mt y on 2018/7/3.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTFillInMoodViewController.h"
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "MTHomeViewController.h"
#import <SVProgressHUD.h>
#import "STConfig.h"
#import "MTPersonMood.h"
#import "MTAddPutModeTool.h"
@interface MTFillInMoodViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, STPhotoKitDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField;
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UIButton *myImgeBtn;



@property (nonatomic, strong)UIImage *headImage;
@end

@implementation MTFillInMoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.type;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.myRemarkLable.hidden = YES;
    }
}
#pragma mark - 1.STPhotoKitDelegate的委托

- (void)photoKitController:(STPhotoKitController *)photoKitController resultImage:(UIImage *)resultImage
{
    self.headImage = resultImage;
    [self.myImgeBtn setBackgroundImage:resultImage forState:UIControlStateNormal];
    
}
#pragma mark - 2.UIImagePickerController的委托
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
        STPhotoKitController *photoVC = [STPhotoKitController new];
        [photoVC setDelegate:self];
        [photoVC setImageOriginal:imageOriginal];
        [photoVC setSizeClip:CGSizeMake(self.myImgeBtn.width*2, self.myImgeBtn.height*2)];
        [self presentViewController:photoVC animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}
#pragma mark - --- event response 事件相应 ---
- (void)editImageSelected
{
    UIAlertController *alertController = [[UIAlertController alloc]init];
    
  
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Get from album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [controller setDelegate:self];
        if ([controller isAvailablePhotoLibrary]) {
            [self presentViewController:controller animated:YES completion:nil];
            [SVProgressHUD dismissWithDelay:1.5];
        }else
        {
            [SVProgressHUD showInfoWithStatus:@"Please open album permissions"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark -touchs
- (IBAction)headImageBtn:(UIButton *)sender {
    [self editImageSelected];
}
- (IBAction)commitBtn:(UIButton *)sender {
    if (!self.headImage) {
        [SVProgressHUD showErrorWithStatus:@"Please add avatar"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    if (self.nameTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please enter your name"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    if (self.positionTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please enter your position"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    if (self.telTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please enter your tel"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    if (self.addressTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please enter your address"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    if (self.companyTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please enter your company"];
        [SVProgressHUD dismissWithDelay:1.5f];
        return;
    }
    MTPersonMood *personMode = [MTPersonMood new];
    personMode.headImge = self.headImage;
    personMode.type = self.type;
    personMode.personName = self.nameTextField.text;
    personMode.personPosition = self.positionTextField.text;
    personMode.personTel = self.telTextField.text;
    personMode.personAddress = self.addressTextField.text;
    personMode.personCompany = self.companyTextField.text;
    if (!self.myTextView.text) {
        personMode.personRemarks = @"";
    }else{
        personMode.personRemarks = self.myTextView.text;
    }
    NSMutableArray *myArr = [MTAddPutModeTool getAllCardMode:self.type];
    if (myArr) {
        [myArr addObject:personMode];
    }else{
        myArr = [NSMutableArray new];
        [myArr addObject:personMode];
    }
    [MTAddPutModeTool putAllCardMode:myArr type:self.type];
    MTHomeViewController *con = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2];
    [con getData];
    [con view];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
