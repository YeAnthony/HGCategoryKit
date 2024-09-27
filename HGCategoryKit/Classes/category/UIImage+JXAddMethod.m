//
//  UIImage+JXAddMethod.m
//  JXCommonModule
//
//  Created by yaowei on 2021/8/18.
//

#import "UIImage+JXAddMethod.h"

@implementation UIImage (JXAddMethod)

/** Image I/O 获取指定尺寸的图片，返回的结果Image 目标尺寸大小 <= 图片原始尺寸大小
 @param sourceImage ---- 图片
 @param maxPixelSize ---- 图片最大宽/高尺寸 ，设置后图片会根据最大宽/高 来等比例缩放图片

 @return 目标尺寸的图片Image  */
+ (UIImage*) getThumImgOfImgIOWithData:(UIImage*)sourceImage withMaxPixelSize:(NSInteger)maxPixelSize{
    @autoreleasepool {
        NSData *data = UIImagePNGRepresentation(sourceImage);
        UIImage *imgResult = nil;
        if(data == nil)         { return imgResult; }
        if(data.length <= 0)    { return imgResult; }
        if(maxPixelSize <= 0)   { return imgResult; }
        
        const float scale = [UIScreen mainScreen].scale;
        const int sizeTo = maxPixelSize * scale;
        CFDataRef dataRef = (__bridge CFDataRef)data;
        
        /* CGImageSource的键值说明
         kCGImageSourceCreateThumbnailWithTransform - 设置缩略图是否进行Transfrom变换
         kCGImageSourceCreateThumbnailFromImageAlways - 设置是否创建缩略图，无论原图像有没有包含缩略图，默认kCFBooleanFalse，影响 CGImageSourceCreateThumbnailAtIndex 方法
         kCGImageSourceCreateThumbnailFromImageIfAbsent - 设置是否创建缩略图，如果原图像有没有包含缩略图，则创建缩略图，默认kCFBooleanFalse，影响 CGImageSourceCreateThumbnailAtIndex 方法
         kCGImageSourceThumbnailMaxPixelSize - 设置缩略图的最大宽/高尺寸 需要设置为CFNumber值，设置后图片会根据最大宽/高 来等比例缩放图片
         kCGImageSourceShouldCache - 设置是否以解码的方式读取图片数据 默认为kCFBooleanTrue，如果设置为true，在读取数据时就进行解码 如果为false 则在渲染时才进行解码 */
        CFDictionaryRef dicOptionsRef = (__bridge CFDictionaryRef) @{
                                                                     (id)kCGImageSourceCreateThumbnailFromImageIfAbsent : @(YES),
                                                                     (id)kCGImageSourceThumbnailMaxPixelSize : @(sizeTo),
                                                                     (id)kCGImageSourceShouldCache : @(YES),
                                                                     };
        CGImageSourceRef src = CGImageSourceCreateWithData(dataRef, nil);
        CGImageRef thumImg = CGImageSourceCreateThumbnailAtIndex(src, 0, dicOptionsRef); //注意：如果设置 kCGImageSourceCreateThumbnailFromImageIfAbsent为 NO，那么 CGImageSourceCreateThumbnailAtIndex 会返回nil
        
        CFRelease(src); // 注意释放对象，否则会产生内存泄露
        
        imgResult = [UIImage imageWithCGImage:thumImg scale:scale orientation:UIImageOrientationUp];
        
        if(thumImg != nil){
            CFRelease(thumImg); // 注意释放对象，否则会产生内存泄露
        }
        
        return imgResult;
    }
   
}
@end
