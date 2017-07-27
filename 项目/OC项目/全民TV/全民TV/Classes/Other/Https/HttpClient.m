//
//  HttpClient.m
//  全民TV
//
//  Created by 金亮齐 on 2017/7/27.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import "HttpClient.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation HttpClient

static HttpClient *httpClient;

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpClient = [[self alloc]init];
    });
    return httpClient;
}

static AFHTTPSessionManager *magager;

+ (AFHTTPSessionManager *)sharedAFManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        magager = [AFHTTPSessionManager manager];
        magager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
        // 设置超时时间
        magager.requestSerializer.timeoutInterval = HTTP_TIMEOUT;
    });
    return magager;
}

+ (void)requestWithType:(HttpRequestType)type
              UrlString:(NSString *)urlString
             Parameters:(NSDictionary *)parameters
           SuccessBlock:(HTTPRequestSuccessBlock)successBlock
           FailureBlock:(HTTPRequestFailedBlock)failureBlock
{
    if (urlString == nil)
    {
        return;
    }
    NSString *URLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (type == HttpRequestTypeGet)
    {
        
        [[self sharedAFManager] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (successBlock)
            {
                successBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failureBlock)
            {
                failureBlock(error);
            }
            
        }];
    }else if (type == HttpRequestTypePost)
    {
        
        [[self sharedAFManager] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (successBlock)
            {
                successBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failureBlock)
            {
                failureBlock(error);
            }
            
        }];
    }
}

+ (void)startNetWorkMonitoring
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                _NetWork.netWorkStatus = NetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络");
                _NetWork.netWorkStatus = NetworkStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 2G/3G/4G
                NSLog(@"手机自带网络");
                _NetWork.netWorkStatus = NetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                _NetWork.netWorkStatus = NetworkStatusReachableViaWiFi;
                NSLog(@"WIFI--%lu", (unsigned long)_NetWork.netWorkStatus);
                break;
        }
    }];
    [manager startMonitoring];
}



@end
