//
//  WallPaperModel.h
//  Puzzle
//
//  Created by The Clouds on 2018/11/19.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WallPaperModel : NSObject
@property (nonatomic, assign) NSInteger atime;
@property (nonatomic, strong) NSArray * cid;
@property (nonatomic, assign) BOOL cr;
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, assign) NSInteger favs;
@property (nonatomic, copy) NSString * idField;
@property (nonatomic, copy) NSString * img;
@property (nonatomic, assign) NSInteger ncos;
@property (nonatomic, copy) NSString * preview;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, copy) NSString * rule;
@property (nonatomic, copy) NSString * ruleNew;
@property (nonatomic, copy) NSString * sourceType;
@property (nonatomic, copy) NSString * store;
@property (nonatomic, strong) NSArray * tag;
@property (nonatomic, copy) NSString * thumb;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, strong) NSArray * url;
@property (nonatomic, assign) NSInteger views;
@property (nonatomic, copy) NSString * wp;
@property (nonatomic, assign) BOOL xr;
@property (nonatomic, assign) BOOL isStar;

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * ename;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * rname;
@property (nonatomic, copy) NSString * icover;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, copy) NSString * coverTemp;
@property (nonatomic, copy) NSString * picassoCover;

@end

NS_ASSUME_NONNULL_END
