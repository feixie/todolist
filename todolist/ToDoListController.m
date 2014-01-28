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
    
    // Initialize to do items list with persisted data
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *savedArray = [currentDefaults objectForKey:@"mySavedToDoList"];
    if (savedArray != nil)
    {
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
        if (oldArray != nil) {
            self.toDoItems = [[NSMutableArray alloc] initWithArray:oldArray];
        } else {
            self.toDoItems = [[NSMutableArray alloc] init];
        }
    }
    //self.toDoItems = [[NSMutableArray alloc] init];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.toDoItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    CGFloat width = 310;
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    NSDictionary *options = @{ NSFontAttributeName: font };
    NSString *myString = [self.toDoItems objectAtIndex:indexPath.row];

    CGRect boundingRect = [myString boundingRectWithSize:CGSizeMake(width, NSIntegerMax)
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   attributes:options context:nil];
    
    NSLog(@"height for row %d is %f", indexPath.row, boundingRect.size.height + 25);

    return boundingRect.size.height + 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    cell.toDoTextView.text=[self.toDoItems objectAtIndex:indexPath.row];
    
    // Set controller to text view delegate
    cell.toDoTextView.delegate = self;
    
    // Set index on text view so controller can update the corresponding value in array
    cell.toDoTextView.index = indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"deleting from table");
        [self.toDoItems removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    NSString *stringToMove = [self.toDoItems objectAtIndex:sourceIndexPath.row];
    [self.toDoItems removeObjectAtIndex:sourceIndexPath.row];
    [self.toDoItems insertObject:stringToMove atIndex:destinationIndexPath.row];
    [self.tableView reloadData];

}


- (void)didTapTable
{
    [[self tableView] endEditing:YES];
}

#pragma mark UITextViewDelegate Protocol Methods
- (void)textViewDidEndEditing:(IndexTextView *)textView {
    NSLog(@"edited at %d", textView.index);
    NSLog(@"%@",textView.text);
    [self.view endEditing:YES];
    [self.toDoItems removeObjectAtIndex:textView.index];
    [self.toDoItems insertObject:textView.text atIndex:textView.index];
    
    // Persist data
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.toDoItems] forKey:@"mySavedToDoList"];
    [[NSUserDefaults standardUserDefaults]synchronize ];

    [self.tableView reloadData];
}

#pragma mark - Private methods
- (void)onAddButton {
    NSLog(@"inserted at %d", 0);
    [self.toDoItems addObject:@"Edit me"];
    [self.tableView reloadData];
                              
}

- (void)onEditButton {
    //[super setEditing:YES animated:YES];
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(onDoneButton)];
}

-(void)onDoneButton {
    //[super setEditing:NO animated:YES];
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(onEditButton)];
}


@end
