#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/core/types_c.h>

#import "OpenCVWrapper.h"

@implementation OpenCVWrapper

+(void) makeHistgramFromImage:(UIImage *)image
{
  cv::Mat imageMat;
  UIImageToMat(image, imageMat);

  cv::Mat grayMat;
  cv::cvtColor (imageMat, grayMat, CV_BGR2GRAY);
  image = MatToUIImage(grayMat);

  IplImage *gray = [OpenCVWrapper createIplImageFromUIImage:image];

  float range[]={0,255};

  float* ranges[]={range};
  int histSize;
  histSize=256;
  CvHistogram* hist;

  hist=cvCreateHist(1,&histSize,CV_HIST_ARRAY,ranges,1);

  cvCalcHist(&gray,hist,0,NULL);
    
  cvReleaseImage(&gray);
}

+ (IplImage *)createIplImageFromUIImage:(UIImage *)uiImage
{
  CGImageRef imageRef = uiImage.CGImage;
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  IplImage *iplimage = cvCreateImage(cvSize(uiImage.size.width, uiImage.size.height), IPL_DEPTH_8U, 4);

  CGContextRef contextRef = CGBitmapContextCreate(
  iplimage->imageData,
  iplimage->width,
  iplimage->height,
  iplimage->depth,
  iplimage->widthStep,
  colorSpace,
  kCGImageAlphaPremultipliedLast | kCGBitmapByteOrderDefault);

  CGContextDrawImage(contextRef, CGRectMake(0, 0, uiImage.size.width, uiImage.size.height), imageRef);
  CGContextRelease(contextRef);
  CGColorSpaceRelease(colorSpace);

  IplImage *outputImage = cvCreateImage(cvGetSize(iplimage), IPL_DEPTH_8U, 1); //modify
  cvCvtColor(iplimage, outputImage, CV_RGB2GRAY); //modify

  cvReleaseImage(&iplimage);
  return outputImage;
}

@end
