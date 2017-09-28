//
//  AddViewController.h
//  Receipts++
//
//  Created by Jaison Bhatti on 2017-09-28.
//  Copyright © 2017 Jaison Bhatti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
#import "Receipt+CoreDataClass.h"

@interface AddViewController : UIViewController

@property (nonatomic,weak) AppDelegate *delegate;
@property (nonatomic) NSManagedObjectContext *context;

@end
