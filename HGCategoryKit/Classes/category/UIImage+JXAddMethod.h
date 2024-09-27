//
//  UIImage+JXAddMethod.h
//  JXCommonModule
//
//  Created by yaowei on 2021/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JXAddMethod)
/** Image I/O 获取指定尺寸的图片，返回的结果Image 目标尺寸大小 <= 图片原始尺寸大小
 @param sourceImage ---- 图片
 @param maxPixelSize ---- 图片最大宽/高尺寸 ，设置后图片会根据最大宽/高 来等比例缩放图片

 @return 目标尺寸的图片Image  */
+ (UIImage*) getThumImgOfImgIOWithData:(UIImage*)sourceImage withMaxPixelSize:(NSInteger)maxPixelSize;
@end

NS_ASSUME_NONNULL_END
