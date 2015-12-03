//
//  ViewController.m
//  testCollectionView
//
//  Created by WoodGao on 15/12/2.
//  Copyright © 2015年 wood. All rights reserved.
//

#import "ViewController.h"
#import "MyImageCell.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyImageCell" bundle:nil] forCellWithReuseIdentifier:@"MyImageCell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MyImageCell" forIndexPath:indexPath];
    cell.image.image = [UIImage imageNamed:@"3.png"];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - self.flowLayout.minimumInteritemSpacing)/2;
    return CGSizeMake(width, 100);
}


@end
