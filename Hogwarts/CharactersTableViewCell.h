//
//  CharactersTableViewCell.h
//  Hogwarts
//
//  Created by Jian Yao Ang on 4/4/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharactersTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *houseLabel;
@property (strong, nonatomic) IBOutlet UILabel *spellsLabel;

@end
