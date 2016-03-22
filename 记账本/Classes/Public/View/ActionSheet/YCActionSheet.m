//
//  YCActionSheet.m
//  SimpleSelectionView
//
//  Created by 范月成 on 16/3/18.
//  Copyright © 2016年  Will. All rights reserved.
//

#import "YCActionSheet.h"

static NSString *const kSelectionCellNameKey = @"SelectionCellNameKey";
static NSString *const kSelectionCellTextColorKey = @"SelectionCellTextColorKey";
static NSString *const kSelectionCellTagKey = @"SelectionCellTagKey";
static NSString *const kSelectionViewShouldDismissKey = @"SelectionViewShouldDismissKey";

static NSString *const kSelectionItemNameKey = @"SelectionItemNameKey";
static NSString *const kSelectionItemTextColorKey = @"SelectionItemTextColorKey";
static NSString *const kSelectionItemTagKey = @"SelectionItemTagKey";
static NSString *const kShareViewShouldDismissKey = @"ShareViewShouldDismissKey";
static NSString *const kSelectionItemImageNameKey = @"SelectionItemImageNameKey";

#pragma mark - YCSelectionItems

@interface YCSelectionItems : NSObject <YCActionSheetProtocol>

@property (nonatomic, strong) NSMutableArray *itemsArray;

- (NSInteger) count;

@end

@implementation YCSelectionItems

- (instancetype)init{
    self = [super init];
    if (self) {
        self.itemsArray = [NSMutableArray array];
    }
    return self;
}


- (void)addItemWithLabelText:(NSString *)labelText textColor:(NSString *)textColor shouldDismiss:(BOOL)shouldDismiss {
    if (labelText && [labelText isKindOfClass:[NSString class]]) {
        NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys: labelText, kSelectionCellNameKey, [NSNumber numberWithBool:shouldDismiss], kSelectionViewShouldDismissKey, textColor, kSelectionCellTextColorKey, nil];
        [self.itemsArray addObject:itemDic];
    }
}

- (NSInteger)count{
    return self.itemsArray.count;
}

@end


#pragma mark - YCShareItems

@interface YCShareItems : NSObject <YCShareViewProtocol>

@property (nonatomic, strong) NSMutableArray *shareItemsArray;
@property (nonatomic, strong) NSMutableArray *shareOthersArray;

@end

@implementation YCShareItems

- (instancetype)init{
    self = [super init];
    if (self) {
        self.shareItemsArray = [NSMutableArray array];
        self.shareOthersArray = [NSMutableArray array];
    }
    return self;
}


- (void)addItemWithLabelText:(NSString *)labelText imageName:(NSString *)imageName textColor:(NSString *)textColor shouldDismiss:(BOOL)shouldDismiss isShare:(BOOL)isShare {
    if (isShare) {
        if (labelText && [labelText isKindOfClass:[NSString class]] && imageName && [imageName isKindOfClass:[NSString class]]) {
            NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys: labelText, kSelectionItemNameKey, [NSNumber numberWithBool:shouldDismiss], kShareViewShouldDismissKey, imageName, kSelectionItemImageNameKey, textColor, kSelectionItemTextColorKey, nil];
            [self.shareItemsArray addObject:itemDic];
        }
    } else {
        if (labelText && [labelText isKindOfClass:[NSString class]] && imageName && [imageName isKindOfClass:[NSString class]]) {
            NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys: labelText, kSelectionItemNameKey, [NSNumber numberWithBool:shouldDismiss], kShareViewShouldDismissKey, imageName, kSelectionItemImageNameKey, textColor, kSelectionItemTextColorKey, nil];
            [self.shareOthersArray addObject:itemDic];
        }
    }
    
}

@end

#pragma mark - YCCollectionViewCell

@interface YCCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *labelView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation YCCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        
        //文字
        UILabel *labelView = [[UILabel alloc] init];
        [self.contentView addSubview:labelView];
        self.labelView = labelView;
        labelView.textAlignment = NSTextAlignmentCenter;
        labelView.font = [UIFont systemFontOfSize:kShareTextFontSize];
        [labelView setTextColor:[UIColor blackColor]];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 4;
        imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = kShareCellHeight - kLableHeight;
    CGFloat labelH = kShareCellHeight - kLableHeight;
    self.imageView.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    CGFloat lineX = 0;
    CGFloat lineW = kShareCellHeight - kLableHeight;
    CGFloat lineH = kLableHeight;
    CGFloat lineY = self.bounds.size.height-lineH;
    self.labelView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
}


