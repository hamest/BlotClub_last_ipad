
#import "LBAsycImageView.h"

// Adapted from Mark J. AsyncImageView
// http://www.markj.net/iphone-asynchronous-table-image/

@implementation LBAsyncImageView

@synthesize onReady;
@synthesize target;
@synthesize activityIndicator;
//@synthesize image;

- (void)dealloc {
    [connection cancel];
    [connection release];
    [data release];
	
	if(activityIndicator)
		[activityIndicator release];
    
	
    [super dealloc];
}

- (void)loadImageFromURL:(NSURL*)url {
    if([[url absoluteString] length] == 0) {
        return;
    }
    
    if (connection!=nil) {
        [connection cancel];
        [connection release];
        connection = nil;
    }
    if (data!=nil) {
        [data release];
        data = nil;
    }
    
	if(activityIndicator == nil) {
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite/*UIActivityIndicatorViewStyleWhiteLarge*/];
        activityIndicator.alpha=0.8;        
        
        [self addSubview:activityIndicator];
		[self bringSubviewToFront:activityIndicator];
 
        CGPoint centerPoint = CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y);
        activityIndicator.center = centerPoint;
		activityIndicator.hidesWhenStopped = YES;
	}
	[activityIndicator startAnimating];
    self.image = nil;
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];

    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                          forMode:NSDefaultRunLoopMode];
    [connection start];

}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
    if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    [connection release];
    connection=nil;    

	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	[activityIndicator release];
	activityIndicator = nil;	
	
	[self imageReady: data];
    [data release];
    data=nil;
}

- (void)imageReady:(NSData*)imgData {
    self.image = [UIImage imageWithData: imgData];
    [self setNeedsLayout];

    if(target != nil && onReady != nil) {
        NSMethodSignature * sig = nil;
        sig = [[target class] instanceMethodSignatureForSelector: onReady];

        NSInvocation * myInvocation = nil;
        myInvocation = [NSInvocation invocationWithMethodSignature: sig];
        [myInvocation setArgument: &self atIndex: 2];
        [myInvocation setTarget: target];
        [myInvocation setSelector: onReady];
        [myInvocation invoke];
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    return [self retain];
}

- (void)cancelLoad {
    [connection cancel];
    [connection release];
    connection = nil;
}

@end