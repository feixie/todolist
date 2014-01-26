//
//  ToDoCell.h
//  todolist
//
//  Created by fxie on 1/24/14.
//  Copyright (c) 2014 fxie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexTextView.h"

@interface ToDoCell : UITableViewCell

@property (nonatomic, weak) IBOutlet IndexTextView * toDoTextView;

@end