@end


#pragma mark - YCSelectionCell

@interface YCSelectionCell : UITableViewCell

@property (nonatomic, strong) UILabel *labelView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSDictionary *infoDictionary;

@end

@implementation YCSelectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //文字
        UILabel *labelView = [[UILabel alloc] init];
        [self.contentView addSubview:labelView];
        self.labelView = labelView;
        labelView.textAlignment = NSTextAlignmentCenter;
        labelView.font = [UIFont systemFontOfSize:kSelectionTextFontSize];
        [labelView setTextColor:[UIColor blackColor]];
        
        //下划线
        UIView *lineView=[[UIView alloc]init];
        self.lineView=lineView;
        lineView.backgroundColor = [UIColor colorWithHexString:@"0xd2d5d9"];
        [self.contentView addSubview:lineView];
        
        UIView *selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"0xf5f6f7"];
        self.selectedBackgroundView = selectedBackgroundView;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = self.bounds.size.width;
    CGFloat labelH = self.bounds.size.height;
    self.labelView.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    CGFloat lineX = 0;
    CGFloat lineW = self.bounds.size.width-lineX;
    CGFloat lineH = 0.5;
    CGFloat lineY = self.bounds.size.height-lineH;
    self.lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);

}

- (void)setInfoDictionary:(NSDictionary *)infoDictionary {
    _infoDictionary = infoDictionary;
   
    NSString *textColor = infoDictionary[kSelectionCellTextColorKey];
    if (textColor) {
        self.labelView.textColor = [UIColor colorWithHexString:textColor];
    }
   
    NSString *nameStr = infoDictionary[kSelectionCellNameKey];
    self.labelView.text = [nameStr description];
}


@end

#pragma mark - YCShareSelectionCell

@interface YCShareSelectionCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSMutableArray *infoArray;

@property (nonatomic, copy) void (^seletedBlock)(NSInteger selectedSection, NSInteger selectedRow, BOOL isDissmiss);

@end

@implementation YCShareSelectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kShareCellHeight - kLableHeight, kShareCellHeight);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[YCCollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
        [self.contentView addSubview:collectionView];
        self.collectionView = collectionView;
        
        //下划线
        UIView *lineView=[[UIView alloc] init];
        self.lineView=lineView;
        lineView.backgroundColor = [UIColor colorWithHexString:@"0xd2d5d9"];
        [self.contentView addSubview:lineView];
        
        UIView *selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"0xf5f6f7"];
        self.selectedBackgroundView = selectedBackgroundView;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = self.bounds.size.width;
    CGFloat labelH = self.bounds.size.height;
    self.collectionView.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    CGFloat lineX = 0;
    CGFloat lineW = self.bounds.size.width-lineX;
    CGFloat lineH = 0.5;
    CGFloat lineY = self.bounds.size.height-lineH;
    self.lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
}

- (void)setInfoArray:(NSMutableArray *)infoArray {
    _infoArray = infoArray;
    [self.collectionView reloadData];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _infoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    NSDictionary *dic = _infoArray[indexPath.row];
    cell.labelView.text = dic[kSelectionItemNameKey];
    if (dic[kSelectionItemTextColorKey]) {
        cell.labelView.textColor = [UIColor colorWithHexString:dic[kSelectionItemTextColorKey]];
    }
    cell.imageView.image = [UIImage imageNamed:dic[kSelectionItemImageNameKey]];
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YCCollectionViewCell *cell = (YCCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    YCShareSelectionCell * superCell = (YCShareSelectionCell *)cell.superview.superview.superview;
    NSIndexPath *index = [(UITableView *)superCell.superview.superview indexPathForCell:superCell];
    
    NSDictionary *dic = _infoArray[indexPath.row];
    BOOL *b = [(NSNumber *)dic[kShareViewShouldDismissKey] boolValue];
    self.seletedBlock(index.section, indexPath.row, b);
    
}



@end




#pragma mark - YCActionSheet

@interface YCActionSheet () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *selectionTableView;
@property (nonatomic, strong) UITableView *shareTableView;
@property (nonatomic, strong) YCSelectionItems *selectionItems;
@property (nonatomic, copy) void (^seletedBlock)(NSInteger selectedIndex);

@property (nonatomic, strong) YCShareItems *shareItems;
@property (nonatomic, copy) void (^seletedShareBlock)(NSInteger selectedIndexPathSection, NSInteger selectedIndexPathRow);

@end


@implementation YCActionSheet

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        self.frame = keyWindow.bounds;
        
        UIView *gesView = [[UIView alloc] initWithFrame:self.bounds];
        gesView.backgroundColor = [UIColor clearColor];
        [gesView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelf)]];
        [self addSubview:gesView];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [self addSubview:self.selectionTableView];
        [self addSubview:self.shareTableView];
    }
    return self;
}

