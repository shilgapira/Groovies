/*

 Copyright 2012 Javier Soto (javi@mindsnacks.com)

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#ifdef DEBUG

#import <UIKit/UIKit.h>

/**
 * @discussion this makes MSVCLeakHunter print logs when view controllers appear, disappear and are deallocated.
 * This helps you track down the lyfe cycle of your view controllers.
 * `MSVCLeakHunter_ENABLED` has to be set to 1 for this to work too.
 */
#define MSVCLeakHunter_EnableUIViewControllerLog 0

/**
 * @discussion if a view controller hasn't been deallocated after this time after it disappeared from screen, it's considered "pottentially leaked", and a message in the log will be printed. 
 * Tweak this value depending on the characteristics of your app.
 */
#define kMSVCLeakHunterDisappearAndDeallocateMaxInterval 10.0f

/**
 * @discussion when installed, it's going to print messages in the log whenever a view controller is not deallocated after `kMSVCLeakHunterDisappearAndDeallocateMaxInterval` seconds of disappearing from screen.
 */
@interface MSVCLeakHunter : NSObject

/**
 * @discussion installs the appropiate hooks on UIViewController to start tracking the controllers.
 * You have to call this method for MSVCLeakHunter to start doing its job.
 * It's recommended to call this method in your `applicationDidFinishLaunchingWithOptions:` method.
 */
+ (void)install;

@end

#endif
