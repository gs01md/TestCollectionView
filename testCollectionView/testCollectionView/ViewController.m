//
//  ViewController.m
//  testCollectionView
//
//  Created by WoodGao on 15/12/2.
//  Copyright © 2015年 wood. All rights reserved.
//

#import "ViewController.h"
#import "MyImageCell.h"
#import "WaterFallFlowLayoutGS.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate, WaterFallFlowLayoutGSDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) WaterFallFlowLayoutGS *waterFlow;
@property (strong, nonatomic) NSMutableArray *imgArr;

@end

@implementation ViewController

-(void) initImageArray {
    if (nil == _imgArr) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (int i=1; i<=15; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [tempArr addObject:img];
        }
        
        _imgArr = tempArr;
    }
}

//根据宽度，计算高度
-(CGFloat) heightForImage:(UIImage*)image width:(CGFloat)width {
    return image.size.height/image.size.width * width;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _waterFlow = [[WaterFallFlowLayoutGS alloc]initWithColumCount:2];
    _waterFlow.delegate = self;
    self.collectionView.collectionViewLayout = _waterFlow;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyImageCell" bundle:nil] forCellWithReuseIdentifier:@"MyImageCell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    
    [self initImageArray];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imgArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MyImageCell" forIndexPath:indexPath];
    cell.image.image = _imgArr[indexPath.item];
    
    return cell;
}

-(CGFloat)getHeightWithWaterFallFlowLayout:(WaterFallFlowLayoutGS *)flowLayout width:(CGFloat)width indexPath:(NSIndexPath *)indexPath{
    CGFloat height = [self heightForImage:_imgArr[indexPath.item] width:width];
    return height;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"当前选中的item 是 %ld",(long)indexPath.row);
    
}

@end
