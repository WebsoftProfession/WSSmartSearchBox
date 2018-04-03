//
//  WSSearchView.h
//  WSSmartSearchBox
//
//  Created by WebsoftProfession on 3/1/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSSearchView.h"

@protocol WSSearchViewDelegate <NSObject>
-(void)reloadSearchResultArray:(NSArray *)result forTextField:(UITextField *)textField;
-(NSString *)titleForResultForIndex:(NSInteger)index forTextField:(UITextField *)textField;
-(void)didSelectResultForIndex:(NSInteger)index forTextField:(UITextField *)textField;
-(NSArray *)resultArrayForSearchViewForTextField:(UITextField *)textField;
-(NSInteger)numberOfResultInSearchViewForTextField:(UITextField *)textField;

@end

@interface WSSearchView : UIView
{
    BOOL isSearching;
    NSArray *resultArray;
    NSArray *filterArray;
    UITextField *activeTextField;
}

@property (nonatomic,strong) UIView *parentView;
-(void)setupAppearance;


@property (nonatomic,strong) NSString *activeFilterKey;
@property (nonatomic,strong) NSPredicate *searchPredicateQuery;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (nonatomic,strong) id<WSSearchViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *WSTableView;

-(void)ActiveSearchOnView:(UIView *)view;
-(void)deActiveSearchView;
- (IBAction)closeAction:(id)sender;

@end
