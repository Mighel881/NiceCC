static BOOL enabled = true;
static double roundStyle = 0;

@interface CCUIRoundButton : UIControl <UIGestureRecognizerDelegate>
@end

%hook CCUIRoundButton

-(double)_cornerRadius {
	if(enabled) {
		if(roundStyle == 0) {
			return %orig;
		} else {
			if(roundStyle == 1) {
				return 0.0;
			} else {
				return 10.0;
			}
		}
	} else {
		//Original
		return %orig;
	}
}

%end	

/*
CCUIConnectivityModuleViewController
MediaControlsPanelViewController
PowerUIModuleContentViewController
*/

static void loadPreferences() {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.conorthedev.niceccprefs.plist"];
	NSLog(@"NiceCC: reading prefs");
	if (prefs) {
		enabled = [prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : enabled;
		roundStyle = [prefs objectForKey:@"roundStyle"] ? [[prefs objectForKey:@"roundStyle"] intValue] : roundStyle;
	}
	[prefs release];
}

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.conorthedev.niceccprefs/updated"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadPreferences();
}