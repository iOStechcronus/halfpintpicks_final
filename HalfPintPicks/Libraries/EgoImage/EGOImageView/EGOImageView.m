//
//  EGOImageView.m
//  EGOImageLoading
//
//  Created by Shaun Harrison on 9/15/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGOImageView.h"
#import "EGOImageLoader.h"

@implementation EGOImageView
{
    UIActivityIndicatorView *spinny;
}
@synthesize imageURL, placeholderImage, delegate;

- (id)initWithPlaceholderImage:(UIImage*)anImage {
	return [self initWithPlaceholderImage:anImage delegate:nil];	
}

- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate {
	if((self = [super initWithImage:anImage])) {
		self.placeholderImage = anImage;
		self.delegate = aDelegate;
    	}
	
	return self;
}

- (void)setImageURL:(NSURL *)aURL {
    if(imageURL) {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		imageURL = nil;
	}
	
	if(!aURL) {
		self.image = self.placeholderImage;
		imageURL = nil;
		return;
	} else {
		imageURL = aURL ;
	}
    #define SPINNY_TAG 5555
    spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinny.tag = SPINNY_TAG;
    spinny.center = self.center;
    
    if ([[GeneralDeclaration generalDeclaration].currentScreen isEqualToString:@"NewsCommentScreen"])
            spinny.frame = CGRectMake(spinny.frame.origin.x - 5, spinny.frame.origin.y - 5 , 0 , 0);
    else if([[GeneralDeclaration generalDeclaration].currentScreen isEqualToString:@"MenuOptionScreen"])
        spinny.frame = CGRectMake(spinny.frame.origin.x - 10, spinny.frame.origin.y - 18 , 0 , 0);
    else if([[GeneralDeclaration generalDeclaration].currentScreen isEqualToString:@"MyProfileDisplayViewController"])
        spinny.frame = CGRectMake(spinny.frame.origin.x , spinny.frame.origin.y , 0 , 0);
    else if([[GeneralDeclaration generalDeclaration].currentScreen isEqualToString:@"SuggestedUserScreen"])
        spinny.frame = CGRectMake(spinny.frame.origin.x -15 , spinny.frame.origin.y - 2, 10 , 10);
    else if ([[GeneralDeclaration generalDeclaration].currentScreen isEqualToString:@"ItemDetailsScreen"])
        spinny.frame = CGRectMake(spinny.frame.origin.x + 5, spinny.frame.origin.y + 5 , 0 , 0);
    else if ([[GeneralDeclaration generalDeclaration].currentScreen isEqualToString:@"ItemSearchViewController"])
        spinny.frame = CGRectMake(spinny.frame.origin.x -15, spinny.frame.origin.y + 5, 0 , 0);
    else
        spinny.frame = CGRectMake(spinny.frame.origin.x  , spinny.frame.origin.y , 10 , 10);
    
    [spinny startAnimating];
    [self addSubview:spinny];

	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	UIImage* anImage = [[EGOImageLoader sharedImageLoader] imageForURL:aURL shouldLoadWithObserver:self];
	
	if(anImage) {
		self.image = anImage;

		// trigger the delegate callback if the image was found in the cache
		if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
			[self.delegate imageViewLoadedImage:self];
		}
	} else {
		self.image = self.placeholderImage;
	}
}

#pragma mark -
#pragma mark Image loading

- (void)cancelImageLoad {
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.imageURL];
	[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:self.imageURL];
}

- (void)clearCacheForURL:(NSURL *)aURL {
    if(aURL)
    {
        [[EGOImageLoader sharedImageLoader] clearCacheForURL:aURL];
        [[EGOImageLoader sharedImageLoader] removeObserver:self forURL:aURL];
        
    }
}

- (void)imageLoaderDidLoad:(NSNotification*)notification {
    
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;

	UIImage* anImage = [[notification userInfo] objectForKey:@"image"];
	self.image = anImage;
	[self setNeedsDisplay];
    [spinny removeFromSuperview];

	if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
		[self.delegate imageViewLoadedImage:self];
	}	
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
    [spinny removeFromSuperview];

	if([self.delegate respondsToSelector:@selector(imageViewFailedToLoadImage:error:)]) {
		[self.delegate imageViewFailedToLoadImage:self error:[[notification userInfo] objectForKey:@"error"]];
	}
}

- (void)dealloc {
    if(imageURL)
        //[[EGOImageLoader sharedImageLoader] cancelLoadForURL:imageURL];
    
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	self.delegate = nil;
	self.imageURL = nil;
	self.placeholderImage = nil;
    spinny=nil;
}


@end
