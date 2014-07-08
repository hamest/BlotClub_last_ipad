
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface LBAsyncImageView : UIImageView <NSURLConnectionDelegate, NSCopying> {
    NSURLConnection* connection;
    NSMutableData* data;
    SEL onReady;
    id target;
	UIActivityIndicatorView *activityIndicator;
    UIImage *image;
}

@property (assign) SEL onReady;
@property (assign) id target;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicator;
//@property (nonatomic,retain) UIImage *image;

- (void) loadImageFromURL:(NSURL*)url;
- (void) imageReady:(NSData*)data;
- (void) cancelLoad;

@end