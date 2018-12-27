//
//  MTContactsViewController.m
//  BusinessCard
//
//  Created by mt y on 2018/7/3.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTContactsViewController.h"
#import "ContactsTableView.h"
#import <QuartzCore/QuartzCore.h>
#import "MTAddPutModeTool.h"
#import "MTPersonMood.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "ContactCell.h"
#import "PinYinForObjc.h"
#import "MTDetailsViewController.h"
#import <Masonry.h>
@interface MTContactsViewController ()<ContactsTableViewDelegate>

@property (nonatomic, strong) ContactsTableView *contactTableView;
@property (nonatomic, strong) NSMutableArray *contactArraytemp; //从数据库读取的contacts数据
@property (nonatomic, strong) NSMutableArray *allArray;  // 包含空数据的contactsArray
@property (nonatomic, strong) NSMutableArray *dataSource;  // 核心数据
@property (nonatomic, strong) NSMutableArray *indexTitles;

@end

@implementation MTContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Contacts";
    
    self.dataSource = [[NSMutableArray alloc] init];
    self.contactArraytemp = [[NSMutableArray alloc] init];
    self.allArray = [[NSMutableArray alloc] init];
    contactsSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, ZHScreenW, 40)];
    contactsSearchBar.delegate = self;
    [contactsSearchBar setPlaceholder:@"search for"];
    contactsSearchBar.keyboardType = UIKeyboardTypeDefault;
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:contactsSearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    [self performSelector:@selector(loadLocalData)];
    
    [self createTableView];
}
#pragma mark-loadData
- (void)loadLocalData
{
    

    self.contactArraytemp = [[NSMutableArray alloc] init];
    NSMutableArray *myArrJob = [MTAddPutModeTool getAllCardMode:@"Job"];
    NSMutableArray *myArrColleague = [MTAddPutModeTool getAllCardMode:@"Colleague"];
    NSMutableArray *myArrClassmates = [MTAddPutModeTool getAllCardMode:@"Classmates"];
    NSMutableArray *myArrOthers = [MTAddPutModeTool getAllCardMode:@"Others"];
    [self.contactArraytemp addObjectsFromArray:myArrJob];
    [self.contactArraytemp addObjectsFromArray:myArrColleague];
    [self.contactArraytemp addObjectsFromArray:myArrClassmates];
    [self.contactArraytemp addObjectsFromArray:myArrOthers];

    // 对数据进行排序，并按首字母分类
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    for (MTPersonMood *contact in self.contactArraytemp) {
        NSInteger sect = [theCollation sectionForObject:contact
                                collationStringSelector:@selector(personName)];
        contact.sectionNumber = sect;
        
    }
    
    NSInteger highSection = [[theCollation sectionTitles] count];
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (int i=0; i<=highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    
    for (MTPersonMood *contact in self.contactArraytemp) {
        [(NSMutableArray *)[sectionArrays objectAtIndex:contact.sectionNumber] addObject:contact];
    }
    
    self.allArray = [[NSMutableArray alloc] init];
    for (NSMutableArray *sectionArray in sectionArrays) {
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(personName)];
        [self.allArray addObject:sortedSection];
    }
    
    // 只取有数据的Array
    for (NSMutableArray *sectionArray0 in self.allArray) {
        if (sectionArray0.count) {
            [self.dataSource addObject:sectionArray0];
        }
        
    }
    
}
#pragma mark -SetUi
- (void) createTableView {
    self.contactTableView = [[ContactsTableView alloc] initWithFrame:CGRectMake(0, 0, ZHScreenW, ZHScreenH)];
    self.contactTableView.tableView.rowHeight = 65;
    self.contactTableView.delegate = self;
    self.contactTableView.tableView.tableHeaderView = contactsSearchBar;
    [self.view addSubview:self.contactTableView];
}
- (void) reloadTableView {
    self.contactTableView = [[ContactsTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    self.contactTableView.delegate = self;
    self.contactTableView.tableView.tableHeaderView = contactsSearchBar;
    [self.view addSubview:self.contactTableView];
}
//#pragma mark - UITableViewDataSource
// IndexTable
- (NSArray *) sectionIndexTitlesForABELTableView:(ContactsTableView *)tableView
{
    if (tableView == searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    else{
        self.indexTitles = [NSMutableArray array];
        
        for (int i = 0; i < self.allArray.count; i++) {
            if ([[self.allArray objectAtIndex:i] count]) {
                [self.indexTitles addObject:[[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:i]];
            }
        }
        
        return self.indexTitles;
        
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    else{
        
        return [self.indexTitles objectAtIndex:section];
    }
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == searchDisplayController.searchResultsTableView)
    {
        return 1;
    }
    else{
        return self.dataSource.count;
        
    }
    
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView)  // 有搜索
    {
        return searchResults.count;
    }
    else{
        return [[self.dataSource objectAtIndex:section] count];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ContactCell";
    ContactCell *cell = (ContactCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactCell" owner:self options:nil] lastObject];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        // 搜索结果显示
        MTPersonMood *contact = searchResults[indexPath.row];
        
        NSString *nametext = [NSString stringWithFormat:@"%@",contact.personName];
        
        cell.tag = indexPath.row;
        cell.delegate = self;
        
        cell.nameLabel.text = nametext;
        cell.myHeadImage.image = contact.headImge;
        cell.numbereLable.text = contact.type;
    }
    else {
        
        MTPersonMood *contact = (MTPersonMood *)[[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSString *nametext = [NSString stringWithFormat:@"%@",contact.personName];
        
        cell.tag = indexPath.row;
        cell.delegate = self;
        cell.nameLabel.text = nametext;
        cell.myHeadImage.image = contact.headImge;
        cell.numbereLable.text = contact.type;
    }
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// 选中某个cell，进入 detailcontact 联系人详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MTDetailsViewController *contactdetail = [[MTDetailsViewController alloc] init];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        contactdetail.perMode = searchResults[indexPath.row];
    }
    else {

        contactdetail.perMode = (MTPersonMood *)[[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    }
    
    [self.navigationController pushViewController:contactdetail animated:YES];
}
// 联系人搜索，可实现汉字搜索，汉语拼音搜索和拼音首字母搜索，
// 输入联系人名称，进行搜索， 返回搜索结果searchResults
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchResults = [[NSMutableArray alloc]init];
    if (contactsSearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:contactsSearchBar.text]) {
        for (NSArray *section in self.dataSource) {
            for (MTPersonMood *contact in section)
            {
                
                if ([ChineseInclude isIncludeChineseInString:contact.personName]) {
                    NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:contact.personName];
                    NSRange titleResult=[tempPinYinStr rangeOfString:contactsSearchBar.text options:NSCaseInsensitiveSearch];
                    
                    if (titleResult.length>0) {
                        [searchResults addObject:contact];
                    }
                    else {
                        NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:contact.personName];
                        NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:contactsSearchBar.text options:NSCaseInsensitiveSearch];
                        if (titleHeadResult.length>0) {
                            [searchResults  addObject:contact];
                        }
                    }
                    NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:contact.personName];
                    NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:contactsSearchBar.text options:NSCaseInsensitiveSearch];
                    if (titleHeadResult.length>0) {
                        [searchResults  addObject:contact];
                    }
                }
                else {
                    NSRange titleResult=[contact.personName rangeOfString:contactsSearchBar.text options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0) {
                        [searchResults  addObject:contact];
                    }
                }
            }
        }
    } else if (contactsSearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:contactsSearchBar.text]) {
        
        for (NSArray *section in self.dataSource) {
            for (MTPersonMood *contact in section)
            {
                NSString *tempStr = contact.personName;
                NSRange titleResult=[tempStr rangeOfString:contactsSearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:contact];
                }
                
            }
        }
    }
    
}
// searchbar 点击上浮，完毕复原
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //准备搜索前，把上面调整的TableView调整回全屏幕的状态
    [UIView animateWithDuration:1.0 animations:^{
        self.contactTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
    }];
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    //搜索结束后，恢复原状
    [UIView animateWithDuration:1.0 animations:^{
        self.contactTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }];
    return YES;
}
@end
