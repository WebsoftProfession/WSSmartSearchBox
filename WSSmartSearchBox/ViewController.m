//
//  ViewController.m
//  WSSmartSearchBox
//
//  Created by Dotsquares on 3/1/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *countryArray;
    NSArray *stateArray;
    NSArray *filterArray;
    WSSearchView *searchView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    countryArray=@[@"India",@"Austria",@"France",@"China"];
    stateArray=[[NSArray alloc] initWithObjects:@{@"state":@"Andhra Pradesh"},@{@"state":@"Arunachal Pradesh"},@{@"state":@"Assam"},@{@"state":@"Bihar"}, nil];
    //filterArray = [[NSArray alloc] initWithArray:resultArray];
    searchView = [[[NSBundle mainBundle] loadNibNamed:@"WSSearchView" owner:self options:nil] firstObject];
    searchView.delegate=self;
    [searchView setupAppearance];
    [self.view addSubview:searchView];
    
}


#pragma mark WSSrachView Delegate

-(void)reloadSearchResultArray:(NSArray *)result forTextField:(UITextField *)textField{
    
    if (textField==self.txtCountry) {
        countryArray=[result mutableCopy];
    }
    else if (textField==self.txtState)
    {
        stateArray=[result mutableCopy];
    }
}

-(NSArray *)resultArrayForSearchViewForTextField:(UITextField *)textField {
    if (textField==self.txtCountry) {
        return countryArray;
    }
    else if (textField==self.txtState)
    {
        return stateArray;
    }
    
    return @[];
}

-(NSInteger)numberOfResultInSearchViewForTextField:(UITextField *)textField {
    if (textField==self.txtCountry) {
        return countryArray.count;
    }
    else if (textField==self.txtState)
    {
        return stateArray.count;
    }
    return 0;
}

-(NSString *)titleForResultForIndex:(NSInteger)index forTextField:(UITextField *)textField {
    if (textField==self.txtCountry) {
        return [countryArray objectAtIndex:index];
    }
    else if (textField==self.txtState)
    {
        return [[stateArray objectAtIndex:index] valueForKey:@"state"];
    }
    return @"";
}

-(void)didSelectResultForIndex:(NSInteger)index forTextField:(UITextField *)textField{
    if (textField==self.txtCountry) {
        self.txtCountry.text=[countryArray objectAtIndex:index];
    }
    else if (textField==self.txtState)
    {
        self.txtState.text=[[stateArray objectAtIndex:index] valueForKey:@"state"];
    }
}


#pragma mark UITextView Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.txtCountry) {
        searchView.activeFilterKey=@"SELF contains[cd] %@";
        [searchView ActiveSearchOnView:textField];
        return NO;
    }
    else if(textField==self.txtState)
    {
        searchView.activeFilterKey=@"state contains[cd] %@";
        [searchView ActiveSearchOnView:textField];
        return NO;
    }
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
