//
//  ScoreView.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/21/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "ScoreView.h"
#import "ScoreTableViewCell.h"

@interface ScoreView() {
    UITableView *scoreTable;
    int tot1;
    int tot2;
    NSString *tn1;
    NSString *tn2;
    SFSArray *scoreArray;
    Translate *cutrrentLunguage;
    UILabel *scoreLabel;
}

@end

@implementation ScoreView

- (id)init
{
    CGRect frame = CGRectMake(0, 0, 1024, 768);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.hidden = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];

        UIView *borderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
        borderView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:5.55f];
        borderView.center = self.center;
        [self addSubview:borderView];
        
        
        UIView *scoreView = [[UIView alloc] initWithFrame:CGRectMake(10, 8, 380, 384)];
        //scoreView.center = self.center;
        [borderView addSubview:scoreView];
        scoreView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.85];
      //  scoreView.layer.cornerRadius = 5;
       // scoreView.layer.borderWidth = 8;
      //  scoreView.layer.borderColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:5.55f].CGColor;
     
        UIView *headerViwa = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 40)];
        headerViwa.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:184.0f/255.0f blue:31.0f/255.0f alpha:1.0f];
        [scoreView addSubview:headerViwa];
        
        scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 250, 25)];
        scoreLabel.font = [UIFont boldSystemFontOfSize:24];
        [headerViwa addSubview:scoreLabel];
        scoreLabel.textColor = [UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = CGRectMake(headerViwa.frame.size.width - 20 - 10, 10, 20, 20);
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"closeScoreButton.png"] forState:UIControlStateNormal];
        cancelButton.tag = 0;
        [headerViwa addSubview:cancelButton];
        
        scoreTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 41, scoreView.frame.size.width, scoreView.frame.size.height - 50)];
        scoreTable.dataSource = self;
        scoreTable.delegate = self;
        [scoreView addSubview:scoreTable];
        [scoreTable setBackgroundView:nil];
        [scoreTable setBackgroundColor:[UIColor clearColor]];
        [scoreTable setOpaque:NO];
        scoreTable.separatorColor = [UIColor colorWithRed:96.0f/255.0f green:27.0f/255.0f blue:14.0f/255.0f alpha:1.0f];
        
        
        
        
    }
    return self;
}

- (void)setData:(SFSObject *)data {
    self.hidden = NO;
    tot1 = [data getInt:@"tot1"];
    tot2 = [data getInt:@"tot2"];
    tn1 = [data getUtfString:@"tn1"];
    tn2 = [data getUtfString:@"tn2"];
    scoreArray = [data getSFSArray:@"scores"];
    [scoreTable reloadData];
    [self performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:5.0];
    scoreLabel.text = [Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].SCORE;

    
}


- (void)cancelButtonAction:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    cell = nil;
    if (cell == nil) {
        
        
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell = [[ScoreTableViewCell alloc] initWithType:0 Mast:0];
            cell.score1Label.text = tn1;
            cell.score2Label.text = tn2;
            cell.score1Label.numberOfLines = 2;
            cell.score2Label.numberOfLines = 2;
            cell.score1Label.frame = CGRectMake(100, 0, 140, 36);
            cell.score2Label.frame = CGRectMake(240, 0, 140, 36);

            cell.contraLabel.hidden = YES;
            cell.reContreLabel.hidden = YES;
        } else if (indexPath.row == [scoreArray size] + 1) {
            cell = [[ScoreTableViewCell alloc] initWithType:0 Mast:0];
            cell.score1Label.text = [NSString stringWithFormat:@"%d",tot1];
            cell.score2Label.text = [NSString stringWithFormat:@"%d",tot2];
            cell.contraLabel.hidden = YES;
            cell.reContreLabel.hidden = YES;
            cell.score1Label.frame = CGRectMake(100, 0, 140, 25);
            cell.score2Label.frame = CGRectMake(240, 0, 140, 25);
            cell.contentView.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:184.0f/255.0f blue:31.0f/255.0f alpha:1.0f];
            cell.score1Label.font = [UIFont boldSystemFontOfSize:15];
            cell.score2Label.font = [UIFont boldSystemFontOfSize:15];

        } else {
            SFSObject *hashvehatik = [scoreArray getSFSObject:indexPath.row -1];
            int r1 = [hashvehatik getInt:@"r1"];
            int r2 = [hashvehatik getInt:@"r2"];
            BOOL c = [hashvehatik getBool:@"c"];
            BOOL r = [hashvehatik getBool:@"r"];
            int m = [hashvehatik getInt:@"m"];
            int t = [hashvehatik getInt:@"t"];
            
            cell = [[ScoreTableViewCell alloc] initWithType:t Mast:m];

           
            
            cell.score1Label.text = [NSString stringWithFormat:@"%d",r1];
            cell.score2Label.text = [NSString stringWithFormat:@"%d",r2];
            cell.contraLabel.hidden = !c;
            cell.reContreLabel.hidden = !r;
            cell.score1Label.frame = CGRectMake(100, 0, 140, 25);
            cell.score2Label.frame = CGRectMake(240, 0, 140, 25);
          //  cell.labelType.frame = CGRectMake(0, 0, 140, 25);
        }
        
        
        
        
    }
    
    
    return cell;
}


#pragma mark - Table View


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [scoreArray size] + 2;
    return count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 36;
    } else {
        return 25;
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
