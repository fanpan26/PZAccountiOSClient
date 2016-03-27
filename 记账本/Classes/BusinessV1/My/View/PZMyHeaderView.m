//
//  PZMyHeaderView.m
//  记账本
//
//  Created by 范月祥 on 16/3/27.
//  Copyright © 2016年 fyp. All rights reserved.
//

#import "PZMyHeaderView.h"
#import "MSPhotoView.h"
#import "Masonry.h"

@interface PZMyHeaderView()

@property(nonatomic,strong) MSPhotoView *photoView;
@property(nonatomic,strong) UILabel *nameLabel;

@end


@implementation PZMyHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.photoView];
        [self addSubview:self.nameLabel];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"banner-bg-ios"]];
    }
    return self;
}
-(instancetype)initWithPhoto:(NSString *)photo name:(NSString *)name
{
    if (self = [self initWithFrame:CGRectZero]) {
        self.photo = photo;
        self.name = name;
    }
    return self;
}

-(void)layoutSubviews
{
    NSLog(@"%s",__func__);
    [super layoutSubviews];
    CGSize photoViewSize = [MSPhotoView photoSizeWithSize:MSPhotoViewSizeBig];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(20);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(photoViewSize);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.photoView.mas_centerX);
    }];
}

#pragma mark getter setter

-(MSPhotoView *)photoView
{
    NSLog(@"%@",self.photo);
    if (_photoView == nil) {
        _photoView = [[MSPhotoView alloc] initWithPhoto:self.photo size:MSPhotoViewSizeBig];
        _photoView.photoType = MSPhotoViewTypeRound;
    }
    return _photoView;
}

-(UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.text = self.name;
        _nameLabel.textColor = [UIColor whiteColor];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

-(void)setPhoto:(NSString *)photo
{
    _photo = [photo copy];
    [self.photoView setImage:_photo];
}

-(void)setName:(NSString *)name
{
    _name = [name copy];
    self.nameLabel.text = _name;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height = 150;
    [super setFrame:frame];
}

@end
