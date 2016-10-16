//
//  UIAlertController+NSError.h
//  untitled
//
//  Created by Christian Wen on 10/16/16.
//  Copyright © 2016 edgarchu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (ErrorRecovery)
typedef void (^ErrorRecoveryCompletionBlock)(BOOL recovered, NSNumber *_Nullable optionIndex);

NS_ASSUME_NONNULL_BEGIN
+ (instancetype)alertControllerWithError:(NSError *)error preferredStyle:(UIAlertControllerStyle)preferredStyle completionBlock:(ErrorRecoveryCompletionBlock)block;
NS_ASSUME_NONNULL_END
@end