#pragma mark  - Public Method

+ (void)showWithItemsBlock:(void (^)(id <YCActionSheetProtocol> item))itemsBlock selectedBlock:(void (^)(NSInteger))selectedBlock {
    
    YCActionSheet *actionSheet = [[YCActionSheet alloc] initWithFrame:CGRectZero];
    [actionSheet showWithItemsBlock:itemsBlock selectedBlock:selectedBlock];
    
}

- (void)showWithItemsBlock:(void (^)(id <YCActionSheetProtocol> item))itemsBlock selectedBlock:(void (^)(NSInteger))selectedBlock {
    
    self.seletedBlock = selectedBlock;
    itemsBlock(self.selectionItems);
    
    CGFloat tableViewHeight = (self.selectionItems.count + 1) * kSheetHeight;
    
    if (tableViewHeight <= kActionSheetMaxHeight) {
        self.selectionTableView.scrollEnabled = NO;
    } else {
        self.selectionTableView.scrollEnabled = YES;
    }
    
    tableViewHeight = tableViewHeight > kActionSheetMaxHeight ? kActionSheetMaxHeight : tableViewHeight;
    self.selectionTableView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, tableViewHeight);
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    self.hidden = NO;
    self.shareTableView.hidden = YES;
    self.selectionTableView.hidden = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect selectionTableViewFrame = self.selectionTableView.frame;
        selectionTableViewFrame.origin.y = [UIScreen mainScreen].bounds.size.height - tableViewHeight;
        self.selectionTableView.frame = selectionTableViewFrame;
    }];
    
}

+ (void)shareWithItemsBlock:(void (^)(id <YCShareViewProtocol> items))itemsBlock selectedBlock:(void (^)(NSInteger selectedSection, NSInteger selectedRow))selectedBlock {
    
    YCActionSheet *actionSheet = [[YCActionSheet alloc] initWithFrame:CGRectZero];
    [actionSheet shareWithItemsBlock:itemsBlock selectedBlock:selectedBlock];
    
}

- (void)shareWithItemsBlock:(void (^)(id <YCShareViewProtocol> item))itemsBlock selectedBlock:(void (^)(NSInteger selectedSection, NSInteger selectedRow))selectedBlock {
    
    self.seletedShareBlock = selectedBlock;
    itemsBlock(self.shareItems);
    
    CGFloat tableViewHeight = kShareCellHeight * 2 + kUniversalHeight + kSheetHeight;
    self.shareTableView.scrollEnabled = NO;
    self.shareTableView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, tableViewHeight);
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    self.hidden = NO;
    self.shareTableView.hidden = NO;
    self.selectionTableView.hidden = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect selectionTableViewFrame = self.shareTableView.frame;
        selectionTableViewFrame.origin.y = [UIScreen mainScreen].bounds.size.height - tableViewHeight;
        self.shareTableView.frame = selectionTableViewFrame;
    }];
    
}

#pragma mark - Actions

- (void)hideSelf {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        CGRect selectionTableViewFrame = self.selectionTableView.frame;
        selectionTableViewFrame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.selectionTableView.frame = selectionTableViewFrame;
        CGRect shareTableViewFrame = self.shareTableView.frame;
        shareTableViewFrame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.shareTableView.frame = shareTableViewFrame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
    
}

#pragma mark - Getter

- (YCSelectionItems *)selectionItems {
    if (!_selectionItems) {
        _selectionItems = [[YCSelectionItems alloc] init];
    }
    return _selectionItems;
}


- (UITableView *)selectionTableView {
    
    if (!_selectionTableView) {
        _selectionTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _selectionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _selectionTableView.dataSource = self;
        _selectionTableView.delegate = self;
    }
    return _selectionTableView;
    
}

