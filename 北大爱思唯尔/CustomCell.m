//
//  CustomCell.m
//  北大爱思唯尔
//
//  Created by me2 on 14-8-25.
//  Copyright (c) 2014年 www.healthedu.cn 北大爱思唯尔教育. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    
    }
    return self;
}


-(void)configUI:(FacetofaceModel *)model{
   // NSDictionary *views = NSDictionaryOfVariableBindings(self.contentView,_nameLabel,_nameLabel2,_nameLabel3);
    self.nameLabel.text = model.name;
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    //NSDictionary *metrics = @{@"hPadding":@5,@"vPadding":@5,@"imageEdge":@150.0};
    
    self.nameLabel2.text = [NSString stringWithFormat:@"举办单位:%@",model.dept_name];
    self.nameLabel2.font = [UIFont systemFontOfSize:13];
    self.nameLabel3.text = [NSString stringWithFormat:@"项目编号:%@",model.term_number];
    self.nameLabel3.font = [UIFont systemFontOfSize:13];
    _nameLabel.numberOfLines = 0;
    _nameLabel2.numberOfLines = 0;
    _nameLabel3.numberOfLines = 0;
    
   
    

    
    //self.numberName.text = model.new_term_number;
//    self.introduceLabel.text = model.questiones;
//    self.introduceLabel.font = [UIFont systemFontOfSize:10];
//    self.introduceLabel.numberOfLines = 0;
   
    
    
    
    
}
-(void)configRemote:(RemoteModel *)model{
    
    
    
    self.nameLabel.text = model.fullname;
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    //self.nameLabel.font = [UIFont systemFontOfSize:10];
    //self.nameLabel2.hidden = YES;
    self.nameLabel2.text = [NSString stringWithFormat:@"作者:%@",model.speaker];
    self.nameLabel2.font = [UIFont systemFontOfSize:13];
    self.nameLabel3.text = [NSString stringWithFormat:@"医院:%@",model.speakerorg];
    self.nameLabel3.font = [UIFont systemFontOfSize:13];
    _nameLabel.numberOfLines = 0;
    _nameLabel2.numberOfLines = 0;
    _nameLabel3.numberOfLines = 0;

    if ([model.price integerValue]>0){
        
        self.priceImageView.image = [UIImage imageNamed:@"付费.png"];
        
        
    }else{
        
        self.priceImageView.image = [UIImage imageNamed:@"免费.png"];
        
    }
    
    
}






- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
