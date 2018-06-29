//
//  MoviesViewController.m
//  Flix
//
//  Created by Leah Xiao on 6/27/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "SettingsViewController.h"
// need this so you can get/ pass info/ porperties back and forth to this separate view controller (cast it below)

@interface MoviesViewController () 

@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) NSArray *filteredMovies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
//@property (nonatomic, strong) NSArray *moviesAlpha;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //calls this immediately when screnn loads up
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init]; // sees how much pull, when should be triggered
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged]; //stop triggered status, crate a target actin pair with the event that you choose
    [self.tableView addSubview:self.refreshControl]; // do insert subview if you want it to go behind instead of in front of table (at index 0)
 //   self.filteredMovies = self.movies;
    
   
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bool isAlphaOn = [defaults boolForKey:@"isSwitchOn" ];
    
    if(isAlphaOn){
        // block that sorts
        [self.movies sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
            NSString *stringOne = obj1[@"title"];
            NSString *stringTwo = obj2[@"title"];
            NSComparisonResult result = [stringOne compare:stringTwo];
            return result;
        }];
       
        
   }
    else{
        [self.movies sortUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
            NSString *stringOne = obj1[@"popularity"];
            NSString *stringTwo = obj2[@"popularity"];
            NSComparisonResult result = [stringOne compare:stringTwo];
            return result;
        }];
    };
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredMovies.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableCell"
//                                                                 forIndexPath:indexPath];
//    cell.textLabel.text = self.filteredMovies[indexPath.row];
//
//    return cell;
//}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject [@"title"] containsString:searchText];
        }];
        self.filteredMovies = [self.movies filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@", self.filteredMovies);
        
    }
    else {
        self.filteredMovies = self.movies;
    }
    
    [self.tableView reloadData];
    
}


- (void) fetchMovies{
        NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else { // api gave something back, turn the JSON into an objc dict
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
               

                self.movies = [dataDictionary[@"results"] mutableCopy];
                self.filteredMovies = self.movies;
                
//                for (NSDictionary *movie in self.movies) {
//                    NSLog(@"%@*", movie[@"title"]);
//                }
                [self.tableView reloadData];
            }
            // TODO: Reload your table view data
            [self.refreshControl endRefreshing]; //pair
        }];
    
        [task resume];
    
}



//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.movies.count;
//    // num movies
//}

// putting the title and synopsis and image in each cell, this is essentially one of those two special methods that you needed. this is the "filler-up" method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    //self.moviesAlpha= [self.movies sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
  
   
    NSDictionary *movie = self.filteredMovies[indexPath.row];
    
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString: fullPosterURLString];
    //cell.posterView.image= nil; // clear out any old image from the cell
    [cell.posterView setImageWithURL:posterURL];
    // cell.textLabel.text = movie[@"title"];
    return cell;
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender { // sender is the generic term for the thing that fired the event
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString: @"settingsTransition"]){
//        SettingsViewController *settingsViewController = [segue destinationViewController];
//        settingsViewController.moviesViewController = self;
        
    }
    else{
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        NSDictionary *movie = self.movies[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController]; //cast that detail view controller
        detailsViewController.movie = movie; // just pass over the one movie, not configure views of details of view controller
    }
    
   
    
}


@end
