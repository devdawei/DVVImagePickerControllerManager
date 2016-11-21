//
//  DVVImagePickerControllerManager.m
//  DVVImagePickerControllerManager <https://github.com/devdawei/DVVImagePickerControllerManager.git>
//
//  Created by 大威 on 16/6/16.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVImagePickerControllerManager.h"
#import <DVVActionSheetView/DVVActionSheetView.h>
#import <DVVAlertView/DVVAlertView.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@implementation DVVImagePickerControllerManager

+ (void)showFromController:(UIViewController *)fromController
                  delegate:(id)delegate
                   canEdit:(BOOL)canEdit
{
    DVVActionSheetView *actionSheetView = [[DVVActionSheetView alloc] initWithTitle:@"请选择图片采集方式"];
    
    DVVAlertAction *cancelAction = [DVVAlertAction actionWithTitle:@"拍照" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
        
        // 检测摄像头的状态
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus)
        {
            // 用户拒绝App使用
            [DVVAlertView showAlertWithTitle:@"相机不可用"
                                     message:@"请在设置中开启相机服务"
                                buttonTitles:@[@"知道了", @"去设置"]
                                  completion:^(NSUInteger idx) {
                                      if (1 == idx)
                                      {
                                          // 打开应用设置面板
                                          [self goAppSetting];
                                      }
                                  }];
            return ;
        }
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.view.backgroundColor = [UIColor whiteColor];
            picker.allowsEditing = canEdit;
            picker.delegate = delegate;
            UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                type = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            picker.sourceType = type;
            
            if (fromController.navigationController)
            {
                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                picker.navigationBar.titleTextAttributes = fromController.navigationController.navigationBar.titleTextAttributes;
            }
            
            [fromController presentViewController:picker animated:YES completion:nil];
        }
        
    }];
    
    DVVAlertAction *okAction = [DVVAlertAction actionWithTitle:@"从相册选择" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
        
        BOOL flage = YES;
        // 检测照片库授权状态
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
        {
            PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
            if (PHAuthorizationStatusDenied == authStatus)
            {
                flage = false;
            }
        }
        else
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
            ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
            if (ALAuthorizationStatusDenied == authStatus)
            {
                flage = false;
            }
#pragma clang diagnostic pop
        }
        
        if (!flage)
        {
            // 用户拒绝App使用
            [DVVAlertView showAlertWithTitle:@"相册不可用"
                                     message:@"请在设置中开启相册服务"
                                buttonTitles:@[@"知道了", @"去设置"]
                                  completion:^(NSUInteger idx) {
                                      if (0 == idx)
                                      {
                                          // 打开应用设置面板
                                          [self goAppSetting];
                                      }
                                  }];
            return ;
        }
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.view.backgroundColor = [UIColor whiteColor];
            picker.allowsEditing = canEdit;
            picker.delegate = delegate;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            
            if (fromController.navigationController)
            {
                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                picker.navigationBar.titleTextAttributes = fromController.navigationController.navigationBar.titleTextAttributes;
            }
            
            [fromController presentViewController:picker animated:YES completion:nil];
        }
        
    }];
    
    [actionSheetView addActions:@[ cancelAction, okAction ]];
    
    [actionSheetView show];
}

+ (void)goAppSetting
{
    // 打开应用设置面板
    NSURL *appSettingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:appSettingUrl])
    {
        if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
        {
            [app openURL:appSettingUrl options:@{} completionHandler:^(BOOL success) {
                if (!success) [self showJumpErrorAlert];
            }];
        }
        else
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
            [app openURL:appSettingUrl];
#pragma clang diagnostic pop
        }
    }
    else
    {
        [self showJumpErrorAlert];
    }
}

+ (void)showJumpErrorAlert
{
    [DVVAlertView showAlertWithTitle:@"跳转失败"
                             message:@"请手动到设置中打开服务"
                        buttonTitles:@[@"取消"]
                          completion:nil];
}

@end
