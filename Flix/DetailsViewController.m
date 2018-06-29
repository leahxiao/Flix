//
//  DetailsViewController.m
//  Flix
//
//  Created by Leah Xiao on 6/28/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewController.h"


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (strong, nonatomic) NSMutableArray *favoriteMovies;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //assembles the poster url again
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    // turns the strng into a url
    NSURL *posterURL = [NSURL URLWithString: fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackDropURLString = [baseURLString stringByAppendingString:backdropURLString];
    
    NSURL *backDropURL = [NSURL URLWithString: fullBackDropURLString];
    [self.backdropView setImageWithURL:backDropURL];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    if([self.movie[@"vote_average"]doubleValue] >= 6.7){
        self.ratingLabel.textColor = UIColor.greenColor;
    }
    else if([self.movie[@"vote_average"]doubleValue] <= 3.3){
        self.ratingLabel.textColor = UIColor.redColor;
    }
    else{
        self.ratingLabel.textColor = UIColor.orangeColor;
    };
    self.ratingLabel.text = [NSString stringWithFormat:@"%@",  self.movie[@"vote_average"]];
    
    
    [self.titleLabel sizeToFit]; // adjusts so that evertyhing/ all text fits
     [self.synopsisLabel sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    // NSIndexPath *indexPath = [self.tableView indexPathForCell:moviePoster];
    TrailerViewController *trailerViewController = [segue destinationViewController];
   
    // NSDictionary *movieInfo = self.movie;
    trailerViewController.movieInfo = [self.movie[@"id"] stringValue];
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
