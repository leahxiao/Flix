//
//  favoritesViewController.m
//  Flix
//
//  Created by Leah Xiao on 6/29/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "favoritesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"


@interface favoritesViewController ()
@property (nonatomic, strong) NSMutableArray *movies;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation favoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchMovies];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

-(void) fetchMovies{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.movies = [defaults objectForKey:@"favorites"]; // opening key
    
    [self.tableView reloadData];

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    //self.moviesAlpha= [self.movies sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString: fullPosterURLString];
    //cell.posterView.image= nil; // clear out any old image from the cell
    [cell.posterView setImageWithURL:posterURL];
    // cell.textLabel.text = movie[@"title"];
    NSLog(@"%@", cell.titleLabel.text);
    NSLog(@"%@", cell.synopsisLabel.text);
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
