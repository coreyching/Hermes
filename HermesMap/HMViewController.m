#import "HMViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <AVFoundation/AVFoundation.h>


@interface HMViewController () {
  GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
}

@end

@implementation HMViewController

- (void)viewDidLoad {
  [super viewDidLoad];


  // Position the camera at 0,0 and zoom level 1.
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:48.8567                                                           longitude:2.3508
                                                               zoom:14];

  // Create the GMSMapView with the camera position.
  mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    self.view = mapView_;
    
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });

  // Set the controller view to be the MapView. 
  self.view = mapView_;
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(48.842454,2.3288476);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"Food";
    marker.icon = [UIImage imageNamed:@"icons_NovoselLucian_Artboard50"];
    marker.map = mapView_;
    
    CLLocationCoordinate2D position2 = CLLocationCoordinate2DMake(48.855712,2.287751);
    GMSMarker *marker2 = [GMSMarker markerWithPosition:position2];
    marker2.title = @"Arts";
    marker2.icon = [UIImage imageNamed:@"icons_NovoselLucian-24.png"];
    marker2.map = mapView_;
    
    CLLocationCoordinate2D position3 = CLLocationCoordinate2DMake(48.836038,2.376094);
    GMSMarker *marker3 = [GMSMarker markerWithPosition:position3];
    marker3.title = @"Parks and Attractions";
    marker3.icon = [UIImage imageNamed:@"icons_NovoselLucian_Artboard 32 copy (1).png"];
    marker3.map = mapView_;


    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
   // AVSpeechSynthesizer *synthesizer1 = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"The Mayor of Paris once promised to make the river Siene safe to swim in. Although he never fulfilled his promise, he constructed the Piscene so that his citizens could at least swim on the Siene. The glass building hosts a gym, cafe, and sundeck along with the olympic-sized pool. "];
    utterance.rate = 0.2;
    utterance.postUtteranceDelay = 3;
    ; // higher pitch
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    [synthesizer speakUtterance:utterance];
    
    
    AVSpeechUtterance *utterance1 = [AVSpeechUtterance speechUtteranceWithString:@"The name L'Entrecôte has come to identify three iconic groups of restaurants owned by two sisters and one brother. The choices are steak or steak, and the supply of golden fries is unending."];
    utterance1.rate = 0.2;
    utterance1.postUtteranceDelay = 3;
    ; // higher pitch
    utterance1.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    [synthesizer speakUtterance:utterance1];
//
//    
    AVSpeechUtterance *utterance2 = [AVSpeechUtterance speechUtteranceWithString:@"Le pont de Bir-Hakeim, anciennement pont de Passy, ​​est un pont qui enjambe la Seine, à Paris, France. Beaucoup de films ont présenté ce pont dont Zazie dans le Métro, Le Dernier Tango à Paris, et de création."];
    utterance2.rate = 0.2
    ; // higher pitch
    utterance2.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"fr-FR"];
    [synthesizer speakUtterance:utterance2];
   
}

- (void)dealloc {
    [mapView_ removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
}



- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}



@end
