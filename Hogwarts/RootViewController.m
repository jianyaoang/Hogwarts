//
//  RootViewController.m
//  Hogwarts
//
//  Created by Jian Yao Ang on 4/4/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "RootViewController.h"
#import "Characters.h"
#import "CharactersTableViewCell.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSMutableArray *characters;
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *houseTextField;
    IBOutlet UITextField *spellsTextField;
    IBOutlet UITableView *charactersTableView;
    IBOutlet UISearchBar *searchBarForName;
}

@end

@implementation RootViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self load];
    searchBarForName.delegate = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return characters.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Characters *wizardsAndWitches = characters[indexPath.row];
    CharactersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myReuseIdentifier"];
    cell.backgroundColor = [UIColor darkGrayColor];
    cell.nameLabel.text = wizardsAndWitches.name;
    
    cell.houseLabel.text = wizardsAndWitches.house;
    
    if ([cell.houseLabel.text isEqualToString:@"Gryffindor"] || [cell.houseLabel.text isEqualToString:@"gryffindor"])
    {
        cell.houseLabel.textColor = [UIColor redColor];
    }
    else if ([cell.houseLabel.text isEqualToString:@"Slytherin"] || [cell.houseLabel.text isEqualToString:@"slytherin"])
    {
        cell.houseLabel.textColor = [UIColor greenColor];
    }
    else if ([cell.houseLabel.text isEqualToString:@"Ranvenclaw"] || [cell.houseLabel.text isEqualToString:@"ravenclaw"])
    {
        cell.houseLabel.textColor = [UIColor blueColor];
    }
    else if ([cell.houseLabel.text isEqualToString:@"Hufflepuff"] || [cell.houseLabel.text isEqualToString:@"hufflepuff"])
    {
        cell.houseLabel.textColor = [UIColor yellowColor];
    }
    
    cell.spellsLabel.text = wizardsAndWitches.spells;
    return cell;
}

- (IBAction)onAddButtonPressed:(id)sender
{
    Characters *wizardsAndWitches = [NSEntityDescription insertNewObjectForEntityForName:@"Characters" inManagedObjectContext:self.managedObjectContext];
    
    wizardsAndWitches.name = nameTextField.text;
    wizardsAndWitches.spells = spellsTextField.text;
    wizardsAndWitches.house = houseTextField.text;
    
    [nameTextField resignFirstResponder];
    [spellsTextField resignFirstResponder];
    [houseTextField resignFirstResponder];
    
    nameTextField.text = @"";
    spellsTextField.text = @"";
    houseTextField.text = @"";
    
    [self.managedObjectContext save:nil];
    [self load];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self filterName:searchBar.text];
    [searchBar resignFirstResponder];
}


-(void)filterName:(NSString*)name
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Characters"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@",name];
    
    NSSortDescriptor *sortDescriptorName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSSortDescriptor *sortDescriptorHouse = [[NSSortDescriptor alloc] initWithKey:@"house" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects: sortDescriptorName, sortDescriptorHouse, nil];
    
    request.sortDescriptors = sortDescriptors;
    
    NSArray *nameAndHouse = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    if (nameAndHouse.count)
    {
        characters = [NSMutableArray arrayWithArray:nameAndHouse];
    }
    [charactersTableView reloadData];
}

-(void)load
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Characters"];
    
    NSSortDescriptor *sortDescriptorName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSSortDescriptor *sortDescriptorHouse = [[NSSortDescriptor alloc] initWithKey:@"house" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptorName, sortDescriptorHouse, nil];
    
    request.sortDescriptors = sortDescriptors;
    
    NSArray *nameAndHouse = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    if (nameAndHouse.count)
    {
        characters = [NSMutableArray arrayWithArray:nameAndHouse];
    }
    [charactersTableView reloadData];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.managedObjectContext deleteObject:characters[indexPath.row]];
        [self.managedObjectContext save:nil];
        [self load];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"AVADA KEDAVRA!";
}




@end
