//
//  WSSearchView.m
//  WSSmartSearchBox
//
//  Created by WebsoftProfession on 3/1/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import "WSSearchView.h"

@implementation WSSearchView
@synthesize activeFilterKey;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

-(void)setupAppearance{
    self.hidden=YES;
    self.clipsToBounds=YES;
    self.layer.cornerRadius=5.0;
    self.layer.borderColor=[UIColor grayColor].CGColor;
    self.layer.borderWidth=1.0;
}

#pragma mark TableView Delegate & DataSource Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.delegate numberOfResultInSearchViewForTextField:activeTextField];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"resultCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.textColor=[UIColor colorWithRed:85/255 green:22/255 blue:5/255 alpha:1.0];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.text=[self.delegate titleForResultForIndex:indexPath.row forTextField:activeTextField];
    
    UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
    myBackView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = myBackView;
    myBackView = nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectResultForIndex:indexPath.row forTextField:activeTextField];
    UIButton *btn;
    [self closeAction:btn];
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(void)ActiveSearchOnView:(UIView *)view{
    self.txtSearch.text=@"";
    activeTextField=(UITextField *)view;
    [self addLayerToPopup];
    [self.WSTableView reloadData];
    filterArray=[self.delegate resultArrayForSearchViewForTextField:activeTextField];
    [self showSearchBoxInView:view];
}

-(void)deActiveSearchView{
    [self.delegate reloadSearchResultArray:filterArray forTextField:activeTextField];
    [self rempveLayerFromPopup];
    UIView *view;
    [self hideSearchBoxInView:view];
}

- (IBAction)closeAction:(id)sender {
    [self endEditing:YES];
    [self deActiveSearchView];
}

-(void)showSearchBoxInView:(UIView *)view{
    
    self.hidden=YES;
    CGRect mainScreenFrame = [UIScreen mainScreen].bounds;
    self.frame=CGRectMake(20,40, (mainScreenFrame.size.width-40), (mainScreenFrame.size.height-40));
    self.hidden=NO;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.frame=CGRectMake(20,80, (mainScreenFrame.size.width-40), (mainScreenFrame.size.height-160));
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)hideSearchBoxInView:(UIView *)view{
    
    self.hidden=YES;
    [UIView animateWithDuration:0.3 animations:^{
    } completion:^(BOOL finished) {
    }];
}

-(void)collapseView{
    
    CGRect mainScreenFrame = [UIScreen mainScreen].bounds;
    CGRect initialFrame=CGRectMake(20,80, (mainScreenFrame.size.width-40), (mainScreenFrame.size.height-360));
    
    [UIView animateWithDuration:0.1 animations:^{
        self.frame=initialFrame;
    } completion:^(BOOL finished) {
    }];
}

-(void)expandView{
    CGRect mainScreenFrame = [UIScreen mainScreen].bounds;
    CGRect initialFrame=CGRectMake(20,80, (mainScreenFrame.size.width-40), (mainScreenFrame.size.height-160));
    
    [UIView animateWithDuration:0.1 animations:^{
        self.frame=initialFrame;
    } completion:^(BOOL finished) {
    }];
}

-(void)addLayerToPopup
{
    UIView *layerView=[[UIView alloc] initWithFrame:self.superview.frame];
    layerView.tag=2000;
    layerView.backgroundColor=[UIColor blackColor];
    layerView.alpha=0.6;
    UITapGestureRecognizer *tapG =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [layerView addGestureRecognizer:tapG];
    [self.superview addSubview:layerView];
    [self.superview bringSubviewToFront:self];
}

-(void)rempveLayerFromPopup
{
    UIView *layerView=[self.superview viewWithTag:2000];
    [layerView removeFromSuperview];
    layerView=nil;
}

//The event handling method
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self endEditing:YES];
}

#pragma mark UITextView Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self collapseView];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([[textField.text stringByReplacingCharactersInRange:range withString:string] isEqualToString:@""]|| [[textField.text stringByReplacingCharactersInRange:range withString:string] isEqualToString:@"\n"]) {
        resultArray = [filterArray mutableCopy];
        [self.delegate reloadSearchResultArray:resultArray forTextField:activeTextField];
    }else{
        [self searchTextFromArray:filterArray witSearchString:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    }
    
    [self.WSTableView reloadData];
    return YES;
}

-(NSArray *)searchTextFromArray:(NSArray*)array witSearchString:(NSString*)searchString{
    NSPredicate *predicate1=[NSPredicate predicateWithFormat:activeFilterKey,searchString];
    resultArray = [array filteredArrayUsingPredicate:predicate1];
    [self.delegate reloadSearchResultArray:resultArray forTextField:activeTextField];
    return resultArray;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    [self expandView];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    resultArray = [filterArray mutableCopy];
    [self.WSTableView reloadData];
    return YES;
}




@end
