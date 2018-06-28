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
#import "DetailsViewController.h" // need this so you can get/ pass info/ porperties back and forth to this separate view controller (cast it below)

@interface MoviesViewController () 

@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //calls this immediately when screnn loads up
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init]; // sees how much pull, when should be triggered
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged]; //stop triggered status, crate a target actin pair with the event that you choose
    [self.tableView addSubview:self.refreshControl]; // do insert subview if you want it to go behind instead of in front of table (at index 0)
    
    // TODO: Get the array of movies
    // TODO: Store the movies in a property to use elsewhere

//    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (error != nil) {
//            NSLog(@"%@", [error localizedDescription]);
//        }
//        else { // api gave something back
//            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            self.movies = dataDictionary[@"results"];
//
//            for (NSDictionary *movie in self.movies) {
//                NSLog(@"%@*", movie[@"title"]);
//            }
//            [self.tableView reloadData];
//        }
//        // TODO: Reload your table view data
//
//
//    }];
//
//    [task resume];
    
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
                self.movies = dataDictionary[@"results"];
    
                for (NSDictionary *movie in self.movies) {
                    NSLog(@"%@*", movie[@"title"]);
                }
                [self.tableView reloadData];
            }
            // TODO: Reload your table view data
            [self.refreshControl endRefreshing]; //pair
        }];
    
        [task resume];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count; // num movies
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
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
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender { // sender is the generic term for the thing that fired the event
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
    DetailsViewController *detailsViewController = [segue destinationViewController]; //cast that detail view controller
    detailsViewController.movie = movie; // just pass over the one movie, not configure views of details of view controller
    
   
    
}


@end
