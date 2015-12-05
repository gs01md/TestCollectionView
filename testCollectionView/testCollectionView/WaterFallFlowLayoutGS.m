//
//  WaterFallFlowLayoutGS.m
//  testCollectionView
//
//  Created by WoodGao on 15/12/4.
//  Copyright © 2015年 wood. All rights reserved.
//

#import "WaterFallFlowLayoutGS.h"

@interface WaterFallFlowLayoutGS(){
    
    int columnCount;//列数
}

//每一列的当前高度的最大值
@property (nonatomic, strong) NSMutableDictionary *maxHeights;

//所有布局属性
@property (nonatomic, strong) NSMutableArray *attributesArray;

@end

@implementation WaterFallFlowLayoutGS

-(instancetype) initWithColumCount:(int)count{
    
    if (self = [super init]) {
        columnCount = count;
        self.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
        self.minimumLineSpacing = 5.0;
        self.minimumInteritemSpacing = 5.0;
    }
    return self;
}

#pragma mark - 懒加载变量
-(NSMutableDictionary *)maxHeights{
    if (!_maxHeights) {
        _maxHeights = [NSMutableDictionary dictionary];
        for (int i = 0; i < columnCount; i++) {
            NSString *column = [NSString stringWithFormat:@"%d",i];
            self.maxHeights[column] = @"0";
        }
    }
    return _maxHeights;
}

-(NSMutableArray *)attributesArray{
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

#pragma mark - 初始化所有属性值
-(void)prepareLayout{
    
    //初始化每列的Y坐标，即在最顶端
    for (int i = 0; i < columnCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d",i];
        self.maxHeights[column] = @(self.sectionInset.top);
    }
    [self.attributesArray removeAllObjects];
    
    //1.查看共有多少个元素
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //2.遍历每个item属性
    for (int i = 0; i < count; i++) {
        
        //3.取出布局属性
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        //4.添加到数组中
        [self.attributesArray addObject:attr];
    }
    
}

#pragma mark - 设置整个collectionView的ContentSize
-(CGSize)collectionViewContentSize{
    __block NSString *maxColumn = @"0";
    [self.maxHeights enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL * stop) {
        if ([maxY floatValue] > [self.maxHeights[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    
    return CGSizeMake(0, [self.maxHeights[maxColumn] floatValue] + self.sectionInset.bottom);
    
}

#pragma mark - 设置所有cell的大小及位置
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attributesArray;
}

#pragma mark - 计算每个cell的大小、位置等属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //每列中都可能已经有多个元素，找出所有列中 Y坐标 的最大值中的最小值
    __block NSString *miniColumn = @"0";
    [self.maxHeights enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL * stop) {
        if ([maxY floatValue] < [self.maxHeights[miniColumn] floatValue]) {
            miniColumn = column;
        }
        
    }];
    
    
    //计算frame
    CGFloat width = (CGRectGetWidth(self.collectionView.frame) - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * (columnCount - 1))/columnCount;
    CGFloat height = [self.delegate getHeightWithWaterFallFlowLayout:self width:width indexPath:indexPath];
    CGFloat x = self.sectionInset.left + (width + self.minimumInteritemSpacing)*[miniColumn intValue];
    CGFloat y = [self.maxHeights[miniColumn] floatValue] + self.minimumInteritemSpacing;
    self.maxHeights[miniColumn] = @(height + y);
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.frame = CGRectMake(x, y, width, height);
    
    
    return attr;
}


@end
