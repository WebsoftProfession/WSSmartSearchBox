//
//  ViewController.h
//  WSSmartSearchBox
//
//  Created by WebsoftProfession on 3/1/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSSearchView.h"

@interface ViewController : UIViewController<WSSearchViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtState;


@end

