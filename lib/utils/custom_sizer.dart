import 'package:flutter/widgets.dart';

class Sizer{
  // Store the screen dimensions and orientation
  late double screenWidth;
  late double screenHeight;
  late double textScaleFactor;
  bool isLandscape = false;

  // Breakpoints for different screen sizes
  double baseWidth = 375; // Standard width for phones (e.g., iPhone 11)
  double baseHeight = 812; // Standard height for phones (e.g., iPhone 11)

  // Initialization method to calculate the screen size and orientation
  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Detect orientation based on screen width and height
    isLandscape = screenWidth > screenHeight;

    // Handle breakpoints for larger devices
    if (screenWidth >= 1024) {
      // Desktop or large tablet screen (1024+ width)
      baseWidth = 1440; // Base design width for desktop (e.g., Full HD screens)
      baseHeight = 900; // Base design height for desktop
    } else if (screenWidth >= 768) {
      // Tablet screens (portrait or landscape)
      baseWidth = 768; // Base design width for tablets
      baseHeight = 1280; // Base design height for tablets
    } else {
      // Mobile screens (portrait or landscape)
      baseWidth = 375; // Base design width for phones
      baseHeight = 812; // Base design height for phones
    }
  }

  // Scaling method for width based on the screen size
  double setWidth(double width) {
    return width * (screenWidth / baseWidth); // Scale based on device width
  }

  // Scaling method for height based on the screen size
  double setHeight(double height) {
    return height * (screenHeight / baseHeight); // Scale based on device height
  }

  // Scaling method for font size (text size)
  double setSp(double fontSize) {
    return fontSize *
        (screenWidth / baseWidth); // Scale text based on screen width
  }

  // Adjust text size based on the orientation (optional)
  double adjustTextForOrientation(double fontSize) {
    if (isLandscape) {
      return fontSize * 1.1; // Slightly increase text size in landscape
    } else {
      return fontSize; // Use regular size in portrait
    }
  }

  // Get device's text scaling factor (for accessibility)
  double getTextScaleFactor() {
    return textScaleFactor;
  }

  // Additional method for checking if the device is a mobile or desktop/tablet
  bool isMobileDevice() {
    return screenWidth <
        768; // Devices smaller than 768px are considered mobile
  }

  bool isTablet() {
    return screenWidth >= 768 &&
        screenWidth < 1024; // Devices between 768px and 1024px are tablets
  }

  bool isDesktop() {
    return screenWidth >=
        1024; // Devices with width 1024px or larger are considered desktops
  }

  bool get isPortrait =>
      screenHeight >= screenWidth;
}
