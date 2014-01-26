//
//  ToDoListController.m
//  todolist
//
//  Created by fxie on 1/24/14.
//  Copyright (c) 2014 fxie. All rights reserved.
//

#import "ToDoListController.h"
#import "ToDoCell.h"
#import "IndexTextView.h"

@interface ToDoListController ()


@property (nonatomic, strong) NSMutableArray *toDoItems;
@property (nonatomic, weak) ToDoCell *editCell;


@end

@implementation ToDoListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTable)];
    [[self tableView] addGestureRecognizer:tapRecognizer];
    
    self.toDoItems = [[NSMutableArray alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(onAddButton)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(onEditButton)];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.toDoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"getting row for %d", indexPath.row);
    ToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    cell.toDoTextView.text=[self.toDoItems objectAtIndex:indexPath.row];
    
    // Set controller to text view delegate
    cell.toDoTextView.delegate = self;
    
    // Set index on text view so controller can update the corresponding value in array
    cell.toDoTextView.index = indexPath.row;
    
    /*if(indexPath.row == self.toDoItems.count) {
        [cell.toDoTextView setEditable:YES];
        self.editCell = cell;
    }
    else {
        cell.toDoTextView.text=[self.toDoItems objectAtIndex:indexPath.row];;
        [cell.toDoTextView setEditable:NO];
    }*/
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark UITextViewDelegate Protocol Methods
- (void)textViewDidEndEditing:(IndexTextView *)textView {
    NSLog(@"edited at %d", textView.index);
    NSLog(@"%@",textView.text);
    [self.view endEditing:YES];
    [self.toDoItems removeObjectAtIndex:textView.index];
    [self.toDoItems insertObject:textView.text atIndex:textView.index];
    [self.tableView reloadData];
}

#pragma mark - Private methods
- (void)onAddButton {
    NSLog(@"inserted at %d", 0);
    [self.toDoItems addObject:@"Edit me"];
    //[self.toDoItems insertObject:@"Edit me" atIndex:0];
    [self.tableView reloadData];
                              
}

- (void)onEditButton {
    
}

- (void)didTapTable
{
    [[self tableView] endEditing:YES];
}

@end
