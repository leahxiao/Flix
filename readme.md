# Project 2 - *Flix*

**Flix** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **15-20** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x ] User can view a list of movies currently playing in theaters from The Movie Database.
- [ x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [ x] User sees a loading state while waiting for the movies API.
- [ x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [ ] User sees an error message when there's a networking error.
- [x ] Movies are displayed using a CollectionView instead of a TableView.
- [ x] User can search for a movie.
- [ ] All images fade in as they are loading.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [ x] Customize the navigation bar.
- [x ] Customize the UI.

The following **additional** features are implemented:

- [x ] List anything else that you can get done to improve the app functionality!
    -settings page that can make all movies sorted alphabetically with a switch flip (and set it back to normal if the switch is flipped again)

    -the gridview shows kids movies instead of "now playing " movies
    - the details page shows movie ratings and the color of the rating text changes depending on the rating of the movie (good is green, medium is orange, bad is red)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. using user defaults as an easy way to pass info between view controllers
2. extend app by allowing user to make theri own experience through favoriting (currently a work in progress)

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/gIJXTr1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

- it was difficult figuring out how to progamatically link events with segues 
- passing information between view controllers/ each other/ elements was a challenge because it was easy to forget to import or create an outlet, etc. 
-creating favorites was a challenge. at the current moment, favorites is being correctly identified and added to the movie structure to be added to the table view cell
            -to do:
                    - properly upload the information into the cell 
                    - implement the 'swipe to delete from favorites' function to the 'favorites' view controller 
                    (how to found here: https://medium.com/ios-os-x-development/enable-slide-to-delete-in-uitableview-9311653dfe2)

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

Copyright [yyyy] [name of copyright owner]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.