- (YCShareItems *)shareItems {
    if (!_shareItems) {
        _shareItems = [[YCShareItems alloc] init];
    }
    return _shareItems;
}


- (UITableView *)shareTableView {
    
    if (!_shareTableView) {
        _shareTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _shareTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _shareTableView.dataSource = self;
        _shareTableView.delegate = self;
    }
    return _shareTableView;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([tableView isEqual:_selectionTableView]) {
        return 2;
    } else {
        return 3;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_selectionTableView]) {
        switch (section) {
            case 0:{
                return self.selectionItems.count;
                break;
            }
            case 1:{
                return 1;
                break;
            }
            default:
                return 1;
                break;
        }
    } else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *YCSelectionCellID = @"YCSelectionCell";
    static NSString *YCShareSelectionCellID = @"YCShareSelectionCell";
    UITableViewCell *aCell;
    if ([tableView isEqual:_selectionTableView]) {
        switch (indexPath.section) {
            case 0:{
                YCSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:YCSelectionCellID];
                if (cell == nil) {
                    cell = [[YCSelectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YCSelectionCellID];
                }
                
                if (self.selectionItems.count > indexPath.row) {
                    NSDictionary *infoDictionary = self.selectionItems.itemsArray[indexPath.row];
                    cell.infoDictionary = infoDictionary;
                }
                aCell = cell;
                break;
            }
                
            case 1:{
                YCSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:YCSelectionCellID];
                if (cell == nil) {
                    cell = [[YCSelectionCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YCSelectionCellID];
                    cell.labelView.text = @"取消";
                }
                aCell = cell;
            }
                
            default:
                break;
        }
        
        if (!aCell) {
            aCell = [[UITableViewCell alloc] init];
        }

    } else {
        switch (indexPath.section) {
            case 0:{
                YCShareSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:YCShareSelectionCellID];
                if (cell == nil) {
                    cell = [[YCShareSelectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YCShareSelectionCellID];
                }
                
                cell.infoArray = self.shareItems.shareItemsArray;
                cell.seletedBlock = ^(NSInteger selectedSection, NSInteger selectedRow, BOOL isDissmiss) {
                    self.seletedShareBlock(selectedSection, selectedRow);
                    if (isDissmiss) {
                        [self hideSelf];
                    }
                };
                
                aCell = cell;
                break;
            }
                
            case 1:{
                YCShareSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:YCShareSelectionCellID];
                if (cell == nil) {
                    cell = [[YCShareSelectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YCShareSelectionCellID];
                }
                cell.seletedBlock = ^(NSInteger selectedSection, NSInteger selectedRow, BOOL isDissmiss) {
                    self.seletedShareBlock(selectedSection, selectedRow);
                    if (isDissmiss) {
                        [self hideSelf];
                    }
                };
                cell.infoArray = self.shareItems.shareOthersArray;
                
                aCell = cell;
                break;
            }
                
            case 2:{
                YCSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:YCSelectionCellID];
                if (cell == nil) {
                    cell = [[YCSelectionCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YCSelectionCellID];
                    cell.labelView.text = @"取消";
                }
                aCell = cell;
            }
                
            default:
                break;
        }
        
        if (!aCell) {
            aCell = [[UITableViewCell alloc] init];
        }

    }
    
    
    return aCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_selectionTableView]) {
        return kSheetHeight;
    } else {
        if (indexPath.section == 2) {
            return kSheetHeight;
        } else {
            return kShareCellHeight;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([tableView isEqual:_selectionTableView]) {
        if (section == 1) {
            return 5;
        } else {
            return 0;
        }
    } else {
        if (section == 0) {
            return kUniversalHeight;
        } else if (section == 2) {
            return 5;
        } else {
            return 0;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([tableView isEqual:_shareTableView]) {
        if (section == 0) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kUniversalHeight)];
            lable.text = @"   分享到";
            return lable;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.selectionTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section == 0) {
            self.seletedBlock(indexPath.row);
            if (self.selectionItems.itemsArray.count > indexPath.row) {
                BOOL shouldDismiss = [[self.selectionItems.itemsArray[indexPath.row] objectForKey:kSelectionViewShouldDismissKey] boolValue];
                if (shouldDismiss) {
                    [self hideSelf];
                }
            }
        } else {
            [self hideSelf];
        }
        
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section == 2) {
            [self hideSelf];
            
        }
    }
}




@end
