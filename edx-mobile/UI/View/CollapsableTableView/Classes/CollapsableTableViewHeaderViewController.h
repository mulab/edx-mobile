//
//  CollapsableTableViewHeaderViewController.h
//  CollapsableTableView
//
//  Created by Bernhard Häussermann on 2011/04/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "TapDelegate.h"
#import "CollapsableTableViewTapRecognizer.h"
#import "CollapsableTableView.h"


@interface CollapsableTableViewHeaderViewController : UIViewController 
{
    IBOutlet UILabel *collapsedIndicatorLabel,*__unsafe_unretained titleLabel,*__unsafe_unretained detailLabel;

    CollapsableTableViewTapRecognizer* tapRecognizer;

    BOOL viewWasSet;
    id<TapDelegate> __unsafe_unretained tapDelegate;

    NSString* fullTitle;
    BOOL isCollapsed;
}

@property (nonatomic, strong) NSString* fullTitle;
@property (unsafe_unretained, nonatomic, readonly) UILabel* titleLabel;
@property (nonatomic, strong) NSString* titleText;
@property (unsafe_unretained, nonatomic, readonly) UILabel* detailLabel;
@property (nonatomic, strong) NSString* detailText;
@property (nonatomic, unsafe_unretained) id<TapDelegate> tapDelegate;
@property (nonatomic, assign) BOOL isCollapsed;

@end