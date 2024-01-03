//
//  ImageProcessor.h
//  OpenCVSample
//
//  Created by KENJIWADA on 2024/01/02.
//

#ifndef ImageProcessor_h
#define ImageProcessor_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageProcessor : NSObject

+ (UIImage *) convertToGrayscale:(UIImage *) image;

@end

#endif /* ImageProcessor_h */
