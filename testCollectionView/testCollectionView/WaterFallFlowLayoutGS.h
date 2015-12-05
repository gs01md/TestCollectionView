//
//  WaterFallFlowLayoutGS.h
//  testCollectionView
//
//  Created by WoodGao on 15/12/4.
//  Copyright © 2015年 wood. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFallFlowLayoutGS;

@protocol WaterFallFlowLayoutGSDelegate <NSObject>

//cell 高度
-(CGFloat)getHeightWithWaterFallFlowLayout:(WaterFallFlowLayoutGS*)flowLayout width:(CGFloat)width indexPath:(NSIndexPath*)indexPath;

@end

@interface WaterFallFlowLayoutGS : UICollectionViewFlowLayout

-(instancetype)initWithColumCount:(int)count;

@property (nonatomic, weak) id<WaterFallFlowLayoutGSDelegate> delegate;

@end
