//
//  ViewController.m
//  DVVImagePickerControllerManager
//
//  Created by 大威 on 2016/11/21.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "ViewController.h"
#import "DVVImagePickerControllerManager.h"

@interface ViewController () <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
    [_imageView addGestureRecognizer:ges];
    _imageView.userInteractionEnabled = YES;
}

- (void)clickAction
{
    [DVVImagePickerControllerManager showFromController:self delegate:self canEdit:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage *originalImage = [info valueForKey:UIImagePickerControllerOriginalImage]; // 原图
//    _imageView.image = originalImage;
    UIImage *editedImage = [info valueForKey:UIImagePickerControllerEditedImage]; // 编辑后的图片
    _imageView.image = editedImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
