//
//  DownUtils.h
//  flutter_uniapp
//
//  Created by sn on 2023/5/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownUtils : NSObject

+ (void)downFile:(NSString *)url success:(void(^)(NSString *path))successBlock;

@end

NS_ASSUME_NONNULL_END
