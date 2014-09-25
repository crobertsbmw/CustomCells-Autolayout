#import "DipticView.h"
#import "DipticCell.h"

@implementation DipticView{
    NSMutableDictionary *offScreenCells;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return [self init];
}
/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = @"dipticCell";
    if (indexPath.row > 0){
        reuseIdentifier = @"cell2";
    }
 
    UITableViewCell *cell = [offScreenCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell = [self dequeueReusableCellWithIdentifier:reuseIdentifier];
        [offScreenCells setObject:cell forKey:reuseIdentifier];
    }
    
    // Configure the cell with content for the given indexPath, for example:
     cell.textLabel.text = @"one";
    // ...
    
    // Make sure the constraints have been set up for this cell, since it may have just been created from scratch.
    // Use the following lines, assuming you are setting up constraints from within the cell's updateConstraints method:
  
    
    // Set the width of the cell to match the width of the table view. This is important so that we'll get the
    // correct cell height for different table view widths if the cell's height depends on its width (due to
    // multi-line UILabels word wrapping, etc). We don't need to do this above in -[tableView:cellForRowAtIndexPath]
    // because it happens automatically when the cell is used in the table view.
    // Also note, the final width of the cell may not be the width of the table view in some cases, for example when a
    // section index is displayed along the right side of the table view. You must account for the reduced cell width.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints.
    // (Note that you must set the preferredMaxLayoutWidth on multi-line UILabels inside the -[layoutSubviews] method
    // of the UITableViewCell subclass, or do it manually at this point before the below 2 lines!)
    
    // Get the actual height required for the cell's contentView
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1.0f;
    
    return height;
}
*/
-(id)init{
    //Implementation details go BELOW
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:@"DipticCell" bundle:nil] forCellReuseIdentifier:@"dipticCell"];
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    self.rowHeight = UITableViewAutomaticDimension;
    offScreenCells = [[NSMutableDictionary alloc] init];
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        DipticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dipticCell"];
        if (cell == nil) {
            cell = [[DipticCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"dipticCell"];
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];
        }
        cell.textLabel.text = @"one";
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        return cell;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
