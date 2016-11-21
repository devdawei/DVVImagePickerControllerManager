//
//  DVVImagePickerControllerManager.h
//  DVVImagePickerControllerManager <https://github.com/devdawei/DVVImagePickerControllerManager.git>
//
//  Created by 大威 on 16/6/16.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVImagePickerControllerManager : NSObject

/**
 *  显示拍照和从相册选择的 ActionSheetView
 *  对UIImagePickerController的封装，具有用户授权检测，在用户未允许的情况下，提供直接跳转到设置面板去设置，使用简单方便
 *
    在 delegate 类中要遵循 UIImagePickerControllerDelegate
    实现 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 方法
    在此方法中处理拍照或选择的图片
    例如：
      1.获取原图片
        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
      2.获取编辑过后的图片
        UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
 *
 *  @param fromController 从此控制器present出来UIImagePickerController
 *  @param delegate       执行UIImagePickerController的代理方法的对象
 *  @param canEdit        是否可以编辑图片
 */
+ (void)showFromController:(UIViewController *)fromController
                  delegate:(id)delegate
                   canEdit:(BOOL)canEdit;

@end
