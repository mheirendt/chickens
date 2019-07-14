/*
 * CCVideoPlayer
 *
 * Cocos2D-iPhone-Extensions v0.2.1
 * https://github.com/cocos2d/cocos2d-iphone-extensions
 *
 * Copyright (c) 2010-2012 Stepan Generalov
 * Copyright (c) 2011 Patrick Wolowicz
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED

#import "cocos2d.h"

#import "CCVideoPlayer.h"
#import "CCVideoPlayerImpliOS.h"
#import "MediaPlayer/MediaPlayer.h"
#import "videoOverlayView.h"

@interface CCVideoPlayerImpliOS ()

@property (nonatomic, strong) MPMoviePlayerController* theMovie;
@property (nonatomic, strong) VideoOverlayView* videoOverlayView;

@end

@implementation CCVideoPlayerImpliOS

@synthesize isPlaying = _playing;

- (id) init
{
    if ( (self = [super init]) )
    {
        self.theMovie = nil;
    }
    return self;
}

- (void) setupViewAndPlay
{
    //UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
	UIView* keyWindow = [CCDirector sharedDirector].view;
	
	[keyWindow addSubview:self.theMovie.view];
	self.theMovie.view.hidden = NO;
	self.theMovie.view.frame = keyWindow.bounds;
	self.theMovie.view.center = keyWindow.center;
	self.theMovie.view.contentMode = UIViewContentModeScaleAspectFit;

	// Movie playback is asynchronous, so this method returns immediately.
	[self.theMovie play];

	self.videoOverlayView = [ [VideoOverlayView alloc] initWithFrame:self.theMovie.view.frame];
	
	[keyWindow addSubview:self.videoOverlayView];
}

//----- playMovieAtURL: ------
-(void)playMovieAtURL:(NSURL*)theURL
{
	_playing = YES;

	[self.delegate movieStartsPlaying]; // RAG: Seems premature - shouldn't this be in the setupViewAndPlay where it actually starts?

	self.theMovie = [[MPMoviePlayerController alloc] initWithContentURL:theURL];
	if (! self.theMovie)
		_playing = NO;

	self.theMovie.controlStyle = MPMovieControlStyleNone; // TODO: Expose this to caller??

	// Register for the playback finished notification.
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(movieFinishedCallback:)
												 name:MPMoviePlayerPlaybackDidFinishNotification
											   object:self.theMovie];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(preparedToPlayCallback:)
												 name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
											   object:self.theMovie];
	[self.theMovie prepareToPlay];
}

//----- movieFinishedCallback -----
-(void)movieFinishedCallback:(NSNotification*)aNotification
{
    MPMoviePlayerController* theMovie = [aNotification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    
    // Release the movie instance created in playMovieAtURL:
	[self.theMovie.view removeFromSuperview];
    self.theMovie = nil;
	_playing = NO;
    
	[self.videoOverlayView removeFromSuperview];
	self.videoOverlayView = nil;
	
    [self.delegate moviePlaybackFinished];
}

-(void)preparedToPlayCallback:(NSNotification*)aNotification
{
    MPMoviePlayerController* theMovie = [aNotification object];
    
    if (theMovie.isPreparedToPlay)
	{
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                      object:theMovie];
        [self setupViewAndPlay];
    }
}

- (void) setNoSkip:(BOOL)value;
{
    noSkip=value;
}

- (void) userCancelPlaying
{
	if (!noSkip)
	{
		BOOL cancelPlaying = YES;
		if ([self.delegate respondsToSelector:@selector(userTouch)])
		{
			cancelPlaying = [self.delegate userTouch];
		}
		
		if (cancelPlaying)
			[self cancelPlaying];
	}
}

- (void) cancelPlaying
{
	[self.theMovie stop];
}

@end

#endif

