
#import "ABI44_0_0RNCAppearanceProvider.h"

@interface ABI44_0_0RNCAppearanceProvider ()

@property (nonatomic, weak) ABI44_0_0RCTBridge *bridge;

@end

@implementation ABI44_0_0RNCAppearanceProvider

- (instancetype)initWithBridge:(nonnull ABI44_0_0RCTBridge *)bridge
{
  if (self = [super init]) {
    _bridge = bridge;
  }
  return self;
}

#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && defined(__IPHONE_13_0) && \
    __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
  [super traitCollectionDidChange:previousTraitCollection];

  if (@available(iOS 13.0, *)) {
    if ([previousTraitCollection hasDifferentColorAppearanceComparedToTraitCollection:self.traitCollection]) {
      // note(brentvatne):
      // When backgrounding the app, perhaps due to a bug on iOS 13 beta the
      // user interface style changes to the opposite color scheme and then back to
      // the current color scheme immediately afterwards. I'm not sure how to prevent
      // this so instead I debounce the notification calls by 10ms.
      [NSObject cancelPreviousPerformRequestsWithTarget:self selector: @selector(notifyUserInterfaceStyleChanged) object:nil];
      [self performSelector:@selector(notifyUserInterfaceStyleChanged) withObject:nil afterDelay:0.01];
    }
  }
}

- (void)notifyUserInterfaceStyleChanged
{
  // @tsapeta: Check whether bridge object still exists (it's weakly-referenced) as it could have been released (we don't want to post a notification to `nil`).
  if (self.bridge) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ABI44_0_0RNCUserInterfaceStyleDidChangeNotification"
                                                        object:self.bridge
                                                      userInfo:@{@"traitCollection": self.traitCollection}];
  }
}
#endif

@end
