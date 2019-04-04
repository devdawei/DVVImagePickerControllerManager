

Pod::Spec.new do |s|

s.name         = 'DVVImagePickerControllerManager'
s.summary      = '对UIImagePickerController的封装。'
s.version      = '1.0.1'
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.authors      = { 'devdawei' => '2549129899@qq.com' }
s.homepage     = 'https://github.com/devdawei'

s.platform     = :ios
s.ios.deployment_target = '7.0'
s.requires_arc = true

s.source       = { :git => 'https://github.com/devdawei/DVVImagePickerControllerManager.git', :tag => s.version.to_s }

s.source_files = 'DVVImagePickerControllerManager/DVVImagePickerControllerManager/*.{h,m}'

s.frameworks = 'Foundation', 'UIKit'

end
