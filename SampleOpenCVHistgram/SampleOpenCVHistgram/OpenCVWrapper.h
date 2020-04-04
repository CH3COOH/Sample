#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject

+ (void) makeHistgramFromImage:(UIImage*)image;
//+ (IplImage *)createIplImageFromUIImage:(UIImage *)uiImage;

@end

NS_ASSUME_NONNULL_END
