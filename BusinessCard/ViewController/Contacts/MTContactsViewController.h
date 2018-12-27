//
//  MTContactsViewController.h
//  BusinessCard
//
//  Created by mt y on 2018/7/3.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactCell.h"
@interface MTContactsViewController : UIViewController<ContactCellDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    
    NSMutableArray *searchResults;
    UISearchBar *contactsSearchBar;
    UISearchDisplayController *searchDisplayController;
    
}

@end
