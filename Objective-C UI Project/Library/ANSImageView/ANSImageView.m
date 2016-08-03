//
//  ANSImageView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageView.h"

#import "ANSImageModel.h"
#import "ANSBlockObservationController.h"
#import "ANSGCD.h"
#import "ANSMacros.h"

@interface ANSImageView ()
@property (nonatomic, strong) ANSBlockObservationController *controller;

- (void)prepareController:(ANSBlockObservationController *)controller;

@end

@implementation ANSImageView

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.contentImageView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (self.contentImageView) {
        [self initSubviews];
    }
}

- (void)initSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask =  UIViewAutoresizingFlexibleWidth
                                | UIViewAutoresizingFlexibleHeight
                                | UIViewAutoresizingFlexibleLeftMargin
                                | UIViewAutoresizingFlexibleRightMargin
                                | UIViewAutoresizingFlexibleTopMargin
                                | UIViewAutoresizingFlexibleBottomMargin;
    
    self.contentImageView = imageView;
}

#pragma mark -
#pragma mark Accsessors

- (void)setContentImageView:(UIImageView *)contentImageView {
    if (_contentImageView != contentImageView) {
        [_contentImageView removeFromSuperview];
        _contentImageView = contentImageView;
        [self addSubview:contentImageView];
    }
}

- (void)setImageModel:(ANSImageModel *)imageModel {
    if(_imageModel != imageModel) {
        _imageModel = imageModel;
        
        self.controller = [_imageModel blockControllerWithObserver:self];
    }
}

- (void)setController:(ANSBlockObservationController *)controller {
    if (_controller != controller) {
        _controller = controller;
        
        [self prepareController:controller];
    }
}

#pragma mark -
#pragma mark Private

- (void)prepareController:(ANSBlockObservationController *)controller {
    ANSWeakify(self);
    
    ANSStateChangeBlock block = ^(ANSBlockObservationController *controller, id userInfo) {
        ANSPerformInMainQueue(dispatch_sync, ^{
            ANSStrongify(self);
            
            ANSImageModel *model = controller.observableObject;
            self.contentImageView.image = model.image;
        });
    };
    
    [controller setBlock:block forState:ANSImageModelLoaded];
    [controller setBlock:block forState:ANSImageModelUnloaded];
    
    block = ^(ANSBlockObservationController *controller, id userInfo) {
        ANSStrongify(self);
        
        [self.imageModel load];
    };
    
    [controller setBlock:block forState:ANSImageModelFailedLoadin];
}

@end
